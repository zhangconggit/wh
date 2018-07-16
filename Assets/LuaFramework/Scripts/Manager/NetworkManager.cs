using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;

namespace LuaFramework
{
    public class NetworkManager : Manager
    {
        private static SocketClient socket;
        static readonly object m_lockObject = new object();
        static Queue<KeyValuePair<int, ByteBuffer>> mEvents = new Queue<KeyValuePair<int, ByteBuffer>>();
        public static bool isConnect
        {
            get
            {
                return SocketClient.isConnect;
            }
        }
        public static int enCount = 0;
        public static int deCount = 0;

        private static SocketClient SocketClient
        {
            get
            {
                if (socket == null)
                    socket = new SocketClient();
                return socket;
            }
        }

        public void OnInit()
        {
            CallMethod("Start");
        }

        public void Unload()
        {
            CallMethod("Unload");
        }

        public static void NotConnect()
        {
            CallMethod("NotConnect");
        }

        /// <summary>
        /// 执行Lua方法
        /// </summary>
        public static object[] CallMethod(string func, params object[] args)
        {
            return Util.CallMethod("Network", func, args);
        }

        ///------------------------------------------------------------------------------------
        public static void AddEvent(int _event, ByteBuffer data)
        {
            lock (m_lockObject)
            {
                mEvents.Enqueue(new KeyValuePair<int, ByteBuffer>(_event, data));
                enCount++;
                Debug.Log("====mEvents.Enqueue " + _event + " " + enCount + " " + deCount);
            }
        }

        /// <summary>
        /// 交给Command，这里不想关心发给谁。
        /// </summary>
        void Update()
        {
            if (mEvents.Count > 0)
            {
                while (mEvents.Count > 0)
                {
                    lock (m_lockObject)
                    {
                        KeyValuePair<int, ByteBuffer> _event = mEvents.Dequeue();
                        facade.SendMessageCommand(NotiConst.DISPATCH_MESSAGE, _event);
                        deCount++;

                        Debug.Log("====mEvents.Dequeue " + _event.Key + " " + enCount + " " + deCount);
                    }
                }
            }
        }

        /// <summary>
        /// 发送链接请求
        /// </summary>
        public void SendConnect()
        {
            SocketClient.ConnectServer(AppConst.SocketAddress, AppConst.SocketPort);
        }

        /// <summary>
        /// 发送SOCKET消息
        /// </summary>
        public void SendMessage(ByteBuffer buffer)
        {
            SocketClient.SendMessage(buffer);
        }
        /// <summary>
        /// 关闭Socket
        /// </summary>
        public void SocketClose()
        {
            SocketClient.Close();
        }

        /// <summary>
        /// 析构函数
        /// </summary>
        void OnDestroy()
        {
            SocketClient.OnRemove();
            Debug.Log("~NetworkManager was destroy");
        }
    }
}