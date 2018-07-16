using UnityEngine;
using System.Collections;
using UnityEngine.EventSystems;
using System;
using LuaFramework;
public class SelectUIObject :MonoBehaviour, IPointerDownHandler, IPointerUpHandler
{
	//暴露接口，方便调用
	public string downCall = "";
	public string upCall = "";

	public void OnPointerDown(PointerEventData eventData)
	{
		//LuaFramework.Util.CallMethod("CH_GameMainCtrl", "MouseDown");
		string[] args = downCall.Split ('/');
		LuaFramework.Util.CallMethod(args[0], args[1], this.gameObject);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		//LuaFramework.Util.CallMethod("CH_GameMainCtrl", "MouseUp");
		string[] args = upCall.Split ('/');
		LuaFramework.Util.CallMethod(args[0], args[1], this.gameObject);
	}
}
