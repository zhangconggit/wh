using UnityEngine;
using System.Collections;
#if UNITY_EDITOR
using UnityEditor;
#endif

public class ObjectRotate : MonoBehaviour {



	public bool RotateX;
	public float speedX;
	public bool RotateY;
	public float speedY;
	public bool RotateZ;
	public float speedZ;

    #if UNITY_EDITOR
	//tian jia dao cai dan
	const string menuTitle = "Utility/物体旋转";
	[UnityEditor.MenuItem(menuTitle)]
	static void AddComp()
	{
		GameObject[] objSels = Selection.gameObjects;
		Debug.Log("objSels:" + objSels.Length);
		for (int i = 0; i < objSels.Length; ++i)
		{
			GameObject objSelect = objSels[i];
			ObjectRotate info = objSelect.GetComponent<ObjectRotate>();
			if (info == null)
			{
				info = objSelect.AddComponent<ObjectRotate>();
			}
			Debug.Log("objSelect:" + objSelect.name);
		}
	}
#endif



	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		if (RotateX) 
		{
			transform.Rotate(Vector3.left,Time.deltaTime*speedX);
		}

		if (RotateY) 
		{
			transform.Rotate(Vector3.up,Time.deltaTime*speedY);
		}

		if (RotateZ) 
		{
			transform.Rotate(Vector3.forward,Time.deltaTime*speedZ);
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
