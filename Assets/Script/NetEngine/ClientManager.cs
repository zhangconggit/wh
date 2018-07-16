using System;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine;
using System.Collections.Generic;
using System.Collections;

/// <summary>
/// 房间类
/// </summary>
public class ClientManager : MonoBehaviour, ClientReadSink
{
    public  string          m_szServerIP    = "192.168.5.13";//39.105.113.193
    public  int             m_nPort         = 8600;
    private ClientSocket    m_RoomSocket    = null;
    private ClientUser      m_Owner         = null;
    private ClientUserList  m_UserList      = null;
    private int             m_wServerKindID;                // 游戏KIND_ID
    private byte            m_cbAllowLookon;                // 是否允许旁观
    private byte            m_cbGameStatus;                 // 游戏状态

    private Queue<ServerDataItem> m_ServerDataQueue = new Queue<ServerDataItem>();

    public void Awake()
    {
        m_RoomSocket    = ClientGlobal.GetInstance().GetRoomSocket();
        m_UserList      = ClientGlobal.GetInstance().GetUserList();
        m_Owner         = ClientGlobal.GetInstance().GetOwner();
        m_RoomSocket.AddSocketReadSink(this);
    }

    public void Start()
    {
        bool bRetCode = false;

        // 连接服务器
        bRetCode = m_RoomSocket.ConnectServer(m_szServerIP, m_nPort);
        if (!bRetCode)
        {
            ClientDelegate.OnShowMsgEvent("连接房间服务器失败");
            return;
        }
        ClientDelegate.OnShowMsgEvent("连接房间服务器成功");

        // 启动处理协程
        StartCoroutine(OnHanleDataFiber());
    }

    void OnEnable()
    {
        ClientDelegate.ShowMsgEvent += ShowLog;
    }

    void OnDisable()
    {
        ClientDelegate.ShowMsgEvent -= ShowLog;
    }

    /// <summary>
    /// 发送消息
    /// </summary>
    public bool SendMessage(ushort wMainCmdID, ushort wSubCmdID)
    {
        return m_RoomSocket.SendMessage(wMainCmdID, wSubCmdID);
    }

    /// <summary>
    /// 发送消息
    /// </summary>
    public bool SendMessage<T>(ushort wMainCmdID, ushort wSubCmdID, T sendObj)
    {
		return m_RoomSocket.SendMessage<T>(wMainCmdID, wSubCmdID, sendObj,true);
    }

    ///////////////////////////////////////////////////////////////////////////
    /// <summary>
    /// 处理服务器返回的信息
    /// </summary>
    public bool OnServerDataEvent(ushort nMainCmd, ushort nSubCmd, byte[] byBody)
    {
        ServerDataItem item = new ServerDataItem();
        item.nMainCmd   = nMainCmd;
        item.nSubCmd    = nSubCmd;
        item.byBody     = byBody;

        // 将服务器的消息放进队列
        lock (m_ServerDataQueue)
        {
            m_ServerDataQueue.Enqueue(item);
        }

        return true;
    }

    ///////////////////////////////////////////////////////////////////////////

    /// <summary>
    /// 处理服务器数据的协程
    /// </summary>
    private IEnumerator OnHanleDataFiber()
    {
        while(true)
        {
            ServerDataItem item = null;

            // 数据是否接收到
            if (m_ServerDataQueue.Count == 0)
            {
                yield return 0;
                continue;
            }

            // 取出数据
            lock (m_ServerDataQueue)
            {
                item = m_ServerDataQueue.Dequeue();
                Debug.Log("rr:"+item);
            }

            // 处理服务器的数据
            if (item != null)
            {
                HandleServerData(item.nMainCmd, item.nSubCmd, item.byBody);
            }

            yield return 0;
        }
    }

    /// <summary>
    /// 处理服务器的数据
    /// </summary>
    private void HandleServerData(ushort nMainCmd, ushort nSubCmd, byte[] byBody)
    {
        switch ((EnRoomMainCmdID)nMainCmd)
        {
            case EnRoomMainCmdID.MDM_GR_LOGON:                      // 登录消息
                HandleLogonInfo(nSubCmd, byBody);
                break;
            case EnRoomMainCmdID.MDM_GF_FRAME:                      // 框架消息
                HandleFrameInfo(nSubCmd, byBody);
                break;
        }
    }


    /// <summary>
    /// 处理登录消息
    /// </summary>
    private void HandleLogonInfo(ushort nSubCmd, byte[] byBody)
    {
        switch ((EnRoomLogonSubCmdID)nSubCmd)
        {
            case EnRoomLogonSubCmdID.SUB_GR_LOGON_SUCCESS:
                {
				if (byBody.Length != Marshal.SizeOf(new CMD_MB_LogonSuccess()))
                    {
                        ClientDelegate.ShowMsgEvent("登陆成功返回来的数据有误");
                        return;
                    }
				CMD_MB_LogonSuccess stLogonSuccess = ClientConstant.ByteToStructure<CMD_MB_LogonSuccess>(byBody);
				m_Owner.dwUserID            = stLogonSuccess.dwUserID;
				ClientDelegate.ShowMsgEvent("登陆成功:"+stLogonSuccess.szNickName);
				ClientDelegate.ShowMsgEvent("dwUserID = " + stLogonSuccess.dwUserID);
                // test.Instance.setText("登陆成功:"+stLogonSuccess.szNickName);
                UnityEngine.SceneManagement.SceneManager.LoadScene("main");
                }
                break;
            case EnRoomLogonSubCmdID.SUB_GR_LOGON_ERROR:
                {
                    if (byBody.Length != Marshal.SizeOf(new CMD_GR_LogonError()))
                    {
                        ClientDelegate.ShowMsgEvent("登陆失败返回来的数据有误");
                        return;
                    }

                    CMD_GR_LogonError stLogonErr = ClientConstant.ByteToStructure<CMD_GR_LogonError>(byBody);
                    ClientDelegate.ShowMsgEvent("登陆失败");
                    ClientDelegate.ShowMsgEvent("登陆的错误信息：" + stLogonErr.szErrorDescribe);
                }
                break;
            case EnRoomLogonSubCmdID.SUB_GR_LOGON_FINISH:
                ClientDelegate.ShowMsgEvent("登陆结束");
                HandleLogonFinish();
                break;
        }
    }

    /// <summary>
    /// 处理登录完成事件
    /// </summary>
    private bool HandleLogonFinish()
    {
        ClientUser user = m_UserList.FindUser(m_Owner.dwUserID);
        if (user != null)
        {
            // 触发登录结束事件
            ClientDelegate.OnLogonFinishEvent();
        }

        return true;
    }


    /// <summary>
    /// 处理框架消息
    /// </summary>
    private void HandleFrameInfo(ushort nSubCmd, byte[] byBody)
    {
        switch ((EnGameFrameCmd)nSubCmd)
        {
            case EnGameFrameCmd.SUB_GF_OPTION:
                // CMD_GF_Option go = ClientConstant.ByteToStructure<CMD_GF_Option>(byBody);
                // m_cbGameStatus = go.bGameStatus;
                // m_cbAllowLookon = go.bAllowLookon;
                break;
            case EnGameFrameCmd.SUB_GF_READY:
                ClientDelegate.ShowMsgEvent("服务器提问客户端准备好开始了没有");
                m_RoomSocket.SendMessage((ushort)EnRoomMainCmdID.MDM_GF_FRAME, (ushort)EnGameFrameCmd.SUB_GF_USER_READY);
                break;
            case EnGameFrameCmd.SUB_GF_SCENE:
                HandleSceneInfo(byBody);
                break;
        }
    }

    /// <summary>
    /// 处理场景消息
    /// </summary>
    private void HandleSceneInfo(byte[] byBody)
    {
        ClientDelegate.ShowMsgEvent("接收到具体游戏的场景了");
        // 触发接收场景结束事件
        ClientDelegate.OnReceiveSceneFishEvent();
    }

    /// <summary>
    /// 发送UserID登录
    /// </summary>
    public void SendWeChatLogon()
    {
		DBR_MB_LogonOtherPlatform stLogon = new DBR_MB_LogonOtherPlatform();
		stLogon.wModuleID = 65535;
		stLogon.wPlazaVersion = 101122049;
		stLogon.wDeviceType = 1;
		stLogon.wGender = 1;
		stLogon.wPlatformID = 5;
		stLogon.wUserUin = "WBC4ABC45BC45ABC45ABC45ABC45ER";
		stLogon.wNickName = "荣耀W";
		stLogon.wCompellation = "荣耀W";
		stLogon.wMachineID = "A501164B366ECFC9E249163873094D51";
		stLogon.wMobilePhone = "0123456789";
		stLogon.wDeviceToken = "91C6E897E346C74CE8D1DB0AC06E2C13";
		stLogon.wFaceUrl = "http://192.168.5.13:8081/image/custom.png";
		SendMessage<DBR_MB_LogonOtherPlatform>(100, 4, stLogon);
    }

    /// <summary>
    /// 关闭连接
    /// </summary>
    public void CloseSocket()
    {
        m_RoomSocket.CloseSocket();
    }

    /// <summary>
    /// 打印信息
    /// </summary>
    private void ShowLog(string szLog)
    {
        Debug.Log(szLog);
    }

    private void OnApplicationQuit()
    {
        // 强制站起
        m_RoomSocket.CloseSocket();
    }
}