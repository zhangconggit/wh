using UnityEngine;
using System.Collections;

[System.Serializable]
public class WeChatAuthInfo
{
    public string refresh_token;//刷新token
    public string openID;   //用户的唯一标识
    public int    expiresIn;  //access_token接口调用凭证超时时间，单位（秒）
    public string userGender; //用户性别
    public string tokenSecret;//秘钥
    public string userID; //用户的唯一标识
    public string unionID; //ID
    public string expiresTime; //过期时间
    public string userName;      //用户昵称
    public string token; //接口调用凭证
    public string userIcon;//用户头像

    public static WeChatAuthInfo CreateFromJson(string json)
    {
        WeChatAuthInfo ret = JsonUtility.FromJson<WeChatAuthInfo>(json);
        return ret;
    }
}
