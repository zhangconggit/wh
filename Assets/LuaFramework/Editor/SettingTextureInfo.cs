using System;
using System.IO;
using LuaInterface;
using UnityEngine;
using UnityEditor;
using Object = UnityEngine.Object;

public class SettingTextureInfo
{
    [MenuItem("LuaFramework/TextureEdit %g", false, 301)]
    static void EditTexture()
    {
        Object[] selectObjs = Selection.objects;
        foreach (Object targetObj in selectObjs)
        {
            if (targetObj != null && targetObj is Texture)
            {
                string path = AssetDatabase.GetAssetPath(targetObj);
                TextureImporter textureImporter = AssetImporter.GetAtPath(path) as TextureImporter;
                textureImporter.textureType = TextureImporterType.Sprite;
                textureImporter.spriteImportMode = SpriteImportMode.Single;
                string[] excisionArray = path.Split('/');
                string packingTag = excisionArray[excisionArray.Length - 2];
                textureImporter.spritePackingTag = packingTag;
                textureImporter.spritePixelsPerUnit = 100;
                textureImporter.filterMode = FilterMode.Bilinear;
                textureImporter.mipmapEnabled = false;
                textureImporter.textureFormat = TextureImporterFormat.AutomaticTruecolor;
                int size;
                try
                {
                    using (FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read))
                    {
                        System.Drawing.Image image = System.Drawing.Image.FromStream(fs);
                        size = image.Width > image.Height ? image.Width : image.Height;
                    }
                }
                catch (Exception e)
                {
                    Console.WriteLine(e);
                    throw;
                }
                int maxSize = size;
                if (size < 32)
                    maxSize = 32;
                else if (32 < size && size < 64)
                    maxSize = 64;
                else if (64 < size && size < 128)
                    maxSize = 128;
                else if (128 < size && size < 256)
                    maxSize = 256;
                else if (256 < size && size < 512)
                    maxSize = 512;
                else if (512 < size && size < 1024)
                    maxSize = 1024;
                else if (1024 < size && size < 2048)
                    maxSize = 2048;
                else if (2048 < size && size < 4096)
                    maxSize = 4096;
                else if (4096 < size && size < 8192)
                    maxSize = 8192;
                else
                    Debugger.LogWarning("Select Texture Not Setting Max Size");
                Debugger.Log("File Path：" + path + "   File Size:" + size + "   Setting MaxSize:" + maxSize + "    Packing Tag:" + packingTag);
                textureImporter.SetPlatformTextureSettings("iPhone", maxSize, TextureImporterFormat.AutomaticTruecolor);
                textureImporter.SetPlatformTextureSettings("Android", maxSize, TextureImporterFormat.AutomaticTruecolor);
                textureImporter.SetPlatformTextureSettings("Standalone", maxSize, TextureImporterFormat.AutomaticTruecolor);
                AssetDatabase.ImportAsset(path);
            }
        }
    }
}
