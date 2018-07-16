using UnityEngine;
using System.Collections;
using UnityEngine.EventSystems;
using System;
using LuaFramework;

public class UIDrag : MonoBehaviour,IBeginDragHandler, IDragHandler, IEndDragHandler
{
    Vector3 go;
    private static UIDrag selected;

    // during dragging
    public void OnDrag(PointerEventData eventData)
    {
        if(selected != this)
            return;
        SetDraggedPosition(eventData);
    }

    // end dragging
    public void OnEndDrag(PointerEventData eventData)
    {
        if(selected != this)
            return;
        var rt = gameObject.GetComponent<RectTransform>();
        selected = null;
        bool isPlay = false;
        if(gameObject.transform.position.y > -2.1f)
        {
            isPlay = true;
        }
        else
        {
            rt.localPosition = go;
        }

        bool r = (bool)Util.CallMethod("RoomRunStatic", "OnDragCard", gameObject, isPlay)[0];
        if(!r)
        {
            rt.localPosition = go;
        }
    }

  
    public void OnBeginDrag(PointerEventData eventData)
    {
        if(selected != null)
            return;
        selected = this;
        var rt = gameObject.GetComponent<RectTransform>();
        go = rt.localPosition;

        Util.CallMethod("RoomRunStatic", "OnDragStart");
        //C#调取Lua内脚本函数--选牌变色
        //LuaFramework.Util.CallMethod("MainSenceCtrl", "Awake");
    }
    /// <summary>
    /// set position of the dragged game object
    /// </summary>
    /// <param name="eventData"></param>
    private void SetDraggedPosition(PointerEventData eventData)
    {
        var rt = gameObject.GetComponent<RectTransform>();
        // transform the screen point to world point int rectangle
        Vector3 globalMousePos;
        if (RectTransformUtility.ScreenPointToWorldPointInRectangle(rt, eventData.position, eventData.pressEventCamera, out globalMousePos))
        {
            globalMousePos.x = globalMousePos.x;
            globalMousePos.y = globalMousePos.y;
            rt.position = globalMousePos;
        }
    }
}
