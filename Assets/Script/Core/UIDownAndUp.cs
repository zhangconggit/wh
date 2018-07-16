using UnityEngine;
using System.Collections;
using UnityEngine.EventSystems;
using System;
using LuaFramework;

public class UIDownAndUp : MonoBehaviour, IPointerDownHandler, IPointerUpHandler
{
    public void OnPointerDown(PointerEventData eventData)
    {
        LuaFramework.Util.CallMethod("TalkCtrl", "OpenYuYinTishiWin");
        weChatFunction.yuYinBtnDown();
    }

    public void OnPointerUp(PointerEventData eventData)
    {
        LuaFramework.Util.CallMethod("TalkCtrl", "CloseYuYinTishiWin");
        weChatFunction.yuYinBtnUp();
    }
}
