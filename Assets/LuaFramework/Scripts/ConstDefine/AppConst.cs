using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace LuaFramework
{

    public class AppConst
    {

        public static bool DebugMode = true;                       //调试模式-用于内部测试
        /// <summary>
        /// 如果想删掉框架自带的例子，那这个例子模式必须要
        /// 关闭，否则会出现一些错误。
        /// </summary>
        public static bool ExampleMode = true;                       //例子模式 

        /// <summary>
        /// 如果开启更新模式，前提必须启动框架自带服务器端。
        /// 否则就需要自己将StreamingAssets里面的所有内容
        /// 复制到自己的Webserver上面，并修改下面的WebUrl。
        /// </summary>
        public static bool UpdateMode = false;                       //更新模式-默认关闭  


        public static bool LuaByteMode = false;                      //Lua字节码模式-默认关闭 
        public static bool LuaBundleMode = false;                     //Lua代码AssetBundle模式

        public static int TimerInterval = 1;
        public static int GameFrameRate = 30;                        //游戏帧频

        public static string AppName = "LuaFramework";               //应用程序名称
        public static string LuaTempDir = "Lua/";                    //临时目录
        public static string AppPrefix = AppName + "_";              //应用程序前缀
        public static string ExtName = ".unity3d";                   //素材扩展名
        public static string spineAb = "spine";                      //SpineAB包名字
        public static string AssetDir = "StreamingAssets";           //素材目录 

        //配置地址
        public static string ConfigUrl = "";
        // //public static string ConfigUrl = "http://version.hzjiuyou.com/xlwresource/config/configandroid.txt";
        // //public static string ConfigUrl = "http://version.hzjiuyou.com/xlwresource/config/configios.txt";
        // //资源地址
        public static string WebUrl = "";
        // //public static string WebUrl = "http://version.hzjiuyou.com/resource/data";
        // //安装包下载地址
        public static string DownUrl = "";
        // //public static string DownUrl = "http://download.hzjiuyou.com/dl/hzdownload.htm";

        // 配置地址
        // public static string ConfigUrl = "http://192.168.1.201:8080/xlw/resource/config/config1.txt";
        // //资源地址
        // public static string WebUrl = "http://192.168.1.201:8080/xlw/resource/data";
        // //安装包下载地址
        // public static string DownUrl = "http://192.168.1.201:8080/xlw/dl/hzdownload.html";


        public static string UserId = string.Empty;               //用户ID
        public static int SocketPort = 8888;                        //Socket服务器端口
        public static string SocketAddress = "172.31.246.77";       //Socket服务器地址


        public static string FrameworkRoot
        {
            get
            {
                return Application.dataPath + "/" + AppName;
            }
        }

        public static string getCurrentPlatform()
        {
            if (Application.platform == RuntimePlatform.Android)
            {
                return "Android";
            }
            else if (Application.platform == RuntimePlatform.IPhonePlayer)
            {
                return "IOS";
            }
            else if (Application.platform == RuntimePlatform.WindowsEditor)
            {
                return "PC";
            }
            return "";
        }

        //获取安卓设备唯一ID
        public static string getDeviceID()
        {
            return SystemInfo.deviceUniqueIdentifier;
        }

        //获取安卓网络信息强度
        public static int getNetworkLevel()
        {
            if (Application.platform == RuntimePlatform.Android)
            {
                AndroidJavaClass jc = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
                AndroidJavaObject jo = jc.GetStatic<AndroidJavaObject>("currentActivity");
                int level = jo.Call<int>("getLevel");
                return level;
            }
            else
                return 0;
        }

        //获取安卓网络状态
        public static int getNetState()
        {
            int state = 0;
            if (Application.platform == RuntimePlatform.Android)
            {
                AndroidJavaClass jc = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
                AndroidJavaObject jo = jc.GetStatic<AndroidJavaObject>("currentActivity");
                state = jo.Call<int>("getNetState");
                return state;
            }
            else
            {
                return 2;
            }
        }

        //获取网络类型 0 无网络 1 WIFI 2 移动网络
        public static int getNetType()
        {
            if (Application.internetReachability == NetworkReachability.NotReachable)
            {
                return 0;
            }
            else if (Application.internetReachability == NetworkReachability.ReachableViaLocalAreaNetwork)
            {
                return 1;
            }
            else if (Application.internetReachability == NetworkReachability.ReachableViaCarrierDataNetwork)
            {
                return 2;
            }
            return 0;
        }

        //获取手机电量
        public static int GetBatteryLevel()
        {
            try
            {
                string CapacityString = System.IO.File.ReadAllText("/sys/class/power_supply/battery/capacity");
                return int.Parse(CapacityString);
            }
            catch (Exception e)
            {
                Debug.Log("读取失败; " + e.Message);
            }
            return -1;
        }


        //手机振动
        public static void Vibrate()
        {
            Handheld.Vibrate();
        }

        //设置玩家缓存数据
        public static void setPlayerPrefs(string key, string value)
        {
            PlayerPrefs.SetString(key, value);
        }

        //获取玩家缓存数据
        public static string getPlayerPrefs(string key)
        {
            if (key == "isNXFYOn")
            {
                return "0";
            }

            return PlayerPrefs.GetString(key, "");
        }

        //删除玩家指定缓存数据
        public static void DeleteKey(string key)
        {
            PlayerPrefs.DeleteKey(key);
        }


        //序列化
        public static string ChangeCode(byte[] byteArray)
        {
            string str = Encoding.Default.GetString(byteArray);
            return str;
        }

        //获取系统时间
        public static string GetDate()
        {
            string str = System.DateTime.Now.ToString(DateTime.Now.Hour.ToString() + ":mm");
            return str;

        }
        //Game 相关；
        public static string uuuIdKey = ""; //加密密钥；
        public static byte[] uuuIdKeyBytes = null;
        public static int keyIndex = 0;
        public static int keyLength = 0;

        public static byte[] ticketBytes = Encoding.UTF8.GetBytes("LEYOUKEJI_MAJHONG_SUPER");
        public static int ticketLength = ticketBytes.Length;
        public static int ticketIndex = 0;


        public static string version = "1.0.0";//版本号
        public static string appId = "";     //应用ID
        public static string appSecret = ""; //腾讯秘钥
    }
}