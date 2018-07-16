using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class DownLoadingShow : MonoBehaviour
{
    private Image _imgSliver;
    private Text _txtStatus;
    private GameObject _imgLodingBG;
    private Image _btnTouristLogin;

    public float Progress = 0f;
    private static DownLoadingShow instance;
    public static DownLoadingShow Instance
    {
        get
        {
            if (instance == null)
            {
                instance = new DownLoadingShow();
            }
            return instance;
        }
    }
    private void Start()
    {
        _imgSliver = GameObject.Find("scrbSliver").GetComponent<Image>();
        _txtStatus = GameObject.Find("txtLodingNum").GetComponent<Text>();

        _imgLodingBG = GameObject.Find("imgLodingBG").gameObject;
        _btnTouristLogin = GameObject.Find("btnTouristLogin").GetComponent<Image>();
        _btnTouristLogin.enabled = false;
    }


    private void Update()
    {
        _imgSliver.fillAmount = Progress;
        Debug.Log(_imgSliver.fillAmount);
        _txtStatus.text = _imgSliver.fillAmount * 100f+"%";
        Debug.Log(_txtStatus.text);
        if (_imgSliver .fillAmount> 0.98)
        {
            _imgLodingBG.SetActive(false);
            _btnTouristLogin.enabled = true;
        }
    }
}
