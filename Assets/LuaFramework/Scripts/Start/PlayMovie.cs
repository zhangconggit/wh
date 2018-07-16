using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;

public class PlayMovie : MonoBehaviour
{
    void Awake()
    {
        //播放视频
        Handheld.PlayFullScreenMovie("LoginMain.mp4", Color.black, FullScreenMovieControlMode.Hidden);
        print("Movie");
        SceneManager.LoadScene("update");
    }
}
