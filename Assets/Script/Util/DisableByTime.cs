using UnityEngine;
using System.Collections;
#if UNITY_EDITOR
using UnityEditor;
#endif

public class DisableByTime : MonoBehaviour {

	public float lifeTime;
	float startTime;

    #if UNITY_EDITOR
	//tian jia dao cai dan
	const string menuTitle = "Utility/DisableByTime";
	[UnityEditor.MenuItem(menuTitle)]
	static void AddComp()
	{
		GameObject[] objSels = Selection.gameObjects;
		Debug.Log("objSels:" + objSels.Length);
		for (int i = 0; i < objSels.Length; ++i)
		{
			GameObject objSelect = objSels[i];
			DisableByTime info = objSelect.GetComponent<DisableByTime>();
			if (info == null)
			{
				info = objSelect.AddComponent<DisableByTime>();
			}
			Debug.Log("objSelect:" + objSelect.name);
		}
	}
#endif


	// Use this for initialization
	void Start () {
		startTime = Time.time;

	}

	public void Reset()
	{
		gameObject.SetActive (true);
		//GetComponent<Animation> ().Play (GetComponent<Animation> ().clip.name);
		Start ();
	}
	
	// Update is called once per frame
	void Update () {
		if (Time.time - startTime > lifeTime) {
			gameObject.SetActive(false);
			//Destroy(gameObject);
		}
	}

	
	#if UNITY_EDITOR
	//tian jia dao cai dan
	[UnityEditor.MenuItem(menuTitle, true)]
	static bool ValidateCreate()
	{
		return Selection.activeGameObject != null;
	}
#endif

}
