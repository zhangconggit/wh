using UnityEngine;
using System;
using LuaInterface;
using LuaFramework;

public class LuaObject : MonoBehaviour{
	public LuaTable lua;
	public string luaClass = "";
	public string param = "";

	void Start()
	{
		if(luaClass != "")
		{
			lua = Util.GetTable(luaClass);
			if(lua.GetLuaFunction("New") != null)
				lua = lua.Invoke("New", lua, gameObject)[0] as LuaTable;
		}
		lua["param"] = param;
		lua.Invoke("Start", lua);
	}

	void Update()
	{
		if(lua != null)
			lua.Invoke("Update", lua);
	}

	public void Destroy()
	{
		lua = null;
		Destroy(gameObject);
	}
}