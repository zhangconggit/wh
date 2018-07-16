using System;

/// <summary>
/// 网狐异或加密算法
/// </summary>
public class WHXorEncrypt
{
    private static uint m_dwSendXorKey = 123;						// 发送密钥
    private static uint m_dwRecvXorKey = 123;						// 接收密钥
    private static uint g_dwPacketKey  = 0xA55AA55A;                // 加密密钥

    /// <summary>
    /// 产生加密密钥
    /// </summary>
    public static uint GenSendXorKey()
    {
        uint    dwXorKey = 0;
        byte[]  byGuid = null;
        Guid    guid;

        guid = System.Guid.NewGuid();
        byGuid = guid.ToByteArray();
        dwXorKey = (uint)(Environment.TickCount * Environment.TickCount);
        dwXorKey ^= byGuid[1];
        dwXorKey ^= byGuid[2];
        dwXorKey ^= byGuid[3];
        dwXorKey ^= byGuid[byGuid.Length - 1];

        //随机映射种子
        dwXorKey = SeedRandMap((ushort)dwXorKey);
        dwXorKey |= ((uint)SeedRandMap((ushort)(dwXorKey >> 16))) << 16;
        dwXorKey ^= g_dwPacketKey;

        return dwXorKey;
    }

    /// <summary>
    /// 由两个BYTE组合成一个WORD
    /// </summary>
    /// <param name="hb">高位BYTE</param>
    /// <param name="lb">低位BYTE</param>
    private static ushort MakeWord(byte bHightByte, byte bLowByte)
    {
        int nWord = bHightByte;
        nWord = (nWord << 8 | bLowByte);
        return (ushort)nWord;
    }

    /// <summary>
    /// 由四个BYTE组合成一个DWORD
    /// </summary>
    /// <param name="bytes">BYTE数组</param>
    /// <param name="index">开始下标</param>
    private static uint MakeDWord(byte[] bByteArr, int nIndex)
    {
        uint nDWORD = 0;
        for (int nI = 0; nI < 4; nI++)
        {
            nDWORD |= (uint)bByteArr[nIndex + nI] << 8 * nI;
        }
        return nDWORD;
    }

    /// <summary>
    /// 由DWORD转换成BYTE数组
    /// </summary>
    /// <param name="dwInteger">要转换的整数</param>
    private static byte[] MakeByteArr(uint unDWORD)
    {
        byte[] bByteArr = new byte[4];
        bByteArr[0] = (byte)(unDWORD);
        bByteArr[1] = (byte)(unDWORD >> 8);
        bByteArr[2] = (byte)(unDWORD >> 16);
        bByteArr[3] = (byte)(unDWORD >> 24);
        return bByteArr;
    }

    /// <summary>
    /// 随机映射
    /// </summary>
    private static uint SeedRandMap(ushort wSeed)
    {
        uint dwHold = wSeed;
        return (ushort)((dwHold * 241103L + 2533101L) >> 16);
    }

    /// <summary>
    /// 设置密钥
    /// </summary>
    public static void SetXorKey(uint nXorKey)
    {
        m_dwSendXorKey = nXorKey;
        m_dwRecvXorKey = nXorKey;
    }

    /// <summary>
    /// 加密数据
    /// </summary>
    /// <param name="pcbDataBuffer">要加密的数组</param>
    /// <param name="nStartIndex">开始位</param>
    /// <param name="wDataSize">数据长度</param>
    /// <returns>加密后的数据</returns>
    public static byte[] Encrypt(ref byte[] pcbDataBuffer, int nStartIndex, ushort wDataSize)
    {
        byte[] byDataBuffer = null;

        // 创建密钥
        uint dwXorKey = m_dwSendXorKey;

        // 调整长度
        ushort wEncryptSize = wDataSize, wSnapCount = 0;
        if ((wEncryptSize % 4) != 0)
        {
            wSnapCount = (ushort)(4 - wEncryptSize % 4);
        }
        byDataBuffer = new byte[wDataSize + wSnapCount];
        Array.Copy(pcbDataBuffer, nStartIndex, byDataBuffer, 0, wDataSize);

        // 加密数据
        ushort  wXorIndex    = 0;
        ushort  wXorHigh     = 0;
        ushort  wXorLow      = 0;
        uint    dwTempXor    = 0;
        ushort  wEncrypCount = (ushort)((wEncryptSize + wSnapCount) / 4);
        for (ushort i = 0; i < wEncrypCount; i++)
        {
            // 取出高低位，以4个位作为一个整体，进行异或运算
            dwTempXor = MakeDWord(byDataBuffer, wXorIndex);
            dwTempXor ^= dwXorKey;

            // 将异或的结果，赋值给原来的数据，这就完成了4个位的加密
            byDataBuffer[wXorIndex] = (byte)(dwTempXor);
            byDataBuffer[wXorIndex + 1] = (byte)(dwTempXor >> 8);
            byDataBuffer[wXorIndex + 2] = (byte)(dwTempXor >> 16);
            byDataBuffer[wXorIndex + 3] = (byte)(dwTempXor >> 24);

            // 以加密过的数据为算子，对私钥进行下一轮转换，让后面加密的数据更加无规律
            wXorLow     = MakeWord(byDataBuffer[wXorIndex + 1], byDataBuffer[wXorIndex]);
            wXorHigh    = MakeWord(byDataBuffer[wXorIndex + 3], byDataBuffer[wXorIndex + 2]);
            dwXorKey    = SeedRandMap(wXorLow);
            dwXorKey    |= (uint)SeedRandMap(wXorHigh) << 16;
            dwXorKey    = dwXorKey ^ g_dwPacketKey;

            wXorIndex += 4;
        }

        // 由这次加密而产生的加密算子，又作为下一次的加密算子，环环相扣，黑客在两次发送数据之间插入自己的数据，服务器是没办法解密的
        m_dwSendXorKey = dwXorKey;

        return byDataBuffer;
    }

    /// <summary>
    /// 解密数据
    /// </summary>
    /// <param name="pcbDataBuffer">要解密的数据</param>
    /// <param name="wDataSize">数据的长度</param>
    /// <returns>解密后数据的长度</returns>
    public static byte[] Crevasse(ref byte[] pcbDataBuffer, int nStartIndex, ushort wDataSize)
    {
        byte[] byDataBuffer = null;

        //调整长度
        ushort wSnapCount = 0;
        if ((wDataSize % 4) != 0)
        {
            wSnapCount = (ushort)(4 - wDataSize % 4);
        }
        byDataBuffer = new byte[wDataSize + wSnapCount];
        Array.Copy(pcbDataBuffer, nStartIndex, byDataBuffer, 0, wDataSize);

        //解密数据
        uint    dwXorKey    = m_dwRecvXorKey;
        ushort  wXorIndex   = 0;
        ushort  wXorHigh    = 0;
        ushort  wXorLow     = 0;
        uint    dwTempXor   = 0;
        ushort  wEncrypCount = (ushort)((wDataSize + wSnapCount) / 4);
        for (ushort i = 0; i < wEncrypCount; i++)
        {
            if ((i == (wEncrypCount - 1)) && (wSnapCount > 0))
            {
                byte[] cbRecvXorArry = MakeByteArr(m_dwRecvXorKey);
                Array.Copy(cbRecvXorArry, 4 - wSnapCount, byDataBuffer, wDataSize, wSnapCount);
            }

            // 取出高低位
            wXorHigh = MakeWord(byDataBuffer[wXorIndex + 3], byDataBuffer[wXorIndex + 2]);
            wXorLow = MakeWord(byDataBuffer[wXorIndex + 1], byDataBuffer[wXorIndex]);

            // 还原下一个异或算子
            dwXorKey = SeedRandMap(wXorLow);
            dwXorKey |= (uint)SeedRandMap(wXorHigh) << 16;
            dwXorKey = dwXorKey ^ g_dwPacketKey;

            // 以4个位作为一个整体，进行异或运算
            dwTempXor = MakeDWord(byDataBuffer, wXorIndex);
            dwTempXor ^= m_dwRecvXorKey;

            // 将异或的结果，赋值给原来的数据，这就完成了4个位的解密
            byDataBuffer[wXorIndex] = (byte)(dwTempXor);
            byDataBuffer[wXorIndex + 1] = (byte)(dwTempXor >> 8);
            byDataBuffer[wXorIndex + 2] = (byte)(dwTempXor >> 16);
            byDataBuffer[wXorIndex + 3] = (byte)(dwTempXor >> 24);

            m_dwRecvXorKey = dwXorKey;
            wXorIndex += 4;
        }

        // 由这次解密而产生的解密算子，又作为下一次的解密算子，环环相扣，黑客在两次发送数据之间插入自己的数据，会导致解密失败
        m_dwRecvXorKey = dwXorKey;

        return byDataBuffer;
    }
}