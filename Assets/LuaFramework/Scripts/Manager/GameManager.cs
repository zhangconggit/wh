using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine.UI;
using TinyTeam.Debuger;

namespace LuaFramework
{
    public class GameManager : Manager
    {
        protected static bool initialize = false;
        private List<string> downloadFiles = new List<string>();

        private Text txtPer;
        private Text txtInfo;
        private Image pgsPer;
        private Text txtVersion;

        private string url;
        private int bytesLoaded = 0;
        private int bytesTotal = 0;

        //更新提示界面
        private Button btnYes;
        private Button btnNo;
        private Text Tips;
        private Image updateTipsPanel;
        //private Transform hand;
        private Transform DownLoadPanel;
        public bool isUpdate;
        private bool isReload;

        private int tipType = 0;
        private string verNum;

        /// <summary>
        /// 初始化游戏管理器
        /// </summary>
        void Awake()
        {
            DontDestroyOnLoad(gameObject);  //防止销毁自己
                                            //if(AppConst.DebugMode)
            TTDebuger.Log("Debugger Start");
            Init(false);
        }

        /// <summary>
        /// 初始化
        /// </summary>
        public void Init(bool isRl)
        {
            isReload = isRl;
            DownLoadPanel = GameObject.Find("Canvas/GuiCamera/DownLoadAssetsPanel").transform;
            txtPer = DownLoadPanel.Find("bar/txtPer").GetComponent<Text>();
            pgsPer = DownLoadPanel.Find("bar/pgsPer").GetComponent<Image>();
            txtInfo = DownLoadPanel.Find("bar/fontbg/txtInfo").GetComponent<Text>();
            txtVersion = DownLoadPanel.Find("txtVersionNumber").GetComponent<Text>();
            //hand = DownLoadPanel.Find("bar/hand");
            updateTipsPanel = DownLoadPanel.Find("UpdateTipPanel").GetComponent<Image>();
            Tips = DownLoadPanel.Find("UpdateTipPanel/txtTips").GetComponent<Text>();
            btnYes = DownLoadPanel.Find("UpdateTipPanel/btnYes").GetComponent<Button>();
            btnNo = DownLoadPanel.Find("UpdateTipPanel/btnNo").GetComponent<Button>();
            btnYes.onClick.AddListener(OnYesClick);
            btnNo.onClick.AddListener(OnNoClick);

            txtVersion.text = "V" + AppConst.version;
            txtInfo.text = "正在检查版本...";

            // CheckExtractResource(); //释放资源
            Screen.sleepTimeout = SleepTimeout.NeverSleep;
            Application.targetFrameRate = AppConst.GameFrameRate;
            StartCoroutine(CheckVersion());
        }

        //检查游戏版本
        IEnumerator CheckVersion()
        {
            if (!AppConst.UpdateMode)
            {
                CheckExtractResource();
                yield break;
            }
            string random = DateTime.Now.ToString("yyyymmddhhmmss");
            string verUrl = AppConst.ConfigUrl + "?v=" + random;
            Debug.Log("===========" + verUrl);
            WWW verwww = new WWW(verUrl);
            yield return verwww;
            if (verwww.error != null)
            {
                OnUpdateFailed(string.Empty);
                ShowNetTip();
                yield break;
            }
            string verText = verwww.text;
            string[] verStr = verText.Split(new string[] { "\r\n" }, StringSplitOptions.None);
            if (!string.IsNullOrEmpty(verStr[0]))
            {
                string[] verKey = verStr[0].Split('=');
                if (verKey[0] == "ver")
                {
                    verNum = verKey[1];
                    Debug.Log("-------------" + verNum);
                    string[] serVersions = verNum.Split('.');
                    string[] appVersions = AppConst.version.Split('.');

                    int serSion = Convert.ToInt32(serVersions[0]) * 100 + Convert.ToInt32(serVersions[1]);
                    int appSion = Convert.ToInt32(appVersions[0]) * 100 + Convert.ToInt32(appVersions[1]);
                    if (serSion > appSion)
                    {
                        txtInfo.text = "发现新版本，请下载最新版本";
                        ShowVersionTip();
                        Debug.LogWarning("need install new ver ---->>>" + verNum + "cur: " + AppConst.version);
                        yield break;
                    }
                }

                AppConst.UpdateMode = int.Parse(verStr[1].Split('=')[1]) == 1;
                AppConst.WebUrl = verStr[2].Split('=')[1];
                string ios_url = verStr[3].Split('=')[1];
                string android_url = verStr[4].Split('=')[1];
                if (int.Parse(verStr[5].Split('=')[1]) == 1)
                    TTDebuger.Log("Debugger Start");

                url = AppConst.WebUrl;
#if UNITY_ANDROID
                url = url + "_android/";
                AppConst.DownUrl = android_url;
#elif UNITY_IPHONE
                    url = url + "_ios/";
                    AppConst.DownUrl = ios_url;
#else
                url = url + "/";
#endif

                if (!AppConst.UpdateMode)
                {
                    CheckExtractResource();
                    yield break;
                }
            }
            else
            {
                Debug.LogWarning("version.txt is fail");
                yield break;
            }

            CheckExtractResource();
        }

        /// <summary>
        /// 释放资源
        /// </summary>
        public void CheckExtractResource()
        {
            bool isExists = Directory.Exists(Util.DataPath) &&
              Directory.Exists(Util.DataPath + "lua/zend/") && File.Exists(Util.DataPath + "files.txt") && File.Exists(Util.DataPath + "version.txt");
            //当前资源版本小于APP版本时属于大版本更新需要重新释放资源
            if (isExists && AppConst.UpdateMode)
            {
                string ver = File.ReadAllText(Util.DataPath + "version.txt");
                string num = ver.Split('=')[1];
                string[] serVersions = num.Split('.');
                string[] appVersions = AppConst.version.Split('.');

                int serSion = Convert.ToInt32(serVersions[0]) * 100 + Convert.ToInt32(serVersions[1]);
                int appSion = Convert.ToInt32(appVersions[0]) * 100 + Convert.ToInt32(appVersions[1]);
                if (serSion < appSion)
                    isExists = false;
            }
            if (isExists || AppConst.DebugMode)
            {
                StartCoroutine(OnUpdateResource());
                return;   //文件已经解压过了，自己可添加检查文件列表逻辑
            }
            StartCoroutine(OnExtractResource());    //启动释放协成 
        }

        //void SetFillAmountPos(float v)
        //{
        //    hand.transform.localPosition = new Vector3(-420 + 420 * 2 * v, hand.transform.localPosition.y, hand.transform.localPosition.z);
        //}

        IEnumerator OnExtractResource()
        {
            string dataPath = Util.DataPath;  //数据目录
            string resPath = Util.AppContentPath(); //游戏包资源目录

            if (Directory.Exists(dataPath)) Directory.Delete(dataPath, true);
            Directory.CreateDirectory(dataPath);

            string infile = resPath + "files.txt";
            string outfile = dataPath + "files.txt";
            if (File.Exists(outfile)) File.Delete(outfile);

            string message = "正在解包文件:>files.txt";
            txtInfo.text = "正在解包文件...";
            Debug.Log(infile);
            Debug.Log(outfile);
            if (Application.platform == RuntimePlatform.Android)
            {
                WWW www = new WWW(infile);
                yield return www;

                if (www.isDone)
                {
                    File.WriteAllBytes(outfile, www.bytes);
                }
                yield return 0;
            }
            else File.Copy(infile, outfile, true);
            yield return new WaitForEndOfFrame();

            //释放所有文件到数据目录
            string[] files = File.ReadAllLines(outfile);
            int COUNT = files.Length;
            int i = 0;
            foreach (var file in files)
            {
                i++;
                txtPer.text = (i * 100 / COUNT) + "%";
                pgsPer.fillAmount = (float)i / COUNT;
                //SetFillAmountPos((float)i / COUNT);
                string[] fs = file.Split('|');
                infile = resPath + fs[0];  //
                outfile = dataPath + fs[0];

                message = "正在解包文件:>" + fs[0];
                Debug.Log("Unpack files:>" + infile);
                facade.SendMessageCommand(NotiConst.UPDATE_MESSAGE, message);

                string dir = Path.GetDirectoryName(outfile);
                if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);

                if (Application.platform == RuntimePlatform.Android)
                {
                    WWW www = new WWW(infile);
                    yield return www;

                    if (www.isDone)
                    {
                        File.WriteAllBytes(outfile, www.bytes);
                    }
                    yield return 0;
                }
                else
                {
                    if (File.Exists(outfile))
                    {
                        File.Delete(outfile);
                    }
                    File.Copy(infile, outfile, true);
                }
                yield return new WaitForEndOfFrame();
            }
            message = "解包完成!!!";
            txtPer.text = "100%";
            pgsPer.fillAmount = 1;
            //SetFillAmountPos(1);
            Debug.Log("Unpack finished!");
            facade.SendMessageCommand(NotiConst.UPDATE_MESSAGE, message);
            yield return new WaitForSeconds(0.1f);

            message = string.Empty;
            //释放完成，开始启动更新资源
            StartCoroutine(OnUpdateResource());
        }

        /// <summary>
        /// 启动更新下载，这里只是个思路演示，此处可启动线程下载更新
        /// </summary>
        IEnumerator OnUpdateResource()
        {
            if (!AppConst.UpdateMode)
            {
                OnResourceInited();
                yield break;
            }
            string dataPath = Util.DataPath;  //数据目录
            string message = string.Empty;
            string random = DateTime.Now.ToString("yyyymmddhhmmss");
            string listUrl = url + "files.txt?v=" + random;
            Debug.LogWarning("LoadUpdate---->>>" + listUrl);

            WWW www = new WWW(listUrl); yield return www;
            if (www.error != null)
            {
                OnUpdateFailed(string.Empty);
                ShowNetTip();
                yield break;
            }
            if (!Directory.Exists(dataPath))
            {
                Directory.CreateDirectory(dataPath);
            }
            File.WriteAllBytes(dataPath + "files.txt", www.bytes);
            string filesText = www.text;
            string[] files = filesText.Split('\n');

            txtInfo.text = "正在检查更新...";
            txtPer.text = "0%";
            pgsPer.fillAmount = 0;
            //SetFillAmountPos(0);

            List<string> needUpdateFiles = new List<string>();
            List<int> fileLens = new List<int>();

            for (int i = 0; i < files.Length; i++)
            {
                if (string.IsNullOrEmpty(files[i])) continue;
                string[] keyValue = files[i].Split('|');
                string f = keyValue[0];
                string localfile = (dataPath + f).Trim();
                string path = Path.GetDirectoryName(localfile);
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                // string fileUrl = url + f + "?v=" + random;
                bool canUpdate = !File.Exists(localfile);
                if (!canUpdate)
                {
                    string remoteMd5 = keyValue[1].Trim();
                    string localMd5 = Util.md5file(localfile);
                    canUpdate = !remoteMd5.Equals(localMd5);
                    if (canUpdate) File.Delete(localfile);
                }
                if (canUpdate)
                {   //本地缺少文件
                    int fl = int.Parse(keyValue[2].Trim());
                    bytesTotal += fl;
                    needUpdateFiles.Add(f);
                    fileLens.Add(fl);
                    // Debug.Log(fileUrl);
                    // message = "downloading>>" + fileUrl;
                    // facade.SendMessageCommand(NotiConst.UPDATE_MESSAGE, message);
                    /*
                    www = new WWW(fileUrl); yield return www;
                    if (www.error != null) {
                        OnUpdateFailed(path);   //
                        yield break;
                    }
                    File.WriteAllBytes(localfile, www.bytes);
                     */
                    //这里都是资源文件，用线程下载
                    // BeginDownload(fileUrl, localfile);
                    // while (!(IsDownOK(localfile))) { yield return new WaitForEndOfFrame(); }
                }
            }

            if (AppConst.getNetType() == 2)
            {
                int needDown = bytesTotal / 1024 / 1024;
                if (needDown > 0)
                {
                    ShowUpdateTip(needDown + "MB");
                    while (!isUpdate)
                    {
                        yield return new WaitForEndOfFrame();
                    }
                }
            }

            txtInfo.text = "准备下载更新...";
            for (int i = 0; i < needUpdateFiles.Count; i++)
            {
                string file = needUpdateFiles[i];
                int size = fileLens[i];
                string localfile = (dataPath + file).Trim();
                string fileUrl = url + file + "?v=" + random;

                Debug.Log(fileUrl);
                message = "downloading>>" + fileUrl;
                facade.SendMessageCommand(NotiConst.UPDATE_MESSAGE, message);

                www = new WWW(fileUrl);
                while (!www.isDone)
                {
                    int loaded = bytesLoaded + (int)(www.progress * size);
                    txtPer.text = (int)((float)loaded / bytesTotal * 100) + "%";
                    pgsPer.fillAmount = (float)loaded / bytesTotal;
                    //SetFillAmountPos((float)loaded / bytesTotal);
                    txtInfo.text = "正在下载更新...(" + loaded / 1024 + "KB)";
                    yield return new WaitForEndOfFrame();
                }
                bytesLoaded += size;
                if (www.error != null)
                {
                    OnUpdateFailed(fileUrl);   //
                    ShowNetTip();
                    yield break;
                }
                File.WriteAllBytes(localfile, www.bytes);
                // BeginDownload(fileUrl, localfile);
                // while (!(IsDownOK(localfile))) { 
                //     txtPer.text = (bytesLoaded*100/bytesTotal) + "%";
                //     pgsPer.fillAmount = (float)bytesLoaded / bytesTotal;
                //     yield return new WaitForEndOfFrame(); 
                // }
            }
            yield return new WaitForEndOfFrame();

            message = "更新完成!!";
            txtPer.text = "100%";
            pgsPer.fillAmount = 1;
            //SetFillAmountPos(1);
            AppConst.version = verNum;

            facade.SendMessageCommand(NotiConst.UPDATE_MESSAGE, message);

            OnResourceInited();
        }

        void OnUpdateFailed(string file)
        {
            string message = "更新失败!>" + file;
            facade.SendMessageCommand(NotiConst.UPDATE_MESSAGE, message);
        }

        /// <summary>
        /// 是否下载完成
        /// </summary>
        bool IsDownOK(string file)
        {
            return downloadFiles.Contains(file);
        }

        /// <summary>
        /// 线程下载
        /// </summary>
        void BeginDownload(string url, string file)
        {     //线程下载
            object[] param = new object[2] { url, file };

            ThreadEvent ev = new ThreadEvent();
            ev.Key = NotiConst.UPDATE_DOWNLOAD;
            ev.evParams.AddRange(param);
            ThreadManager.AddEvent(ev, OnThreadCompleted);   //线程下载
        }

        /// <summary>
        /// 线程完成
        /// </summary>
        /// <param name="data"></param>
        void OnThreadCompleted(NotiData data)
        {
            switch (data.evName)
            {
                case NotiConst.UPDATE_EXTRACT:  //解压一个完成
                                                //
                    break;
                case NotiConst.UPDATE_PROGRESS:
                    // txtInfo.text = "正在下载更新(" + data.evParam.ToString() + ")";
                    Debug.Log(data.evParam.ToString());
                    break;
                case NotiConst.UPDATE_BYTES:
                    bytesLoaded += (int)data.evParam;
                    Debug.Log(bytesLoaded);
                    break;
                case NotiConst.UPDATE_DOWNLOAD: //下载一个完成
                    downloadFiles.Add(data.evParam.ToString());
                    break;
            }
        }

        /// <summary>
        /// 资源初始化结束
        /// </summary>
        public void OnResourceInited()
        {
#if ASYNC_MODE
            ResManager.Initialize(AppConst.AssetDir, delegate ()
            {
                Debug.Log("Initialize OK!!!");
                this.OnInitialize();
            });
#else
            ResManager.Initialize();
            this.OnInitialize();
#endif
        }

        void OnInitialize()
        {
            LuaManager.InitStart();
            LuaManager.DoFile("Logic/Game");         //加载游戏
            LuaManager.DoFile("Logic/Network");      //加载网络
            LuaManager.DoFile("Logic/ObjectPool");
            NetManager.OnInit();                     //初始化网络
            ObjPoolManager.OnInit();                 //初始化对象池

            Util.CallMethod("Game", "OnInitOK", isReload);     //初始化完成
            initialize = true;

            //RenderTexture tex = new RenderTexture(128, 128, 1, RenderTextureFormat.ARGB32);
            //Texture2D texture2D = new Texture2D(256, 256);
            //texture2D.ReadPixels()
            //Sprite sprite = Sprite.Create(tx, new Rect(0, 0, tex.width, tex.height), new Vector2(0.5f, 0.5f));


            //类对象池测试
            // var classObjPool = ObjPoolManager.CreatePool<TestObjectClass>(OnPoolGetElement, OnPoolPushElement);
            //方法1
            //objPool.Release(new TestObjectClass("abcd", 100, 200f));
            //var testObj1 = objPool.Get();

            //方法2
            //ObjPoolManager.Release<TestObjectClass>(new TestObjectClass("abcd", 100, 200f));
            //var testObj1 = ObjPoolManager.Get<TestObjectClass>();

            //Debugger.Log("TestObjectClass--->>>" + testObj1.ToString());

            //游戏对象池测试
            //var prefab = Resources.Load("TestGameObjectPrefab", typeof(GameObject)) as GameObject;
            //var gameObjPool = ObjPoolManager.CreatePool("TestGameObject", 5, 10, prefab);

            //var gameObj = Instantiate(prefab) as GameObject;
            //gameObj.name = "TestGameObject_01";
            //gameObj.transform.localScale = Vector3.one;
            //gameObj.transform.localPosition = Vector3.zero;

            //ObjPoolManager.Release("TestGameObject", gameObj);
            //var backObj = ObjPoolManager.Get("TestGameObject");
            //backObj.transform.SetParent(null);

            //Debug.Log("TestGameObject--->>>" + backObj);
        }

        ///// <summary>
        ///// 当从池子里面获取时
        ///// </summary>
        ///// <param name="obj"></param>
        //void OnPoolGetElement(TestObjectClass obj) {
        //    Debug.Log("OnPoolGetElement--->>>" + obj);
        //}

        ///// <summary>
        ///// 当放回池子里面时
        ///// </summary>
        ///// <param name="obj"></param>
        //void OnPoolPushElement(TestObjectClass obj) {
        //    Debug.Log("OnPoolPushElement--->>>" + obj);
        //}

        /// <summary>
        /// 析构函数
        /// </summary>
        void OnDestroy()
        {


            if (NetManager != null)
            {
                NetManager.Unload();
            }
            if (LuaManager != null)
            {
                LuaManager.Close();
            }
            Debug.Log("~GameManager was destroyed");
        }

        void Update()
        {
            if (initialize)
                Util.CallMethod("Game", "Update");     //初始化完成
        }


        public void ShowUpdateTip(string updateSize)
        {
            tipType = 1;
            Tips.text = "您当前未处于WiFi网络，本次更新将消耗" + updateSize + "数据流量，是否继续更新？";
            updateTipsPanel.gameObject.SetActive(true);
        }
        private void ShowVersionTip()
        {
            tipType = 0;
            Tips.text = "发现新版本，请下载最新版本";
            updateTipsPanel.gameObject.SetActive(true);
        }

        public void ShowNetTip()
        {
            tipType = 2;
            Tips.text = "当前网络不稳定，请稍后重试";
            updateTipsPanel.gameObject.SetActive(true);
        }

        private void OnYesClick()
        {
            if (tipType == 1)
                isUpdate = true;
            else if (tipType == 2)
                Application.Quit();
            else if (tipType == 0)
                Application.OpenURL(AppConst.DownUrl);
            updateTipsPanel.gameObject.SetActive(false);
        }
        private void OnNoClick()
        {
            if (tipType == 1)
            {
                isUpdate = false;
                Application.Quit();
            }
            else if (tipType == 2)
                Application.Quit();
            else if (tipType == 0)
                Application.Quit();
            updateTipsPanel.gameObject.SetActive(false);
        }
    }
}