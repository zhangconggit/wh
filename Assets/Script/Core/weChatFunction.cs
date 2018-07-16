using UnityEngine;
using System;
using System.Collections;
using cn.sharesdk.unity3d;
using System.Runtime.InteropServices;
using System.IO;
using YunvaIM;
using UnityEngine.UI;

public class weChatFunction : MonoBehaviour
{
    public static ShareSDK ssdk;
    public static string idfv;
    public static string filePath = "";
    public static string recordPath = string.Empty;//返回录音地址
    public static string recordUrlPath = string.Empty;//返回录音url地址
    public static bool isPlay = true;
    // Use this for initialization

    void Start()
    {
        ssdk = gameObject.GetComponent<ShareSDK>();
        ssdk.authHandler = OnAuthResultHandler;
        ssdk.shareHandler = OnShareResultHandler;
        ssdk.showUserHandler = OnGetUserInfoResultHandler;
        ssdk.getFriendsHandler = OnGetFriendsResultHandler;
        ssdk.followFriendHandler = OnFollowFriendResultHandler;
        initYunYa();
    }


    void OnApplicationQuit()
    {
        PlayerPrefs.Save();
    }

    public static void QuitGame()
    {
#if UNITY_EDITOR
        Debug.Log("---------------QuitGame----------------");
#else
            Application.Quit();
#endif
    }

    public void initYunYa()
    {
        Debug.Log("11111111111111111111111111============");
        switch (Application.platform)
        {
            case RuntimePlatform.IPhonePlayer:
                EventListenerManager.AddListener(ProtocolEnum.IM_RECORD_VOLUME_NOTIFY, ImRecordVolume);//录音音量大小回调监听
                int init = YunVaImSDK.instance.YunVa_Init(0, 1002319, Application.persistentDataPath, false, false);
                if (init == 0)
                {
                    Debug.Log("初始化成功...");
                }
                else
                {
                    Debug.Log("初始化失败...");
                }
                break;
            case RuntimePlatform.Android:
                Debug.Log("222222222222222222222222============");
                EventListenerManager.AddListener(ProtocolEnum.IM_RECORD_VOLUME_NOTIFY, ImRecordVolume);//录音音量大小回调监听
                int yuYinInit = YunVaImSDK.instance.YunVa_Init(0, 1002319, Application.persistentDataPath, false, false);
                Debug.Log("11111111111111111111111111============" + yuYinInit);
                if (yuYinInit == 0)
                {
                    Debug.Log("初始化成功...");
                }
                else
                {
                    Debug.Log("初始化失败...");
                }
                break;
            default:
                break;
        }
    }

    public void ImRecordVolume(object data)
    {
        ImRecordVolumeNotify RecordVolumeNotify = data as ImRecordVolumeNotify;
        Debug.Log("ImRecordVolumeNotify:v_volume=" + RecordVolumeNotify.v_volume);
        if (RecordVolumeNotify.v_volume == 0)
        {
            LuaFramework.Util.CallMethod("TalkCtrl", "showYuYinVolume", 1);
        }
        else if (RecordVolumeNotify.v_volume > 0 && RecordVolumeNotify.v_volume < 25)
        {
            LuaFramework.Util.CallMethod("TalkCtrl", "showYuYinVolume", 2);
        }
        else if (RecordVolumeNotify.v_volume > 25 && RecordVolumeNotify.v_volume < 50)
        {
            LuaFramework.Util.CallMethod("TalkCtrl", "showYuYinVolume", 3);
        }
        else if (RecordVolumeNotify.v_volume > 50 && RecordVolumeNotify.v_volume < 75)
        {
            LuaFramework.Util.CallMethod("TalkCtrl", "showYuYinVolume", 4);
        }
        else if (RecordVolumeNotify.v_volume > 75 && RecordVolumeNotify.v_volume < 100)
        {
            LuaFramework.Util.CallMethod("TalkCtrl", "showYuYinVolume", 5);
        }
    }

    public static void YunVaOnLogin(string loginRoleName, string loginRoleID)
    {
        switch (Application.platform)
        {
            case RuntimePlatform.IPhonePlayer:
                {
                    string ttFormat = "{{\"nickname\":\"{0}\",\"uid\":\"{1}\"}}";
                    string tt = string.Format(ttFormat, loginRoleName, loginRoleID);
                    string[] wildcard = new string[2];
                    wildcard[0] = "0x001";
                    wildcard[1] = "0x002";
                    YunVaImSDK.instance.YunVaOnLogin(tt, "1", wildcard, 0, (data) =>
                    {
                        if (data.result == 0)
                        {
                            Debug.Log("登录成功，昵称:{0},用户ID:{1}" + data.nickName + data.userId);
                            YunVaImSDK.instance.RecordSetInfoReq(true);//开启录音的音量大小回调
                        }
                        else
                        {
                            Debug.Log("登录失败，错误消息：{0}" + data.msg);
                        }
                    });
                }
                break;
            case RuntimePlatform.Android:
                {
                    string ttFormat = "{{\"nickname\":\"{0}\",\"uid\":\"{1}\"}}";
                    string tt = string.Format(ttFormat, loginRoleName, loginRoleID);
                    string[] wildcard = new string[2];
                    wildcard[0] = "0x001";
                    wildcard[1] = "0x002";
                    YunVaImSDK.instance.YunVaOnLogin(tt, "1", wildcard, 0, (data) =>
                    {
                        if (data.result == 0)
                        {
                            Debug.Log("登录成功，昵称:{0},用户ID:{1}" + data.nickName + data.userId);
                            YunVaImSDK.instance.RecordSetInfoReq(true);//开启录音的音量大小回调
                        }
                        else
                        {
                            Debug.Log("登录失败，错误消息：{0}" + data.msg);
                        }
                    });
                }
                break;
            default:
                break;
        }
    }

    public static void yuYinBtnDown()
    {
        filePath = string.Format("{0}/{1}.amr", Application.persistentDataPath, DateTime.Now.ToFileTime());
        Debug.Log("FilePath:" + filePath);
        YunVaImSDK.instance.RecordStartRequest(filePath, 1);
    }

    public static void yuYinLuZhiDuan(bool play)
    {
        isPlay = play;
    }

    public static void yuYinBtnUp()
    {
        YunVaImSDK.instance.RecordStopRequest((data1) =>
        {
            recordPath = data1.strfilepath;
            Debug.Log("停止录音返回:" + recordPath);
        },
            (data2) =>
            {
                Debug.Log("上传返回:" + data2.fileurl);
                if (isPlay == true)
                {
                    LuaFramework.Util.CallMethod("TalkCtrl", "OnYuYinSend", data2.fileurl);
                }
            },
            (data3) =>
            {
                Debug.Log("识别返回:" + data3.text);
            });
    }

    public static void yuYinDown(string yuYinUrl)
    {
        string DownLoadfilePath = string.Format("{0}/{1}.amr", Application.persistentDataPath, DateTime.Now.ToFileTime());
        Debug.Log("下载语音:" + DownLoadfilePath);
        string fileid = DateTime.Now.ToFileTime().ToString();
        YunVaImSDK.instance.DownLoadFileRequest(yuYinUrl, DownLoadfilePath, fileid, (data4) =>
        {
            if (data4.result == 0)
            {
                Debug.Log("下载成功:" + data4.filename);
                string ext = DateTime.Now.ToFileTime().ToString();
                LuaFramework.Util.CallMethod("GameChatCtrl", "OnPlayYuYin");
                YunVaImSDK.instance.RecordStartPlayRequest(DownLoadfilePath, "", ext, (data2) =>
                {
                    if (data2.result == 0)
                    {
                        Debug.Log("播放成功");
                    }
                    else
                    {
                        Debug.Log("播放失败");
                    }
                });
            }
            else
            {
                Debug.Log("下载失败:" + data4.msg);
            }
        });

    }

    public static bool getWeChatState()
    {
        bool isHasWeChat = ssdk.IsClientValid(PlatformType.WeChat);
        return isHasWeChat;
    }

    public static void weChatLoginGame()
    {
        ssdk.CancelAuthorize(PlatformType.WeChat);
        ssdk.GetUserInfo(PlatformType.WeChat);
        Debug.Log("weChatLogin");
        //C#调取Lua内脚本函数
        //LuaFramework.Util.CallMethod("MainSenceCtrl", "Awake");
        //LuaFramework.Util.CallMethod("LoginCtrl", "Close");
    }

    //截屏
    public static string GetDefaultFilePath()
    {
        //Application.CaptureScreenshot("Screenshot.png", 0);
        CaptureScreenshot2(new Rect(Screen.width * 0f, Screen.height * 0f, Screen.width * 1f, Screen.height * 1f));
        return Application.persistentDataPath + "/Screenshot.jpg";
    }
    private static void CaptureScreenshot2(Rect rect)
    {
        Texture2D screenShot;
        screenShot = new Texture2D((int)rect.width, (int)rect.height, TextureFormat.RGB24, false);

        // 读取屏幕像素信息并存储为纹理数据，  
        screenShot.ReadPixels(rect, 0, 0);
        screenShot.Apply();
        screenShot.Compress(false);
        screenShot = ScaleTexture(screenShot, 1280, 720);
        // 然后将这些纹理数据，成一个jpg图片文件  
        byte[] bytes = screenShot.EncodeToJPG();
        string filename = Application.persistentDataPath + "/Screenshot.jpg";
        System.IO.File.WriteAllBytes(filename, bytes);
        Debug.Log(string.Format("CaptureScreenshot a picture: {0}", filename));
    }

    //------材质缩放------------
    private static Texture2D ScaleTexture(Texture2D source, int targetWidth, int targetHeight)
    {
        Texture2D result = new Texture2D(targetWidth, targetHeight, source.format, false);

        float incX = (1.0f / (float)targetWidth);
        float incY = (1.0f / (float)targetHeight);

        for (int i = 0; i < result.height; ++i)
        {
            for (int j = 0; j < result.width; ++j)
            {
                Color newColor = source.GetPixelBilinear((float)j / (float)result.width, (float)i / (float)result.height);
                result.SetPixel(j, i, newColor);
            }
        }

        result.Apply();
        return result;
    }
    public static void ShareBattleBtnClick()
    {
        ShareContent content = new ShareContent();
        content.SetImagePath(GetDefaultFilePath());
        content.SetShareType(ContentType.Image);
        ssdk.ShareContent(PlatformType.WeChat, content);
    }

    public static void weChatInviteFriendBtnClick(string shareContent, string imageUrl, string title, string downUrl)
    {
        ShareContent content = new ShareContent();
        content.SetText(shareContent);
        content.SetImageUrl(imageUrl);
        content.SetTitle(title);
        content.SetUrl(downUrl);
        content.SetShareType(ContentType.Webpage);
        ssdk.ShareContent(PlatformType.WeChat, content);
    }

    public static void shareWeChatMomentsBtnClick(string shareContent, string imageUrl, string title, string downUrl)
    {
        ShareContent content = new ShareContent();
        content.SetText(shareContent);
        content.SetImageUrl(imageUrl);
        content.SetTitle(title);
        content.SetUrl(downUrl);
        content.SetShareType(ContentType.Webpage);
        ssdk.ShareContent(PlatformType.WeChatMoments, content);
    }

    public static void shareImageWeChatMomentsBtnClick()
    {
        ShareContent content = new ShareContent();
        content.SetImagePath(GetDefaultFilePath());
        content.SetShareType(ContentType.Image);
        ssdk.ShareContent(PlatformType.WeChatMoments, content);
    }

    void OnAuthResultHandler(int reqID, ResponseState state, PlatformType type, Hashtable result)
    {
        if (state == ResponseState.Success)
        {
            print("authorize success !" + "Platform :" + type);
            print(MiniJSON.jsonEncode(result));
        }
        else if (state == ResponseState.Fail)
        {
#if UNITY_ANDROID
            print("fail! throwable stack = " + result["stack"] + "; error msg = " + result["msg"]);
#elif UNITY_IPHONE
			print ("fail! error code = " + result["error_code"] + "; error msg = " + result["error_msg"]);
#endif
        }
        else if (state == ResponseState.Cancel)
        {
            print("cancel !");
        }
    }

    void OnGetUserInfoResultHandler(int reqID, ResponseState state, PlatformType type, Hashtable result)
    {
        if (state == ResponseState.Success)
        {
            print("get user info result :");
            print(MiniJSON.jsonEncode(result));
            print("Get userInfo success !Platform :" + type);
            //获取成功的话 可以写一个类放不同平台的结构体，用PlatformType来判断，用户的Json转化成结构体，来做第三方登录。
            switch (type)
            {
                case PlatformType.WeChat:
                    {
                        Hashtable authInfoResult = ssdk.GetAuthInfo(PlatformType.WeChat);
                        print("getUserauthInfo:");
                        print(MiniJSON.jsonEncode(authInfoResult));
                        string userInfo = MiniJSON.jsonEncode(result);  //Json
                        string authInfo = MiniJSON.jsonEncode(authInfoResult);
                        //weChatUserInfo info = weChatUserInfo.CreateFromJson(userInfo);
                        //print("weixinxinxi：" + info.city + info.province + info.headimgurl + info.unionid + info.openid + info.nickname + info.city);
                        LuaFramework.Util.CallMethod("LoginCtrl", "OnWeChatLoginInfoSend", userInfo, authInfo);
                    }
                    break;
            }
        }
        else if (state == ResponseState.Fail)
        {
#if UNITY_ANDROID
            print("fail! throwable stack = " + result["stack"] + "; error msg = " + result["msg"]);
#elif UNITY_IPHONE
			print ("fail! error code = " + result["error_code"] + "; error msg = " + result["error_msg"]);
#endif
        }
        else if (state == ResponseState.Cancel)
        {
            print("cancel !");
        }
    }

    void OnShareResultHandler(int reqID, ResponseState state, PlatformType type, Hashtable result)
    {
        if (state == ResponseState.Success)
        {
            print("share successfully - share result :");
            print(MiniJSON.jsonEncode(result));
            //获取成功的话 可以写一个类放不同平台的结构体，用PlatformType来判断，用户的Json转化成结构体，来做第三方登录。
            switch (type)
            {
                case PlatformType.WeChat:
                    {
                        LuaFramework.Util.CallMethod("ShareCtrl", "OnShareFriendSend");
                    }
                    break;
                case PlatformType.WeChatMoments:
                    {
                        LuaFramework.Util.CallMethod("ShareCtrl", "OnShareFriendCircleSend");
                    }
                    break;
            }
        }
        else if (state == ResponseState.Fail)
        {
#if UNITY_ANDROID
            print("fail! throwable stack = " + result["stack"] + "; error msg = " + result["msg"]);
#elif UNITY_IPHONE
			print ("fail! error code = " + result["error_code"] + "; error msg = " + result["error_msg"]);
#endif
        }
        else if (state == ResponseState.Cancel)
        {
            print("cancel !");
        }
    }

    void OnGetFriendsResultHandler(int reqID, ResponseState state, PlatformType type, Hashtable result)
    {
        if (state == ResponseState.Success)
        {
            print("get friend list result :");
            print(MiniJSON.jsonEncode(result));
        }
        else if (state == ResponseState.Fail)
        {
#if UNITY_ANDROID
            print("fail! throwable stack = " + result["stack"] + "; error msg = " + result["msg"]);
#elif UNITY_IPHONE
			print ("fail! error code = " + result["error_code"] + "; error msg = " + result["error_msg"]);
#endif
        }
        else if (state == ResponseState.Cancel)
        {
            print("cancel !");
        }
    }

    void OnFollowFriendResultHandler(int reqID, ResponseState state, PlatformType type, Hashtable result)
    {
        if (state == ResponseState.Success)
        {
            print("Follow friend successfully !");
        }
        else if (state == ResponseState.Fail)
        {
#if UNITY_ANDROID
            print("fail! throwable stack = " + result["stack"] + "; error msg = " + result["msg"]);
#elif UNITY_IPHONE
			print ("fail! error code = " + result["error_code"] + "; error msg = " + result["error_msg"]);
#endif
        }
        else if (state == ResponseState.Cancel)
        {
            print("cancel !");
        }
    }

    public static void GetSprite(GameObject img, Sprite sprite)
    {
        img.transform.GetComponent<Image>().sprite = sprite;
    }
    //------------------------------定时清理图片-----------（已废弃）------------------
    public static void GetDirs(string name)
    {
        string path = "";
        if (name == "IOS")
        {
            path = Application.persistentDataPath.Substring(0, Application.persistentDataPath.Length - 5);
            path = path.Substring(0, path.LastIndexOf('/'));
            path = Path.Combine(path, "Documents");
            path = path.Substring(0, path.LastIndexOf('/'));
            Debug.Log("--------------deletePNG--Path：" + path);
        }
        else if (name == "PC")
        {
            path = Application.dataPath;
            path = path.Substring(0, path.LastIndexOf('/'));
            Debug.Log("--------------deletePNG--Path：" + path);
        }
        else if (name == "Android")
        {
            path = Application.persistentDataPath;
            path = path.Substring(0, path.LastIndexOf('/'));
            Debug.Log("--------------deletePNG--Path：" + path);
        }
        string[] Temp = Directory.GetFiles(path);
        for (int i = 0; i < Temp.Length; i++)
        {
            Temp[i] = Temp[i].Substring(Temp[i].LastIndexOf(@"\") + 1);
            if (Temp[i].EndsWith(".png"))   //判断文件后缀这里判断的是png格式的文件
            {
                File.Delete(path + "//" + Temp[i].ToString());
            }
        }
    }
    //------------------------------新的头像加载方法-------------------------------
    public static void SetPic(GameObject img, string roleId, string url)
    {
        AsyncImageDownload.Instance.SetAsyncImage(url, img.transform.GetComponent<Image>(), roleId);
    }

    public static void SetPic(GameObject img, string roleId)
    {
        string url = null;
        AsyncImageDownload.Instance.SetAsyncImage(url, img.transform.GetComponent<Image>(), roleId);
    }
    /// 删除文件夹
    public static void DeleteFolder()
    {
        Debug.Log("==========DeleteFolder=========");
        AsyncImageDownload.Instance.ClearPic();
    }

    public static void openWeChat(string weChatUrl, string urlInfo, string key)
    {
        string md5 = LuaFramework.Util.md5(urlInfo + key);
        Application.OpenURL(weChatUrl + urlInfo + "&signture=" + md5);
    }

    public static void openURL(string urlInfo)
    {
        Application.OpenURL(urlInfo);
    }

}
