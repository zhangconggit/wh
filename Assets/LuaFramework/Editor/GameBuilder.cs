using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using System.IO;
using System.Text;
using LuaFramework;

public enum TargetEnum
{
    Android,
    iOS,
}

public enum FileEnum
{
    temp,
    zhajinhua,
    niuniu,
}

public class GameBuilder : EditorWindow
{
    private string fileName;
    private string content;
    private BuildTarget target;
    private TargetEnum te = TargetEnum.Android;
    private FileEnum fe = FileEnum.temp;
    private List<AssetBundleBuild> maps = new List<AssetBundleBuild>();
    private List<string> filePaths = new List<string>();

    [MenuItem("LuaFramework/Build Game Resources", false, 104)]
    static void BuildGameResources()
    {
        EditorWindow.GetWindow<GameBuilder>();
    }

    void OnGUI()
    {
        EditorGUILayout.BeginHorizontal();
        if (GUILayout.Button("读取文件(*.csv)"))
        {
            fileName = EditorUtility.OpenFilePanel("", Application.dataPath, "csv");
            content = File.ReadAllText(fileName);
        }

        te = (TargetEnum)EditorGUILayout.EnumPopup("平台", te);
        if (te == TargetEnum.Android)
            target = BuildTarget.Android;
        else if (te == TargetEnum.iOS)
            target = BuildTarget.iOS;

        fe = (FileEnum)EditorGUILayout.EnumPopup("文本列表名", fe);
        EditorGUILayout.EndHorizontal();

        EditorGUILayout.BeginHorizontal();
        EditorGUILayout.LabelField(fileName);
        if (GUILayout.Button("生成AssetBundle"))
        {
            BuildFiles();
        }
        EditorGUILayout.EndHorizontal();
    }

    void BuildFiles()
    {
        string[] contents = content.Split(new string[] { "\r\n" }, System.StringSplitOptions.RemoveEmptyEntries);
        maps.Clear();
        for (int i = 0; i < contents.Length; i++)
        {
            string[] a = contents[i].Split(',');
            AddBuildMap(a[0], a[1], a[2]);
        }

        string resPath = "Assets/" + AppConst.AssetDir;
        BuildAssetBundleOptions options = BuildAssetBundleOptions.None;
        BuildPipeline.BuildAssetBundles(resPath, maps.ToArray(), options, target);
        if (fe != FileEnum.temp)
            BuildFileIndex();
    }

    void AddBuildMap(string bundleName, string pattern, string path)
    {
        string[] files = Directory.GetFiles(path, pattern);
        if (files.Length == 0) return;

        for (int i = 0; i < files.Length; i++)
        {
            files[i] = files[i].Replace('\\', '/');
        }
        AssetBundleBuild build = new AssetBundleBuild();
        build.assetBundleName = bundleName;
        build.assetNames = files;
        maps.Add(build);
        filePaths.Add(bundleName);
    }

    void BuildFileIndex()
    {
        string resPath = Application.dataPath + "/StreamingAssets/";
        string newFilePath = resPath + fe.ToString() + ".txt";
        if (File.Exists(newFilePath)) File.Delete(newFilePath);

        FileStream fs = new FileStream(newFilePath, FileMode.CreateNew);
        StreamWriter sw = new StreamWriter(fs);
        for (int i = 0; i < filePaths.Count; i++)
        {
            string file = filePaths[i];
            string ext = Path.GetExtension(file);
            if (file.EndsWith(".meta") || file.Contains(".DS_Store")) continue;

            string md5 = Util.md5file(file);
            string value = file.Replace(resPath, string.Empty);
            FileStream ofs = new FileStream(file, FileMode.Open);
            sw.WriteLine(value + "|" + md5 + "|" + ofs.Length);
            ofs.Close();
        }
        sw.Close(); fs.Close();
        filePaths.Clear();
    }
}
