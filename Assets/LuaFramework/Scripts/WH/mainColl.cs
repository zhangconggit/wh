using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class mainColl : MonoBehaviour {

    public Image WH_HuodongImg;
    public Image WH_WanFaImg;
    public Image WH_GameListShow;
    public Image WH_TongZhiShow;
    public Image WH_JoinRoomImg;
    public Image WH_openShuoShow;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}


    /// <summary>
    /// 活动页面
    /// </summary>
    public void WH_HuoDongLayer() {

        WH_HuodongImg.gameObject.SetActive(true);
        GameObject.Find("WH_HuoDongImg").GetComponent<Animator>().SetBool("open", true);
    }

    /// <summary>
    /// 关闭活动页面
    /// </summary>
    public void WH_CloseHuoDongLayer()

    {
        WH_HuodongImg.gameObject.SetActive(false);
    }

    /// <summary>
    /// 玩法页面
    /// </summary>
    public void WH_WanFaLayer()
    {
        WH_WanFaImg.gameObject.SetActive(true);
        GameObject.Find("WH_WanFaImg").GetComponent<Animator>().SetBool("open", true);
    }
    

    /// <summary>
    /// 关闭玩法页面
    /// </summary>
    public void WH_CloseWanFaLayer()
    {
        WH_WanFaImg.gameObject.SetActive(false);
    }


    /// <summary>
    /// 游戏显示页面
    /// </summary>
    public void WH_GameShow()
    {
        WH_GameListShow.gameObject.SetActive(true);
        GameObject.Find("WH_GameShowPanel").GetComponent<Animator>().SetBool("open", true);
    }

    /// <summary>
    /// 关闭游戏显示页面 
    /// </summary>
    public void WH_CloseGameShow()
    {
        WH_GameListShow.gameObject.SetActive(false);
    }

    /// <summary>
    /// 喇叭的通知菜单
    /// </summary>
    public void WH_TongZhi()
    {
        WH_TongZhiShow.gameObject.SetActive(true);
        GameObject.Find("WH_Message").GetComponent<Animator>().SetBool("open",true);
    }

    /// <summary>
    /// 关闭喇叭的通知菜单
    /// </summary>
    public void WH_CloseTongZhi()
    {
        WH_TongZhiShow.gameObject.SetActive(false);
    }

    /// <summary>
    /// 加入房间
    /// </summary>
    public void WH_JoinRoom()
    {
        WH_JoinRoomImg.gameObject.SetActive(true);
        GameObject.Find("JoinRoomPanel").GetComponent<Animator>().SetBool("open", true);
    }

    /// <summary>
    /// 关闭房间
    /// </summary>
    public void WH_ColseJoinRoom()
    {
        WH_JoinRoomImg.gameObject.SetActive(false);
    }


    /// <summary>
    /// 打开商城
    /// </summary>
    public void WH_OpenShop()
    { 
        WH_openShuoShow.gameObject.SetActive(true);
        GameObject.Find("WH_Shop").GetComponent<Animator>().SetBool("open", true);
    }

    /// <summary>
    /// 关闭商城
    /// </summary>
    public void WH_CloseShop()
    { 
        WH_openShuoShow.gameObject.SetActive(false);
    }

}
