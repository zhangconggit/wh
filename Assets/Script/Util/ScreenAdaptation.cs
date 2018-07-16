using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class ScreenAdaptation : MonoBehaviour
{
    private float standard_height = 720f;
    private float standard_width = 1280f;
    private float device_height = 0f;
    private float device_width = 0f;
    private float cur_height = 0f;
    private float cur_width = 0f;
    Camera objCamera;
    void Start()
    {
        //float standard_width = 1280f;        
        //float device_width = 0f;                
        device_height = Screen.height;
        device_width = Screen.width;
        objCamera = transform.GetComponent<Camera>();
        cur_height = Screen.height;
        cur_width = Screen.width;

        float b = 30;
        float a = (cur_width / cur_height) * 10;
        float c = (int)a;
        if (c < 14 && c >= 13)
        {
            b = 40;
        }
        else if (c < 15 && c >= 14)
        {
            b = 35;
        }
        else if (c < 17 && c >= 15)
        {
            b = 33;
        }
        else if (c >= 17)
        {
            b = 30;
        }
        else
        {
            b = 30;
        }

        objCamera.fieldOfView = b;
    }
}
