using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class dropdownMenu : MonoBehaviour {

    public Image systemNotice;
    public Image cllUser;


	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}


    /// <summary>
    /// 登录页面下拉框
    /// </summary>
    public void WH_dropdownClick()
    {
        systemNotice.gameObject.SetActive(true);
    }

    /// <summary>
    /// 关闭下拉框
    /// </summary>
    public void WH_closeSystemNotice()
    {
        systemNotice.gameObject.SetActive(false);
    }

    /// <summary>
    /// 客服按钮
    /// </summary>
    public void WH_call()
    {
        cllUser.gameObject.SetActive(true);
    }

    /// <summary>
    /// 关闭客服按钮
    /// </summary>
    public void WH_closeCall()
    {
        cllUser.gameObject.SetActive(false);
    }

}
