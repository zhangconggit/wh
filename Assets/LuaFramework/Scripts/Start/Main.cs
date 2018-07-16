using System.IO;
using UnityEngine;

namespace LuaFramework
{
    public class Main : MonoBehaviour
    {
        void Start()
        {
            GameStarting();
            Application.runInBackground = true;//后台模式默认运行程序
        }

        void GameStarting()
        {
            GameObject go = GameObject.Find("GameManager");
            if (go == null)
            {
                gameObject.name = "GameManager";
                AppFacade.Instance.StartUp();   //启动游戏
            }
            else
            {
                go.GetComponent<GameManager>().Init(true);
                Destroy(gameObject);
            }
        }
        void OnApplicationFocus(bool state)
        {
            Debug.Log("========OnApplicationFocus " + state);
            if (state)
            {
                Util.CallMethod("Game", "OnApplicationFocus", state);
            }
        }
    }
}