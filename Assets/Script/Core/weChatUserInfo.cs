﻿using UnityEngine;
using System.Collections;

[System.Serializable]
public class weChatUserInfo
{
    public string country;   //国家，如中国为CN搜索
    public string province;  //用户个人资料填写的省份
    public string headimgurl; //用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值 可选，0代表
    //640*640正方形头像），用户没有头像时该项为空。若用户更换 头像，原有头像URL将失效。
    public string unionid;//只有在用户将公众号绑定到微信开放平台帐号后，才会出现该字段
    public string openid; //用户的唯一标识
    public string nickname; //用户昵称
    public string city;      //普通用户个人资料填写的城市
    public int sex; //用户的性别，值为1时是男性，值为2时是女性，值为0时是未知
    public string language;//用户语言
    public object[] privilege; //用户特权信息，json 数组，如微信沃卡用户为（chinaunicom）


    public static weChatUserInfo CreateFromJson(string json)
    {
        weChatUserInfo ret = JsonUtility.FromJson<weChatUserInfo>(json);
        return ret;
    }
}
