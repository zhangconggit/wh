using System.Collections.Generic;

public class ClientUserList
{
    private Dictionary<uint, ClientUser> m_UserMap;

    public ClientUserList()
    {
        m_UserMap = new Dictionary<uint, ClientUser>();
    }

    public Dictionary<uint, ClientUser> GetUserMap()
    {
        return m_UserMap;
    }

    public void AddUser(ClientUser User)
    {
        m_UserMap.Add(User.dwUserID, User);
    }

    public ClientUser FindUser(uint dwUserID)
    {
        if (!m_UserMap.ContainsKey(dwUserID))
        {
            return null;
        }

        return (ClientUser)m_UserMap[dwUserID];
    }

    public void RemoveUser(uint dwUserID)
    {
        if (m_UserMap.ContainsKey(dwUserID))
        {
            m_UserMap.Remove(dwUserID);
        }
    }
}