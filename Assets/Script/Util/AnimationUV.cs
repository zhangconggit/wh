using UnityEngine;
using System.Collections;
#if UNITY_EDITOR
using UnityEditor;
#endif


[RequireComponent(typeof(Renderer))]
public class AnimationUV : MonoBehaviour {
	//tian jia dao cai dan
	const string menuTitle = "Utility/UV位移";
#if UNITY_EDITOR
    [UnityEditor.MenuItem(menuTitle)]

	static void AddComp()
	{
		GameObject[] objSels = Selection.gameObjects;
		Debug.Log("objSels:" + objSels.Length);
		for (int i = 0; i < objSels.Length; ++i)
		{
			GameObject objSelect = objSels[i];
			AnimationUV info = objSelect.GetComponent<AnimationUV>();
			if (info == null)
			{
				info = objSelect.AddComponent<AnimationUV>();
			}
			Debug.Log("objSelect:" + objSelect.name);
		}
	}
    #endif

	// Use this for initialization
    float offx = 0;
    float offy = 0;
    public bool moveX = false;
    public float speedX = 0.1f;

    public bool moveY = false;
    public float speedY = 0.1f;
	void Start () {
		offx = GetComponent<Renderer> ().material.mainTextureOffset.x;
		offy = GetComponent<Renderer> ().material.mainTextureOffset.y;
	}
	
	// Update is called once per frame
	void Update () {
        if (moveX)
            offx += speedX * Time.deltaTime;
        if (moveY)
            offy += speedY * Time.deltaTime;

        GetComponent<Renderer>().material.mainTextureOffset = new Vector2(offx, offy);
	
	}

#if UNITY_EDITOR
    //tian jia dao cai dan
	[UnityEditor.MenuItem(menuTitle, true)]
	static bool ValidateCreate()
	{
		return Selection.activeGameObject != null;
    }
#endif
    //tian jia dao cai dan
}
