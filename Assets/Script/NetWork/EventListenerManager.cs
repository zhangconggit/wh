using System;
using UnityEngine;
using System.Collections.Generic;

namespace YunvaIM
{
    public delegate void Callback<T>(T arg1);

    static public class EventListenerManager
    {
        private static Dictionary<ProtocolEnum, Delegate> mProtocolEventTable = new Dictionary<ProtocolEnum, Delegate>();

        public static void AddListener(ProtocolEnum protocolEnum, Callback<object> kHandler)
        {
            lock (mProtocolEventTable)
            {
                if (!mProtocolEventTable.ContainsKey(protocolEnum))
                {
                    mProtocolEventTable.Add(protocolEnum, null);
                }
                mProtocolEventTable[protocolEnum] = (Callback<object>)mProtocolEventTable[protocolEnum] + kHandler;
            }
        }

        public static void RemoveListener(ProtocolEnum protocolEnum, Callback<object> kHandler)
        {
            lock (mProtocolEventTable)
            {
                if (mProtocolEventTable.ContainsKey(protocolEnum))
                {
                    mProtocolEventTable[protocolEnum] = (Callback<object>)mProtocolEventTable[protocolEnum] - kHandler;
                    if (mProtocolEventTable[protocolEnum] == null)
                    {
                        mProtocolEventTable.Remove(protocolEnum);
                    }
                }
            }
        }

        public static void Invoke(ProtocolEnum protocolEnum, object arg1)
        {
            try
            {
                Delegate kDelegate;
                if (mProtocolEventTable.TryGetValue(protocolEnum, out kDelegate))
                {
                    Callback<object> kHandler = (Callback<object>)kDelegate;
                    if (kHandler != null)
                    {
                        if (arg1 != null) kHandler(arg1);
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.Log(ex.ToString());
            }
        }

        public static void UnInit()
        {
            if (mProtocolEventTable.Count > 0)
                mProtocolEventTable.Clear();
        }
    }
}
