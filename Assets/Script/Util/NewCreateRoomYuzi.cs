using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using LuaFramework;

public class NewCreateRoomYuzi : MonoBehaviour
{

    private Button btnDown;
    private Button btnUp;
    private Text inputText;
    private int btnNum = 2;
    private int incre = 1;
    void Start()
    {
        btnDown = transform.Find("btnDown").GetComponent<Button>();
        btnUp = transform.Find("btnUp").GetComponent<Button>();
        inputText = transform.Find("togXiayuNum/txtXiayuNum").GetComponent<Text>();
        btnDown.GetComponent<NewUIPointDownUp>().onPress.AddListener(SupNum);
        btnDown.GetComponent<NewUIPointDownUp>().onRelease.AddListener(OnBtnUpClick);
        btnDown.onClick.AddListener(SupNum);

        btnUp.onClick.AddListener(AddNum);
        btnUp.GetComponent<NewUIPointDownUp>().onPress.AddListener(AddNum);
        btnUp.GetComponent<NewUIPointDownUp>().onRelease.AddListener(OnBtnUpClick);
        if (AppConst.getPlayerPrefs("btnyuziNum") != "")
        {
            btnNum = int.Parse(AppConst.getPlayerPrefs("btnyuziNum"));
            //Util.CallMethod("CreateRoomCtrl", "ChangeBtnNum", btnNum);
        }
        else
        {
            btnNum = 2;
        }
    }

    public void AddNum()
    {
        btnNum = btnNum + incre;
        incre++;
        if (incre >= 4)
        {
            incre = 4;
        }
        if (btnNum >= 50)
        {
            btnNum = 50;
        }
        inputText.text = "<color=#9a0a0a>" + btnNum + "鱼</color>";
        Util.CallMethod("CreateRoomCtrl", "ChangeBtnNum", btnNum);
        AppConst.setPlayerPrefs("btnyuziNum", btnNum.ToString());
    }

    public void SupNum()
    {
        btnNum = btnNum - incre;
        incre++;
        if (incre >= 4)
        {
            incre = 4;
        }
        if (btnNum <= 2)
        {
            btnNum = 2;
        }
        inputText.text = "<color=#9a0a0a>" + btnNum + "鱼</color>";
        Util.CallMethod("CreateRoomCtrl", "ChangeBtnNum", btnNum);
        AppConst.setPlayerPrefs("btnyuziNum", btnNum.ToString());
    }

    public void OnBtnUpClick()
    {
        incre = 1;
        Util.CallMethod("CreateRoomCtrl", "ChangeBtnNum", btnNum);
        AppConst.setPlayerPrefs("btnyuziNum", btnNum.ToString());
    }
}