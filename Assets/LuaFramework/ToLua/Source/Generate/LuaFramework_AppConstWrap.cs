﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class LuaFramework_AppConstWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaFramework.AppConst), typeof(System.Object));
		L.RegFunction("getCurrentPlatform", getCurrentPlatform);
		L.RegFunction("getDeviceID", getDeviceID);
		L.RegFunction("getNetworkLevel", getNetworkLevel);
		L.RegFunction("getNetState", getNetState);
		L.RegFunction("getNetType", getNetType);
		L.RegFunction("GetBatteryLevel", GetBatteryLevel);
		L.RegFunction("Vibrate", Vibrate);
		L.RegFunction("setPlayerPrefs", setPlayerPrefs);
		L.RegFunction("getPlayerPrefs", getPlayerPrefs);
		L.RegFunction("DeleteKey", DeleteKey);
		L.RegFunction("ChangeCode", ChangeCode);
		L.RegFunction("GetDate", GetDate);
		L.RegFunction("New", _CreateLuaFramework_AppConst);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("DebugMode", get_DebugMode, set_DebugMode);
		L.RegVar("ExampleMode", get_ExampleMode, set_ExampleMode);
		L.RegVar("UpdateMode", get_UpdateMode, set_UpdateMode);
		L.RegVar("LuaByteMode", get_LuaByteMode, set_LuaByteMode);
		L.RegVar("LuaBundleMode", get_LuaBundleMode, set_LuaBundleMode);
		L.RegVar("TimerInterval", get_TimerInterval, set_TimerInterval);
		L.RegVar("GameFrameRate", get_GameFrameRate, set_GameFrameRate);
		L.RegVar("AppName", get_AppName, set_AppName);
		L.RegVar("LuaTempDir", get_LuaTempDir, set_LuaTempDir);
		L.RegVar("AppPrefix", get_AppPrefix, set_AppPrefix);
		L.RegVar("ExtName", get_ExtName, set_ExtName);
		L.RegVar("spineAb", get_spineAb, set_spineAb);
		L.RegVar("AssetDir", get_AssetDir, set_AssetDir);
		L.RegVar("ConfigUrl", get_ConfigUrl, set_ConfigUrl);
		L.RegVar("WebUrl", get_WebUrl, set_WebUrl);
		L.RegVar("DownUrl", get_DownUrl, set_DownUrl);
		L.RegVar("UserId", get_UserId, set_UserId);
		L.RegVar("SocketPort", get_SocketPort, set_SocketPort);
		L.RegVar("SocketAddress", get_SocketAddress, set_SocketAddress);
		L.RegVar("uuuIdKey", get_uuuIdKey, set_uuuIdKey);
		L.RegVar("uuuIdKeyBytes", get_uuuIdKeyBytes, set_uuuIdKeyBytes);
		L.RegVar("keyIndex", get_keyIndex, set_keyIndex);
		L.RegVar("keyLength", get_keyLength, set_keyLength);
		L.RegVar("ticketBytes", get_ticketBytes, set_ticketBytes);
		L.RegVar("ticketLength", get_ticketLength, set_ticketLength);
		L.RegVar("ticketIndex", get_ticketIndex, set_ticketIndex);
		L.RegVar("version", get_version, set_version);
		L.RegVar("appId", get_appId, set_appId);
		L.RegVar("appSecret", get_appSecret, set_appSecret);
		L.RegVar("FrameworkRoot", get_FrameworkRoot, null);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int _CreateLuaFramework_AppConst(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 0)
			{
				LuaFramework.AppConst obj = new LuaFramework.AppConst();
				ToLua.PushObject(L, obj);
				return 1;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: LuaFramework.AppConst.New");
			}
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int getCurrentPlatform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string o = LuaFramework.AppConst.getCurrentPlatform();
			LuaDLL.lua_pushstring(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int getDeviceID(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string o = LuaFramework.AppConst.getDeviceID();
			LuaDLL.lua_pushstring(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int getNetworkLevel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int o = LuaFramework.AppConst.getNetworkLevel();
			LuaDLL.lua_pushinteger(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int getNetState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int o = LuaFramework.AppConst.getNetState();
			LuaDLL.lua_pushinteger(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int getNetType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int o = LuaFramework.AppConst.getNetType();
			LuaDLL.lua_pushinteger(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetBatteryLevel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int o = LuaFramework.AppConst.GetBatteryLevel();
			LuaDLL.lua_pushinteger(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Vibrate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaFramework.AppConst.Vibrate();
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int setPlayerPrefs(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string arg0 = ToLua.CheckString(L, 1);
			string arg1 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.setPlayerPrefs(arg0, arg1);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int getPlayerPrefs(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string arg0 = ToLua.CheckString(L, 1);
			string o = LuaFramework.AppConst.getPlayerPrefs(arg0);
			LuaDLL.lua_pushstring(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int DeleteKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string arg0 = ToLua.CheckString(L, 1);
			LuaFramework.AppConst.DeleteKey(arg0);
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int ChangeCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			byte[] arg0 = ToLua.CheckByteBuffer(L, 1);
			string o = LuaFramework.AppConst.ChangeCode(arg0);
			LuaDLL.lua_pushstring(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int GetDate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string o = LuaFramework.AppConst.GetDate();
			LuaDLL.lua_pushstring(L, o);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_DebugMode(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, LuaFramework.AppConst.DebugMode);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_ExampleMode(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, LuaFramework.AppConst.ExampleMode);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_UpdateMode(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, LuaFramework.AppConst.UpdateMode);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_LuaByteMode(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, LuaFramework.AppConst.LuaByteMode);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_LuaBundleMode(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, LuaFramework.AppConst.LuaBundleMode);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_TimerInterval(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LuaFramework.AppConst.TimerInterval);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_GameFrameRate(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LuaFramework.AppConst.GameFrameRate);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_AppName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.AppName);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_LuaTempDir(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.LuaTempDir);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_AppPrefix(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.AppPrefix);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_ExtName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.ExtName);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_spineAb(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.spineAb);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_AssetDir(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.AssetDir);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_ConfigUrl(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.ConfigUrl);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_WebUrl(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.WebUrl);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_DownUrl(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.DownUrl);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_UserId(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.UserId);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_SocketPort(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LuaFramework.AppConst.SocketPort);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_SocketAddress(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.SocketAddress);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_uuuIdKey(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.uuuIdKey);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_uuuIdKeyBytes(IntPtr L)
	{
		try
		{
			ToLua.Push(L, LuaFramework.AppConst.uuuIdKeyBytes);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_keyIndex(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LuaFramework.AppConst.keyIndex);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_keyLength(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LuaFramework.AppConst.keyLength);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_ticketBytes(IntPtr L)
	{
		try
		{
			ToLua.Push(L, LuaFramework.AppConst.ticketBytes);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_ticketLength(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LuaFramework.AppConst.ticketLength);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_ticketIndex(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, LuaFramework.AppConst.ticketIndex);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_version(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.version);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_appId(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.appId);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_appSecret(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.appSecret);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int get_FrameworkRoot(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, LuaFramework.AppConst.FrameworkRoot);
			return 1;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_DebugMode(IntPtr L)
	{
		try
		{
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			LuaFramework.AppConst.DebugMode = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_ExampleMode(IntPtr L)
	{
		try
		{
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			LuaFramework.AppConst.ExampleMode = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_UpdateMode(IntPtr L)
	{
		try
		{
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			LuaFramework.AppConst.UpdateMode = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_LuaByteMode(IntPtr L)
	{
		try
		{
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			LuaFramework.AppConst.LuaByteMode = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_LuaBundleMode(IntPtr L)
	{
		try
		{
			bool arg0 = LuaDLL.luaL_checkboolean(L, 2);
			LuaFramework.AppConst.LuaBundleMode = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_TimerInterval(IntPtr L)
	{
		try
		{
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			LuaFramework.AppConst.TimerInterval = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_GameFrameRate(IntPtr L)
	{
		try
		{
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			LuaFramework.AppConst.GameFrameRate = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_AppName(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.AppName = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_LuaTempDir(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.LuaTempDir = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_AppPrefix(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.AppPrefix = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_ExtName(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.ExtName = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_spineAb(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.spineAb = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_AssetDir(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.AssetDir = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_ConfigUrl(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.ConfigUrl = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_WebUrl(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.WebUrl = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_DownUrl(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.DownUrl = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_UserId(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.UserId = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_SocketPort(IntPtr L)
	{
		try
		{
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			LuaFramework.AppConst.SocketPort = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_SocketAddress(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.SocketAddress = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_uuuIdKey(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.uuuIdKey = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_uuuIdKeyBytes(IntPtr L)
	{
		try
		{
			byte[] arg0 = ToLua.CheckByteBuffer(L, 2);
			LuaFramework.AppConst.uuuIdKeyBytes = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_keyIndex(IntPtr L)
	{
		try
		{
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			LuaFramework.AppConst.keyIndex = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_keyLength(IntPtr L)
	{
		try
		{
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			LuaFramework.AppConst.keyLength = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_ticketBytes(IntPtr L)
	{
		try
		{
			byte[] arg0 = ToLua.CheckByteBuffer(L, 2);
			LuaFramework.AppConst.ticketBytes = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_ticketLength(IntPtr L)
	{
		try
		{
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			LuaFramework.AppConst.ticketLength = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_ticketIndex(IntPtr L)
	{
		try
		{
			int arg0 = (int)LuaDLL.luaL_checknumber(L, 2);
			LuaFramework.AppConst.ticketIndex = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_version(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.version = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_appId(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.appId = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int set_appSecret(IntPtr L)
	{
		try
		{
			string arg0 = ToLua.CheckString(L, 2);
			LuaFramework.AppConst.appSecret = arg0;
			return 0;
		}
		catch(Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

