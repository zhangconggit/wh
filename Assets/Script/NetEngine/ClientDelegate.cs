using System;

/// <summary>
/// 客户端委托类
/// </summary>
public class ClientDelegate
{
    public delegate void ShowMsgDelegate(string szMsg);
    public delegate void ServerDataDelegate(byte byCheckCode,   ushort nMainCmd,    ushort nSubCmd,     byte[] byBody);
    public delegate void HandleLogon(string szAccount,          string szPassword);
    public delegate void HandleLogonFinish();
    public delegate void HandleMultiLogon();
    public delegate void HandleUserCome(ClientUser user,        ushort wTableId,    ushort wChairId);
    public delegate void HandleUserLeave(ushort wTableId,       ushort wChairId);
    public delegate void HandleUserSitDown(ClientUser user,     ushort wTableId,    ushort wChairId);
    public delegate void HandleUserStandUp(ushort wTableId,     ushort wChairId);
    public delegate void HandleRequestSitDown(ushort wTableId,  ushort wChairId);
    public delegate void HandleReceiveSceneFish();

    public static ShowMsgDelegate           ShowMsgEvent;
    public static ServerDataDelegate        ServerDataEvent;
    public static HandleLogon               LogonEvent;
    public static HandleLogonFinish         LogonFinishEvent;
    public static HandleMultiLogon          MultiLogonEvent;
    public static HandleUserCome            UserComeEvent;
    public static HandleUserLeave           UserLeaveEvent;
    public static HandleUserSitDown         UserSitDownEvent;
    public static HandleUserStandUp         UserStandUpEvent;
    public static HandleRequestSitDown      RequestSitDownEvent;
    public static HandleReceiveSceneFish    ReceiveSceneFishEvent;

    /// <summary>
    /// 显示消息
    /// </summary>
    public static void OnShowMsgEvent(string szMsg)
    {
        if (ShowMsgEvent != null)
        {
            ShowMsgEvent(szMsg);
        }
    }

    /// <summary>
    /// 接收服务器的消息
    /// </summary>
    public static void OnServerDataEvent(byte byCheckCode, ushort nMainCmd, ushort nSubCmd, byte[] byBody)
    {
        if (ServerDataEvent != null)
        {
            ServerDataEvent(byCheckCode, nMainCmd, nSubCmd, byBody);
        }
    }

    /// <summary>
    /// 登录事件
    /// </summary>
    public static void OnLogonEvent(string szAccount, string szPassword)
    {
        if (LogonEvent != null)
        {
            LogonEvent(szAccount, szPassword);
        }
    }

    /// <summary>
    /// 登录结束事件
    /// </summary>
    public static void OnLogonFinishEvent()
    {
        if (LogonFinishEvent != null)
        {
            LogonFinishEvent();
        }
    }

    /// <summary>
    /// 重复登录事件
    /// </summary>
    public static void OnMultiLogonEvent()
    {
        if (MultiLogonEvent != null)
        {
            MultiLogonEvent();
        }
    }

    /// <summary>
    /// 玩家进入事件
    /// </summary>
    public static void OnUserComeEvent(ClientUser user, ushort wTableId, ushort wChairId)
    {
        if (UserComeEvent != null)
        {
            UserComeEvent(user, wTableId, wChairId);
        }
    }

    /// <summary>
    /// 玩家离开事件
    /// </summary>
    public static void OnUserLeaveEvent(ushort wTableId, ushort wChairId)
    {
        if (UserLeaveEvent != null)
        {
            UserLeaveEvent(wTableId, wChairId);
        }
    }

    /// <summary>
    /// 玩家坐下事件
    /// </summary>
    public static void OnUserSitDownEvent(ClientUser user, ushort wTableId, ushort wChairId)
    {
        if (UserSitDownEvent != null)
        {
            UserSitDownEvent(user, wTableId, wChairId);
        }
    }

    /// <summary>
    /// 玩家站起事件
    /// </summary>
    public static void OnUserStandUpEvent(ushort wTableId, ushort wChairId)
    {
        if (UserStandUpEvent != null)
        {
            UserStandUpEvent(wTableId, wChairId);
        }
    }

    /// <summary>
    /// 请求坐下事件
    /// </summary>
    public static void OnRequestSitDownEvent(ushort wTableId, ushort wChairId)
    {
        if (RequestSitDownEvent != null)
        {
            RequestSitDownEvent(wTableId, wChairId);
        }
    }

    /// <summary>
    /// 接收场景结束
    /// </summary>
    public static void OnReceiveSceneFishEvent()
    {
        if (ReceiveSceneFishEvent != null)
        {
            ReceiveSceneFishEvent();
        }
    }
}