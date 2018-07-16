using UnityEngine;
using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Collections;
using System.Collections.Generic;
using LuaFramework;
using Game.Util;
using System.Threading;
using LuaInterface;
using UnityEngine.UI;

public enum DisType
{
    Exception,
    Disconnect,
}

public class SocketClient
{
    private Socket socket = null;
    private NetworkStream outStream = null;
    private MemoryStream memStream;
    private BinaryReader reader;

    private const int MAX_READ = 512000;
    private byte[] byteBuffer = new byte[MAX_READ];
    public bool isConnect
    {
        get
        {
            return socket != null && socket.Connected;
        }
    }
    private Thread socketThread = null;

    // Use this for initialization
    public SocketClient()
    {
        //Image image;
        //image.rectTransform.localScale = 
        memStream = new MemoryStream();
        reader = new BinaryReader(memStream);
    }

    private void SocketUpdate()
    {
        receiveData();
    }

    /// <summary>
    /// 移除代理
    /// </summary>
    public void OnRemove()
    {
        Close();
        reader.Close();
        memStream.Close();
    }

    //判断字符串是否为数字
    private bool isNumberic(string message, out int result)
    {
        System.Text.RegularExpressions.Regex rex =
        new System.Text.RegularExpressions.Regex(@"^\d+$");
        result = -1;
        if (rex.IsMatch(message))
        {
            result = int.Parse(message);
            return true;
        }
        else
            return false;
    }

    /// <summary>
    /// 连接服务器
    /// </summary>
    public bool ConnectServer(string host, int port)
    {
        try
        {
            IPAddress ipAddress;
            string[] ipArr = host.Split('.');
            int result = 1000;
            //判断字符串是否为数字
            bool isNumberic = this.isNumberic(ipArr[0], out result);
            if (isNumberic && result >= 0 && result <= 255)
            {
                ipAddress = IPAddress.Parse(host);
            }
            else
            {
                IPHostEntry ipHostInfo = Dns.GetHostEntry(host);
                ipAddress = ipHostInfo.AddressList[0];
            }
            IPEndPoint ipEndPoint = new IPEndPoint(ipAddress, port);
            socket = new Socket(ipEndPoint.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
            socket.Connect(ipEndPoint);
            bool connected = socket.Connected;
            if (connected)
            {
                Debug.Log("Network Connected! ");
                socketThread = new Thread(SocketUpdate);
                socketThread.IsBackground = true;
                socketThread.Start();

                // outStream = socket.GetStream();
                // NetworkManager.AddEvent(Protocal.Connect, new ByteBuffer());
                Util.CallMethod("Network", "OnConnect");
            }
            return connected;
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
            AddExceptionMsg("Connect failed! ConnectServer");
            return false;
        }
    }

    private void AddExceptionMsg(string msg, int errorType = 0)
    {
        //断开socket连接
        Close();
        //打印错误日志
        Debug.Log(msg);
    }

    /// <summary>
    /// 写数据
    /// </summary>
    void WriteMessage(byte[] message)
    {
        //change by ly; 包结构进行修改； int 长度 + int 协议号 + 内容；
        MemoryStream ms = null;
        using (ms = new MemoryStream())
        {
            ms.Position = 0;

            BinaryWriter writer = new BinaryWriter(ms);

            int msglen = (int)message.Length;
            Byte[] msgLenBytes = Util.int2bytes(msglen);
            writer.Write(msgLenBytes);
            writer.Write(message);
            writer.Flush();

            byte[] payload = ms.ToArray();
            sendData(payload, 30000);
            // outStream.Write(payload, 0, payload.Length);
            string str = "";
            for (int i = 0; i < message.Length; i++)
                str += message[i].ToString() + " ";
            Debug.Log("WriteMessage............." + str);
        }
    }

    /// <summary>
    /// 向远程主机发送数据
    /// </summary>
    /// <param name="socket">连接到远程主机的socket</param>
    /// <param name="buffer">待发送数据</param>
    /// <param name="outTime">发送超时时长，单位是秒(为-1时，将一直等待直到有数据需要发送)</param>
    /// <returns>0:发送成功；-1:超时；-2:出现错误；-3:出现异常</returns>
    private int sendData(byte[] buffer, int outTime)
    {
        if (socket == null || socket.Connected == false) return -3;
        int flag = 0;

        try
        {
            if (buffer == null || buffer.Length == 0) throw new ArgumentException("参数buffer为null ,或者长度为 0");

            int left = buffer.Length; int sndLen = 0; int hasSend = 0;


            while (true)
            {
                if ((socket.Poll(outTime * 1000, SelectMode.SelectWrite) == true))
                {
                    // 收集了足够多的传出数据后开始发送
                    sndLen = socket.Send(buffer, hasSend, left, SocketFlags.None);
                    left -= sndLen;
                    hasSend += sndLen;

                    // 数据已经全部发送
                    if (left == 0)
                    {
                        flag = 0;
                        break;
                    }
                    else
                    {
                        // 数据部分已经被发送
                        if (sndLen > 0)
                        {
                            continue;
                        }
                        else // 发送数据发生错误
                        {
                            flag = -2;
                            break;
                        }
                    }
                }
                else // 超时退出
                {
                    flag = -1;
                    break;
                }
            }
        }
        catch (Exception err)
        {
            flag = -3;
            // currErrorStat = SocketError.ERROR_EXCEPTION;
            //DebugUtil.log("SocketController.sendMsg:" + err.ToString());
            // MsgManager.addCommand("1|" + ECNLocalization.Get("发送socket数据包异常，请检查您发的数据！"));                //添加消息命令
        }
        return flag;
    }


    /// <summary>
    /// 接受数据
    /// </summary>
    private int receiveFlag = 0;
    public void receiveData()
    {
        while (true)
        {
            receiveFlag = recvData(socket, -1);
            if (receiveFlag == -3)
                return;
        }
    }




    /// <summary>
    /// 接收远程主机发送的数据
    /// </summary>
    /// <param name="socket">要接收数据且已经连接到远程主机的</param>                                                                                                                                                                               
    /// <param name="buffer">接收数据的缓冲区(需要接收的数据的长度，由 buffer 的长度决定)</param>
    /// <param name="outTime">接收数据的超时时间，单位秒(指定为-1时，将一直等待直到有数据需要接收)</param>
    /// <returns>0:接收成功；-1:超时；-2:出现错误；-3:出现异常</returns>
    public int recvData(Socket socket, int outTime)
    {
        if (!isConnect)
        {
            Debug.Log("==============Network Disconnect");
            return -3;
        }

        byteBuffer.Initialize();
        int left = byteBuffer.Length;
        int curRecv = 0;
        int hasRecv = 0;
        int length = 0;

        try
        {
            while (true)
            {
                //MonoBehaviour.print("<color=red>socket.Connected=</color>" + socket.Connected);
                if (socket.Poll(outTime * 1000000, SelectMode.SelectRead) == true)
                {
                    //MonoBehaviour.print("<color=red>socket.Receive</color>");
                    curRecv = socket.Receive(byteBuffer, hasRecv, left, SocketFlags.None);
                    Debug.Log("=======socket.Receive " + curRecv + " " + hasRecv + " " + left);
                    // string str = "";
                    // for(int i = 0; i < curRecv; i++)
                    //     str += byteBuffer[i] + " ";
                    // Debug.Log("============socket.Receive Bytes " + str);

                    if (curRecv == 0)
                    {
                        //DebugUtil.log("接收数据出现错误,receive的字节长度为0!");
                        //GameApp.dataCache.errorData.SERVER_ERROR = eServerError.ERROR_EXCEPTION;
                        //throw new ArgumentException("接收数据出现错误,receive的字节长度为0!");
                        Debug.Log("==============recvData curRecv==0");
                        throw new ArgumentException("recvData curRecv==0");
                    }
                    left -= curRecv;
                    hasRecv += curRecv;

                    int dataLength = 0;
                    Boolean breakBol = false;
                    do
                    {
                        byte[] intByte = new byte[] { byteBuffer[length], byteBuffer[length + 1], byteBuffer[length + 2], byteBuffer[length + 3] };
                        dataLength = ByteUtil.getInt(intByte, false);

                        Debug.Log("====receive do " + hasRecv + " " + length + " " + dataLength);

                        if ((length + dataLength + 4) <= hasRecv)
                        {
                            byte[] rContent = new byte[dataLength];

                            for (int i = 0; i < dataLength; i++)
                            {
                                //rContent[i] = _buffer[length + 9 + i];
                                rContent[i] = byteBuffer[length + 4 + i];
                            }

                            length += 4;
                            length += dataLength;


                            OnReceive(rContent, dataLength);

                            // receiveCallback(rContent, 0, 0);


                            if (length == hasRecv)
                            {
                                return 0;
                            }
                        }
                        else
                        {
                            Debug.Log("==========Need Join Pack");
                            breakBol = true;
                        }

                    } while (length < hasRecv && !breakBol);
                }
                // else
                // {
                //     Debug.Log("=========Socket Timeout");
                //     Close();
                //     return -3;
                // }
            }
        }
        catch (Exception err)
        {
            //GameApp.dataCache.errorData.SERVER_ERROR = eServerError.ERROR_EXCEPTION;
            //添加异常消息
            // addExceptionMsg(ECNLocalization.Get("网络连接异常，请检查您的网络！"));
            Debug.Log("========SocketClient error: " + err.Message);
            AddExceptionMsg("Connect failed! recvData");
        }
        return -1;
    }

    /// <summary>
    /// 接收到消息
    /// </summary>
    void OnReceive(byte[] bytes, int length)
    {
        byte[] dataByte = new byte[length - 4];
        Array.Copy(bytes, 4, dataByte, 0, length - 4);

        byte[] msgIdArr = new byte[4];
        Array.Copy(bytes, 0, msgIdArr, 0, 4);

        int msgId = ByteUtil.getInt(msgIdArr, false);

        //change by Ly ；根据服务器规则进行修改；长度（前4个字节） +协议号 + Pb(内容)；
        ByteBuffer buffer = new ByteBuffer(dataByte);
        Debug.Log("=========SocketClient OnReceive " + msgId);
        NetworkManager.AddEvent(msgId, buffer);
    }


    /// <summary>
    /// 打印字节
    /// </summary>
    /// <param name="bytes"></param>
    void PrintBytes()
    {
        string returnStr = string.Empty;
        for (int i = 0; i < byteBuffer.Length; i++)
        {
            returnStr += byteBuffer[i].ToString("X2");
        }
        Debug.LogError(returnStr);
    }

    /// <summary>
    /// 发送消息
    /// </summary>
    public void SendMessage(ByteBuffer buffer)
    {
        try
        {
            if (!isConnect)
            {
                Close();
                return;
            }

            //byte[] data=buffer.ToBytes();  

            //foreach (byte b in data)  
            //{  
            //    Debug.Log("=============================================================");
            //    Debug.Log(b);  //法1  
            //}  
            
            WriteMessage(buffer.ToBytes());
            buffer.Close();
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
            AddExceptionMsg("Connect failed! SendMessage");
        }
    }

    /// <summary>
    /// 关闭链接
    /// </summary>
    public void Close()
    {
        if (socket != null)
        {
            socket.Close();
            socket = null;
        }
        if (socketThread != null)
            socketThread.Abort();
    }
}
