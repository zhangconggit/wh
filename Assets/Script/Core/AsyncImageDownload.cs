using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using System.IO;
using System;

public class AsyncImageDownload : MonoBehaviour
{
    public Sprite myWXPic;

    private static AsyncImageDownload _instance = null;
    public static AsyncImageDownload GetInstance() { return Instance; }
    public static AsyncImageDownload Instance
    {
        get
        {
            if (_instance == null)
            {
                GameObject obj = new GameObject("AsyncImageDownload");
                _instance = obj.AddComponent<AsyncImageDownload>();
                DontDestroyOnLoad(obj);
                _instance.Init();
            }
            return _instance;
        }
    }

    public bool Init()
    {
        if (!Directory.Exists(Application.persistentDataPath + "/ImageCache/"))
        {
            Directory.CreateDirectory(Application.persistentDataPath + "/ImageCache/");
        }
        myWXPic = null;
        return true;
    }

    public void SetAsyncImage(string url, Image image,string roleId)
    {
        string name = "";
        if (url == "") return;

        if (url == null )
        {
            name = GetSpriteWithoutURL(roleId);
        }
        else
        {
            name = roleId + url.GetHashCode();
        }
        ////开始下载图片前，将UITexture的主图片设置为占位图  
        //if (myWXPic != null)
        //{
        //    image.sprite = myWXPic;
        //    return;
        //}
        //判断是否是第一次加载这张图片  

        if (name == "")
        {
            return;
        }
        if (!File.Exists(path + name))
        {
            //如果之前不存在缓存文件  
            Debug.Log("+++++++++=======DownloadImage========" + roleId);
            StartCoroutine(DownloadImage(url, image, roleId));
        }
        else
        {
            Debug.Log("++++++++++++++++++=======LoadLocalImage========" + roleId);
            StartCoroutine(LoadLocalImage(name,image));
        }
    }

    IEnumerator DownloadImage(string url, Image image, string roleId)
    {
        if (url != "" && url != null)
        {
            Debug.Log("downloading new image:" + path + url.GetHashCode());//url转换HD5作为名字  
            WWW www = new WWW(url);
            yield return www;

            Texture2D tex2d = www.texture;
            //将图片保存至缓存路径  
            byte[] pngData = tex2d.EncodeToPNG();                         //将材质压缩成byte流  
            string name = roleId + url.GetHashCode();
            File.WriteAllBytes(path + name, pngData);        //然后保存到本地  
            string time = GetTimeStamp(DateTime.Now);
            PlayerPrefs.SetString(name, time);
            Sprite m_sprite = Sprite.Create(tex2d, new Rect(0, 0, tex2d.width, tex2d.height), new Vector2(0, 0));
            image.sprite = m_sprite;
            myWXPic = m_sprite;
        }
    }

    IEnumerator LoadLocalImage( string name,Image image)
    {
        string filePath = "file:///" + path + name;
        Debug.Log("getting local image:" + filePath);
        WWW www = new WWW(filePath);
        yield return www;

        Texture2D texture = www.texture;
        Sprite m_sprite = Sprite.Create(texture, new Rect(0, 0, texture.width, texture.height), new Vector2(0, 0));
        image.sprite = m_sprite;
        myWXPic = m_sprite;
    }

    public string path
    {
        get
        {
            //pc,ios //android :jar:file//  
            return Application.persistentDataPath + "/ImageCache/";

        }
    }

    // 获取时间戳
    public static string GetTimeStamp(DateTime time, int length = 6)
    {
        long ts = ConvertDateTimeToInt(time);
        return ts.ToString().Substring(0, length);
    }

    // 将c# DateTime时间格式转换为Unix时间戳格式  
    public static long ConvertDateTimeToInt(DateTime time)
    {
        DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new DateTime(1970, 1, 1, 0, 0, 0, 0));
        long t = (time.Ticks - startTime.Ticks) / 10000;   //除10000调整为13位      
        return t;
    }

    //获取本地图片及保存时间如果大于7天删除
    public void ClearPic() {
        //List<string> list = new List<string>();
        DirectoryInfo theFolder = new DirectoryInfo(path);
        string time = "";
        string nowTime = GetTimeStamp(DateTime.Now);
        //遍历文件获取文件名
        foreach (FileInfo NextFile in theFolder.GetFiles())
        {
            //list.Add(NextFile.Name);
            time = PlayerPrefs.GetString(NextFile.Name);
            if (time != "") {
                if (int.Parse(nowTime)-int.Parse(time) > 60 ) {
                    NextFile.Delete();
                    PlayerPrefs.DeleteKey(NextFile.Name);
                } 
            }
        }
    }

    //如果没有URL返回默认头像名
    public string GetSpriteWithoutURL(string roleId) {
        DirectoryInfo theFolder = new DirectoryInfo(path);
        bool isInFile = false;
        //遍历文件获取文件名
        foreach (FileInfo NextFile in theFolder.GetFiles())
        {
            isInFile = SplitName(roleId,NextFile.Name);
            if (isInFile)
            {
                string name = NextFile.Name.Replace(".meta", "");
                return NextFile.Name;
            }
        }
        return "";
    }

    //截取字符串
    private bool SplitName(string roleId,string name) {
        string curName = name;
        string curId = curName.Substring(0, roleId.Length);
        if (curId == roleId)
        {
            return true;
        }
        return false;
    }
}