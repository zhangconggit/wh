/// <summary>
/// 客户端全局类
/// </summary>
public class ClientGlobal
{
    private static ClientGlobal     mInstance;
    private static ClientSocket     m_RoomSocket;
    private static ClientUser       m_UserOwner;
    private static ClientUserList   m_UserList;

    public static ClientGlobal GetInstance()
    {
        if (mInstance == null)
        {
            mInstance = new ClientGlobal();
        }
        return mInstance;
    }

    /// <summary>
    /// 获取roomSocket的单例
    /// </summary>
    public ClientSocket GetRoomSocket()
    {
        if (m_RoomSocket == null)
        {
            m_RoomSocket = new ClientSocket();
        }
        return m_RoomSocket;
    }

    /// <summary>
    /// 获取UserOwner的单例
    /// </summary>
    public ClientUser GetOwner()
    {
        if (m_UserOwner == null)
        {
            m_UserOwner = new ClientUser();
        }
        return m_UserOwner;
    }

    /// <summary>
    /// 获取userList的单例
    /// </summary>
    public ClientUserList GetUserList()
    {
        if (m_UserList == null)
        {
            m_UserList = new ClientUserList();
        }
        return m_UserList;
    }
}