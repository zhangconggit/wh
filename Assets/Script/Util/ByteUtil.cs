using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace Game.Util {
    public  class ByteUtil
    {

        public static byte[] int2Byte(int intValue)
        {
            byte[] b = new byte[4];
            for (int i = 0; i < 4; i++)
            {
                b[i] = (byte)(intValue >> 8 * (3 - i) & 0xFF);
            }

            return b;
        }

		public static byte[] int1Byte(int intValue)
		{
			byte[] b = new byte[1];
			for (int i = 0; i < 1; i++)
			{
				b[i] = (byte)(intValue >> 8 * (0 - i) & 0xFF);
			}

			return b;
		}
        public static byte[] getBytes(short s, bool asc)
        {
            byte[] buf = new byte[2];
            if (asc)
            {
                for (int i = buf.Length - 1; i >= 0; i--)
                {
                    buf[i] = (byte)(s & 0x00ff);
                    s >>= 8;
                }
            }
            else
            {
                for (int i = 0; i < buf.Length; i++)
                {

                    buf[i] = (byte)(s & 0x00ff);
                    s >>= 8;
                }
            }
            return buf;
        }
        public static byte[] getBytes(int s, bool asc)
        {
            byte[] buf = new byte[4];
            if (asc)
                for (int i = buf.Length - 1; i >= 0; i--)
                {
                    buf[i] = (byte)(s & 0x000000ff);
                    s >>= 8;
                }
            else
                for (int i = 0; i < buf.Length; i++)
                {
                    buf[i] = (byte)(s & 0x000000ff);
                    s >>= 8;
                }
            return buf;
        }

        public static byte[] getBytes(long s, bool asc)
        {
            byte[] buf = new byte[8];
            if (asc)
                for (int i = buf.Length - 1; i >= 0; i--)
                {
                    buf[i] = (byte)(s & 0x00000000000000ff);
                    s >>= 8;
                }
            else
                for (int i = 0; i < buf.Length; i++)
                {
                    buf[i] = (byte)(s & 0x00000000000000ff);
                    s >>= 8;
                }
            return buf;
        }

        public static short getShort(byte[] buf, bool asc)
        {
            if (buf == null)
            {
                //throw new IllegalArgumentException("byte array is null!");
            }
            if (buf.Length > 2)
            {
                //throw new IllegalArgumentException("byte array size > 2 !");
            }
            short r = 0;
            if (asc)
                for (int i = buf.Length - 1; i >= 0; i--)
                {
                    r <<= 8;
                    r |= (short)(buf[i] & 0x00ff);
                }
            else
                for (int i = 0; i < buf.Length; i++)
                {
                    r <<= 8;
                    r |= (short)(buf[i] & 0x00ff);
                }
            return r;
        }
        public static int getInt(byte[] buf, bool asc)
        {
            if (buf == null)
            {
                // throw new IllegalArgumentException("byte array is null!");
            }
            if (buf.Length > 4)
            {
                //throw new IllegalArgumentException("byte array size > 4 !");
            }
            int r = 0;
            if (asc)
                for (int i = buf.Length - 1; i >= 0; i--)
                {
                    r <<= 8;
                    r |= (buf[i] & 0x000000ff);
                }
            else
                for (int i = 0; i < buf.Length; i++)
                {
                    r <<= 8;
                    r |= (buf[i] & 0x000000ff);
                }
            return r;
        }


        public static long getLong(byte[] buf, bool asc)
        {
            if (buf == null)
            {
                //throw new IllegalArgumentException("byte array is null!");
            }
            if (buf.Length > 8)
            {
                //throw new IllegalArgumentException("byte array size > 8 !");
            }
            long r = 0;
            if (asc)
                for (int i = buf.Length - 1; i >= 0; i--)
                {
                    r <<= 8;
                    r |= (buf[i] & 0x00000000000000ff);
                }
            else
                for (int i = 0; i < buf.Length; i++)
                {
                    r <<= 8;
                    r |= (buf[i] & 0x00000000000000ff);
                }
            return r;
        }


        public static byte[] protobufSerialize<T>(T req){

             byte[] msgOut;

            using (var stream = new MemoryStream())
            {
                ProtoBuf.Serializer.Serialize(stream, req);
                msgOut =  stream.GetBuffer();
            }

            msgOut = LuaFramework.Util.encode(msgOut);
            return msgOut;
        }


 
    }
}