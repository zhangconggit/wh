using System;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;

/// <summary>
/// 客户端常量类
/// </summary>
public class ClientConstant
{
    /// <summary>
    /// 由byte数组转换为结构体
    /// </summary>
    public static T ByteToStructure<T>(byte[] dataBuffer)
    {
        object structure = null;
        int size = Marshal.SizeOf(typeof(T));
        IntPtr allocIntPtr = Marshal.AllocHGlobal(size);

        try
        {
            Marshal.Copy(dataBuffer, 0, allocIntPtr, size);
            structure = Marshal.PtrToStructure(allocIntPtr, typeof(T));
        }
        finally
        {
            Marshal.FreeHGlobal(allocIntPtr);
        }

        return (T)structure;
    }

    /// <summary>
    /// 由结构体转换为byte数组
    /// </summary>
    public static byte[] StructureToByte<T>(T structure)
    {
        int size = Marshal.SizeOf(typeof(T));
        byte[] buffer = new byte[size];
        IntPtr bufferIntPtr = Marshal.AllocHGlobal(size);

        try
        {
            Marshal.StructureToPtr(structure, bufferIntPtr, true);
            Marshal.Copy(bufferIntPtr, buffer, 0, size);
        }
        finally
        {
            Marshal.FreeHGlobal(bufferIntPtr);
        }

        return buffer;
    }

    /// <summary>
    /// 生成MD5
    /// </summary>
    public static string RevertToMD5(string sInput)
    {
        MD5 stMd5 = MD5.Create();
        byte[] byInput = Encoding.ASCII.GetBytes(sInput);
        byte[] byHash = stMd5.ComputeHash(byInput);
        StringBuilder stBuilder = new StringBuilder();

        for (int i = 0; i < byHash.Length; i++)
        {
            stBuilder.Append(byHash[i].ToString("X2"));
        }

        return stBuilder.ToString().ToLower();
    }
}

/// <summary>
/// 服务器数据单元
/// </summary>
public class ServerDataItem
{
    public ushort nMainCmd;
    public ushort nSubCmd;
    public byte[] byBody;
}