using System;
using System.Collections.Generic;
using System.Net.Sockets;
using System.Runtime.InteropServices;
using System.Threading;

/// <summary>
/// 客户端的套接字类
/// </summary>
public class ClientSocket
{
    private Socket  m_ClientSocket      = null;
    private Thread  m_ReceiveThread     = null;
    private ushort  m_nPkgHeaderSize    = (ushort)Marshal.SizeOf(new CMD_Head());

    // 套接字读取钩子
    private List<ClientReadSink> m_ReadSinkList = new List<ClientReadSink>();

    public ClientSocket()
    {
        m_ClientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
    }

    /// <summary>
    /// 添加套接字读取钩子
    /// </summary>
    public void AddSocketReadSink(ClientReadSink sink)
    {
        m_ReadSinkList.Add(sink);
    }

    /// <summary>
    /// 移除套接字读取钩子
    /// </summary>
    public void RemoveSocketReadSink(ClientReadSink sink)
    {
        if (m_ReadSinkList.Contains(sink))
        {
            m_ReadSinkList.Remove(sink);
        }
    }

    /// <summary>
    /// 连接服务器
    /// </summary>
    public bool ConnectServer(string sServerIP, int nServerPort)
    {
        // 连接服务器
        try
        {
            m_ClientSocket.Connect(sServerIP, nServerPort);
        }
        catch (Exception ex)
        {
            ClientDelegate.OnShowMsgEvent("连接错误:" + ex.Message);
            CloseSocket();
            return false;
        }

        // 开启接收服务器数据的线程
        m_ReceiveThread              = new Thread(ReceiveServerMsgThread);
        m_ReceiveThread.IsBackground = true;
        m_ReceiveThread.Start();

        // 发送第一个检测信号
		SendFirstMessage();
        
        return true;
    }


    /// <summary>
    /// 接收服务器的数据
    /// </summary>
    private void ReceiveServerMsgThread()
    {
        ushort      wCmdInfoSize    = (ushort)Marshal.SizeOf(new CMD_Info());
        ushort      wCmdSize        = (ushort)Marshal.SizeOf(new CMD_Command());
        byte[]      byCmdInfoArr    = new byte[wCmdInfoSize];   // 命令信息数组
        byte[]      byCmdArr        = new byte[wCmdSize];       // 命令数组
        byte[]      byBodyArr       = null;                     // 数据主体
        byte[]      byOneRevBuf     = new byte[1024];           // 每次接收数据的缓存
        int         nOneRevSize     = 0;                        // 每次接收数据的长度
	    byte[]	    byAllRevBuf     = new byte[1024 * 5];		// 总的接收数据缓冲
        ushort	    nAllRevSize     = 0;			            // 总的接收数据长度
        ushort      wPacketSize     = 0;                        // 数据包的长度
        byte[]      byCrevDataArr   = null;                     // 解密出来的数据数组
        CMD_Info    stCmdInfo;
        CMD_Command stCmd;

        while (m_ClientSocket.Connected)
        {
            try
            {
                nOneRevSize = m_ClientSocket.Receive(byOneRevBuf);
                if (nOneRevSize <= 0)
                {
                    m_ClientSocket.Close();
                    return;
                }

                // 缓存数据
                Array.Copy(byOneRevBuf, 0, byAllRevBuf, nAllRevSize, nOneRevSize);
                nAllRevSize += (ushort)nOneRevSize;

                while (nAllRevSize > wCmdInfoSize)
                {
                    // 获取数据头部信息
                    Array.Copy(byAllRevBuf, 0, byCmdInfoArr, 0, wCmdInfoSize);//version,checkcode,size
                    stCmdInfo   = ClientConstant.ByteToStructure<CMD_Info>(byCmdInfoArr);
                    wPacketSize = stCmdInfo.wPacketSize;

                    // 缓存的数据是否足够多，来解释出一个数据
                    if (nAllRevSize < wPacketSize)
                    {
                        break;
                    }

//					byte[] tmp = new byte[wPacketSize- wCmdInfoSize];// 
                    // 网狐映射解密数据
                    byte byCheckCode = stCmdInfo.cbCheckCode;
					for (int nI = 4; nI < wPacketSize ; nI++)//- wCmdInfoSize
                    {
						byAllRevBuf[nI] = WHMapEncrypt.MapRecvByte(byAllRevBuf[nI]);
						byCheckCode += byAllRevBuf[nI];
                    }

                    // 获取命令
					Array.Copy(byAllRevBuf, wCmdInfoSize, byCmdArr, 0, wCmdSize);
                    stCmd = ClientConstant.ByteToStructure<CMD_Command>(byCmdArr);


                    // 获取数据主体
                    byBodyArr = new byte[wPacketSize - wCmdInfoSize - wCmdSize];
					Array.Copy(byAllRevBuf, wCmdSize+wCmdInfoSize, byBodyArr, 0, byBodyArr.Length);


                    // 处理接收到的数据
                    HandleServerData(byCheckCode, stCmd.wMainCmdID, stCmd.wSubCmdID, byBodyArr);

                    // 清空这次被使用的数据
                    for (int nI = 0; nI < nAllRevSize - wPacketSize; nI++)
                    {
                        byAllRevBuf[nI] = byAllRevBuf[wPacketSize + nI];
                    }
                    nAllRevSize -= wPacketSize;
                }
            }
            catch(Exception ex)
            {
                ClientDelegate.OnShowMsgEvent("数据异常：" + ex.Message);
                m_ClientSocket.Close();
                break;
            }
        }
    }

    /// <summary>
    /// 处理服务器返回的消息
    /// </summary>
    private bool HandleServerData(byte byCheckCode, ushort nMainCmd, ushort nSubCmd, byte[] byBody)
    {
        if (byCheckCode != 0)
        {
            ClientDelegate.ShowMsgEvent("你的数据已经有误");
            return false;
        }
        switch ((EnRoomMainCmdID)nMainCmd)
        {
            case EnRoomMainCmdID.MDM_KN_COMMAND:                    //内核命令
                switch ((EnKNSubCmdID)nSubCmd)
                {
                    case EnKNSubCmdID.SUB_KN_DETECT_SOCKET:
                        SendMessage((ushort)EnRoomMainCmdID.MDM_KN_COMMAND, (ushort)EnKNSubCmdID.SUB_KN_DETECT_SOCKET);
                        break;
                    case EnKNSubCmdID.SUB_KN_SHUT_DOWN_SOCKET:
                        CloseSocket();
                        break;
                }
                break;
            default:
                foreach (ClientReadSink sink in m_ReadSinkList)
                {
                    if (sink != null)
                    {
                        sink.OnServerDataEvent(nMainCmd, nSubCmd, byBody);
                    }
                }
                break;
        }

        return true;
    }

	public void SendFirstMessage()
	{
		byte[] info = new byte[128];
		byte[] info2 = System.Text.Encoding.Unicode.GetBytes (Define.VALIDATE);
		Array.Copy (info2, info, info2.Length);
		SendFirstMessage(0, 2, info);
	}

    /// <summary>
    /// 发送命令
    /// </summary>
    public bool SendMessage(ushort wMainCmdID, ushort wSubCmdID)
    {
        CMD_NULL tagCMD_GP_NULL = new CMD_NULL();

        return SendMessage<CMD_NULL>(wMainCmdID, wSubCmdID, tagCMD_GP_NULL);
    }

    /// <summary>
    /// 向服务器发送数据(直接向服务器发送数据)
    /// </summary>
    public bool SendMessage<T>(ushort wMainCmdID, ushort wSubCmdID, T sendObj)
    {
        // 组装数据主体
        byte[] byBodyArr = null;

        try
        {
            byBodyArr = ClientConstant.StructureToByte<T>(sendObj);

            SendMessage(wMainCmdID, wSubCmdID, byBodyArr);
        }
        catch (Exception ex)
        {
            ClientDelegate.ShowMsgEvent("发送数据错误:" + ex.Message);
            return false;
        }

        return true;
    }
		

	/// <summary>
	/// 向服务器发送数据(直接向服务器发送数据)
	/// </summary>
	public bool SendMessage<T>(ushort wMainCmdID, ushort wSubCmdID, T sendObj,bool isLogon)
	{
		// 组装数据主体
		byte[] byBodyArr = new byte[Define.LOGONDATA_LEN];

		try
		{
			byte[] cbyBodyArr = ClientConstant.StructureToByte<T>(sendObj);

			Array.Copy(cbyBodyArr, byBodyArr, cbyBodyArr.Length);
			SendMessage(wMainCmdID, wSubCmdID, byBodyArr);
		}
		catch (Exception ex)
		{
			ClientDelegate.ShowMsgEvent("发送数据错误:" + ex.Message);
			return false;
		}

		return true;
	}

    /// <summary>
    /// 向服务器发送数据(直接向服务器发送数据)
    /// </summary>
    public bool SendMessage(ushort wMainCmdID, ushort wSubCmdID, byte[] byBodyArr)
    {
        bool        bResult         = false;
        CMD_Info    stCmdInfo       = new CMD_Info();
        CMD_Command stCmd           = new CMD_Command();
        byte[]      byEncryBuf      = null;                 // 需要加密的数据的数组
        byte[]      byCmdArr        = null;                 // 命令数组
        byte[]      byCmdInfoArr    = null;                 // 命令信息数组
        byte[]      bySendArr       = null;                 // 需要发送的数据
        ushort      wPacketSize     = 0;                    // 发送数据的包长
        uint        nFirstXorKey    = 123;                  // 第一次发送数据需要生成的密钥

        if (m_ClientSocket == null || !m_ClientSocket.Connected)
        {
            ClientDelegate.ShowMsgEvent("Socket已经关闭");
            return false;
        }

        try
        {
            // 组装命令体
            stCmd.wMainCmdID = wMainCmdID;
            stCmd.wSubCmdID  = wSubCmdID;
            byCmdArr = ClientConstant.StructureToByte<CMD_Command>(stCmd);
		
            // 组合需要加密的数据
            byEncryBuf = new byte[byCmdArr.Length + byBodyArr.Length];
            Array.Copy(byCmdArr, 0, byEncryBuf, 0, byCmdArr.Length);
            Array.Copy(byBodyArr, 0, byEncryBuf, byCmdArr.Length, byBodyArr.Length);

            // 网狐映射加密数据
            byte byCheckCode = 0;
            for (int nI = 0; nI < byEncryBuf.Length; nI++)
            {
                byCheckCode += byEncryBuf[nI];
                byEncryBuf[nI] = WHMapEncrypt.MapSendByte(byEncryBuf[nI]);
            }

            // 数据长度
			wPacketSize = (ushort)(byBodyArr.Length + m_nPkgHeaderSize);

            // 组装命令信息体
            stCmdInfo.cbVersion =0x01;//0x66
			stCmdInfo.cbCheckCode =(byte)(~byCheckCode + (byte)1);//247
            stCmdInfo.wPacketSize = wPacketSize;
            byCmdInfoArr = ClientConstant.StructureToByte<CMD_Info>(stCmdInfo);

            // 整合发送的数据
            bySendArr = new byte[byCmdInfoArr.Length + byEncryBuf.Length];
            Array.Copy(byCmdInfoArr, 0, bySendArr, 0, byCmdInfoArr.Length);
            Array.Copy(byEncryBuf, 0, bySendArr, byCmdInfoArr.Length, byEncryBuf.Length);

          
            m_ClientSocket.Send(bySendArr);
        }
        catch (Exception ex)
        {
            ClientDelegate.ShowMsgEvent("发送数据错误:" + ex.Message);
            goto Exit0;
        }

        bResult = true;
    Exit0:
        return bResult;
    }

	/// <summary>
	/// 向服务器发送数据(直接向服务器发送数据)
	/// </summary>
	public bool SendFirstMessage(ushort wMainCmdID, ushort wSubCmdID, byte[] byBodyArr)
	{
		bool        bResult         = false;
		CMD_Info    stCmdInfo       = new CMD_Info();
		CMD_Command stCmd           = new CMD_Command();
		byte[]      byEncryBuf      = null;                 // 需要加密的数据的数组
		byte[]      byCmdArr        = null;                 // 命令数组
		byte[]      byCmdInfoArr    = null;                 // 命令信息数组
		byte[]      bySendArr       = null;                 // 需要发送的数据
		ushort      wPacketSize     = 0;                    // 发送数据的包长


		if (m_ClientSocket == null || !m_ClientSocket.Connected)
		{
			ClientDelegate.ShowMsgEvent("Socket已经关闭");
			return false;
		}

		try
		{
			// 组装命令体
			stCmd.wMainCmdID = wMainCmdID;
			stCmd.wSubCmdID  = wSubCmdID;
			byCmdArr = ClientConstant.StructureToByte<CMD_Command>(stCmd);

			// 组合需要加密的数据
			byEncryBuf = new byte[byCmdArr.Length + byBodyArr.Length];//
			Array.Copy(byCmdArr, 0, byEncryBuf, 0, byCmdArr.Length);
			Array.Copy(byBodyArr, 0, byEncryBuf, byCmdArr.Length, byBodyArr.Length-byCmdArr.Length);

			// 网狐映射加密数据
			byte byCheckCode = 0;
			for (int nI = 0; nI < byEncryBuf.Length; nI++)
			{
				byCheckCode += byEncryBuf[nI];
				byEncryBuf[nI] = WHMapEncrypt.MapSendByte(byEncryBuf[nI]);
			}

			// 数据长度
			wPacketSize = (ushort)(byBodyArr.Length + m_nPkgHeaderSize);

			// 组装命令信息体
			stCmdInfo.cbVersion =0x01;//0x66
			stCmdInfo.cbCheckCode =(byte)(~byCheckCode + (byte)1);
			stCmdInfo.wPacketSize = wPacketSize;
			byCmdInfoArr = ClientConstant.StructureToByte<CMD_Info>(stCmdInfo);

			// 整合发送的数据
			bySendArr = new byte[byCmdInfoArr.Length + byEncryBuf.Length];
			Array.Copy(byCmdInfoArr, 0, bySendArr, 0, byCmdInfoArr.Length);
			Array.Copy(byEncryBuf, 0, bySendArr, byCmdInfoArr.Length, byEncryBuf.Length);

			m_ClientSocket.Send(bySendArr);
		}
		catch (Exception ex)
		{
			ClientDelegate.ShowMsgEvent("发送数据错误:" + ex.Message);
		}

		bResult = true;
		return bResult;
	}
    /// <summary>
    /// 检查是否保持连接
    /// </summary>
    public bool IsConnected()
    {
        return m_ClientSocket.Connected;
    }

    /// <summary>
    /// 关闭连接
    /// </summary>
    public void CloseSocket()
    {
        if (m_ClientSocket == null)
        {
            return;
        }

        if (!m_ClientSocket.Connected)
        {
            m_ClientSocket = null;
            return;
        }

        m_ClientSocket.Shutdown(SocketShutdown.Both);
        m_ClientSocket.Close();

        ClientDelegate.OnShowMsgEvent("关闭了socket");
    }
}