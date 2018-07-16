using UnityEngine;
using System.Collections;
#if UNITY_EDITOR
using UnityEditor;
#endif

public class AnimationUVTexture : MonoBehaviour
{

	//tian jia dao cai dan
	const string menuTitle = "Utility/UV序列动画";
    #if UNITY_EDITOR
	[UnityEditor.MenuItem(menuTitle)]
	static void AddComp()
	{
		GameObject[] objSels = Selection.gameObjects;
		Debug.Log("objSels:" + objSels.Length);
		for (int i = 0; i < objSels.Length; ++i)
		{
			GameObject objSelect = objSels[i];
			AnimationUVTexture info = objSelect.GetComponent<AnimationUVTexture>();
			if (info == null)
			{
				info = objSelect.AddComponent<AnimationUVTexture>();
			}
			Debug.Log("objSelect:" + objSelect.name);
		}
	}
#endif
	//tian jia dao cai dan


    public int tileX = 1;
    public int tileY = 1;
    public bool isForward = true;

    public int countPerSecond = 1;
    float time;

    private int x;
    private int y;

    private float scaleX;
    private float scaleY;

    // Use this for initialization
    void Start()
    {
        time = 0;
        scaleX = 1.0f / tileX;
        scaleY = 1.0f / tileY;
        GetComponent<Renderer>().material.mainTextureScale = new Vector2(scaleX, scaleY);
        if (!isForward)
        {
            x = 1;
            y = 0;
            float testX = (1.0f - x * scaleX);
            float testY = (y * scaleY);
            GetComponent<Renderer>().material.mainTextureOffset = new Vector2(testX, testY);
        }
        else
        {
            x = 0;
            y = 1;
            float testX = (x * scaleX);
            float testY = (1.0f - y * scaleY);
            GetComponent<Renderer>().material.mainTextureOffset = new Vector2(testX, testY);
        }

    }

    // Update is called once per frame
    void Update()
    {

        float timePerFrame = 1.0f / countPerSecond;
        time += Time.deltaTime;

        if (time > timePerFrame)
        {
            time -= timePerFrame;
            if (!isForward)
            {
                float testX = (1.0f - x * scaleX);
                float testY = (y * scaleY);
                GetComponent<Renderer>().material.mainTextureOffset = new Vector2(testX, testY);
                x++;
                if (x > tileX)
                {
                    x = 1;
                    y++;
                    if (y >= tileY)
                        y = 0;
                }
            }
            else
            {
                float testX = (x * scaleX);
                float testY = (1.0f - y * scaleY);
                GetComponent<Renderer>().material.mainTextureOffset = new Vector2(testX, testY);

                x++;
                if (x >= tileX)
                {
                    x = 0;
                    y++;
                    if (y >= tileY)
                        y = 0;
                }
            }
        }
    }

    #if UNITY_EDITOR
	//tian jia dao cai dan
	[UnityEditor.MenuItem(menuTitle, true)]
	static bool ValidateCreate()
	{
		return Selection.activeGameObject != null;
	}
	//tian jia dao cai dan
#endif
}
