using UnityEngine;
using System.Collections.Generic;
using UnityEditor;
using System.IO;
using System.Text;
using LuaFramework;
using System.Diagnostics;


public class BuildPbluaWindow : EditorWindow
{

    [MenuItem("LuaFramework/BuildPbLua", false, 203)]
    static void SetAssetBundleNameExtension()
    {
        EditorWindow.GetWindow<BuildPbluaWindow>();
    }

    /// <summary>
    /// 数据目录
    /// </summary>
    static string AppDataPath
    {
        get { return Application.dataPath.ToLower(); }
    }


    string fileName = "";

    void OnGUI()
    {
        EditorGUILayout.BeginHorizontal();

        fileName = EditorGUILayout.TextField("文件名称：", fileName);


        if (GUILayout.Button("开始生成"))
        {
            if (!AppConst.ExampleMode)
            {
                UnityEngine.Debug.LogError("若使用编码Protobuf-lua-gen功能，需要自己配置外部环境！！");
                return;
            }

            string dir = AppDataPath + "/LuaFramework/Lua/3rd/pblua/";
            string protoc = "d:/protobuf-2.5.0/src/protoc.exe";
            string protoc_gen_dir = "\"d:/protoc-gen-lua/plugin/protoc-gen-lua.bat\"";


            ProcessStartInfo info = new ProcessStartInfo();
            info.FileName = protoc;
            info.Arguments = " --lua_out=./ --plugin=protoc-gen-lua=" + protoc_gen_dir + " " + fileName;
            info.WindowStyle = ProcessWindowStyle.Hidden;
            info.UseShellExecute = true;
            info.WorkingDirectory = dir;
            info.ErrorDialog = true;
            Util.Log(info.FileName + " " + info.Arguments);

            Process pro = Process.Start(info);
            pro.WaitForExit();

            AssetDatabase.Refresh();
        }

        EditorGUILayout.EndHorizontal();

    }



}