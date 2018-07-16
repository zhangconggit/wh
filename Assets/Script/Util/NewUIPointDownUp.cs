using UnityEngine;
using System.Collections;
using System;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using LuaFramework;

public class NewUIPointDownUp : MonoBehaviour, IPointerDownHandler, IPointerUpHandler
{
    private bool invokeOnce = false;//是否只调用一次  
    private bool hadInvoke = false;//是否已经调用过  

	public float interval = 0.1f;//按下后超过这个时间则认定为"长按"  
    private bool isPointerDown = false;
    private float recordTime;

    private float rateTime = 0;
    private float downTime = 0.1f;
    public UnityEvent onPress = new UnityEvent();//按住时调用  
    public UnityEvent onRelease = new UnityEvent();//松开时调用  
	public string downCall = "";
	public string upCall = "";

    void Update()
    {
        if (isPointerDown)
        {
            if ((Time.time - recordTime) > interval)
            {
                rateTime = Time.deltaTime + rateTime;
                if (rateTime > downTime)
                {
                    onPress.Invoke();
                    hadInvoke = true;
                    rateTime = 0;
                }
            }
        }
    }

    public void OnPointerDown(PointerEventData eventData)
    {
        isPointerDown = true;
        recordTime = Time.time;
		if (downCall != "") 
		{
			string[] args = downCall.Split ('/');
			Util.CallMethod(args[0], args[1], gameObject);
		}

    }

    public void OnPointerUp(PointerEventData eventData)
    {
        isPointerDown = false;
        hadInvoke = false;
        onRelease.Invoke();
		if (upCall != "") 
		{
			string[] args = upCall.Split ('/');
			Util.CallMethod (args [0], args [1], gameObject);
		}
    }

    //public void OnPointerExit(PointerEventData eventData)
    //{
    //    isPointerDown = false;
    //    hadInvoke = false;
    //    onRelease.Invoke();
    //}
}