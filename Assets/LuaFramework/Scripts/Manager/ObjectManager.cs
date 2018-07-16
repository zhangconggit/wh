using UnityEngine;
using System.Collections;
using LuaInterface;
using LuaFramework;

public class ObjectManager :Manager {

    private Transform parent;

    Transform Parent
    {
        get
        {
            if (parent == null)
            {
                GameObject go = GameObject.FindWithTag("GameObjContainer");
                if (go != null) parent = go.transform;
            }
            return parent;
        }
    }



    public void CreateCard(string name,int index, LuaFunction func = null) {

        

        string assetName = name + "Obj";
        string abName = name.ToLower() + AppConst.ExtName;
        if (Parent.FindChild(name) != null) return;


#if ASYNC_MODE
        ResManager.LoadPrefab(abName, assetName, delegate(UnityEngine.Object[] objs)
        {
            if (objs.Length == 0) return;
            GameObject prefab = objs[0] as GameObject;
            if (prefab == null) return;


            GameObject go = Instantiate(prefab) as GameObject;
            go.name = assetName;
            go.layer = LayerMask.NameToLayer("Default");
            go.transform.SetParent(Parent);
            go.transform.localScale = Vector3.one;
            go.transform.localPosition = Vector3.zero;
            // go.AddComponent<LuaObjBehaviour>();

            if (func != null) func.Call(go,index);
            // Debug.LogWarning("CreateObj::>> " + name + " " + prefab);
        });
#else
             GameObject prefab = ResManager.LoadAsset<GameObject>(name, assetName);
            if (prefab == null) return;

            GameObject go = Instantiate(prefab) as GameObject;
            go.name = assetName;
            go.layer = LayerMask.NameToLayer("Default");
            go.transform.SetParent(Parent);
            go.transform.localScale = Vector3.one;
            go.transform.localPosition = Vector3.zero;
            // go.AddComponent<LuaObjBehaviour>();

            if (func != null) func.Call(go,index);
            // Debug.LogWarning("CreateObj::>> " + name + " " + prefab);
#endif

    }

 

    public void CreateObj(string name, LuaFunction func = null) {

        string assetName = name + "Obj"; 
        string abName    = name.ToLower() + AppConst.ExtName;
        if (Parent.FindChild(name) != null) return;


#if ASYNC_MODE
        ResManager.LoadPrefab(abName, assetName, delegate(UnityEngine.Object[] objs)
        {
            if (objs.Length == 0) return;
            GameObject prefab = objs[0] as GameObject;
            if (prefab == null) return;


            GameObject go = Instantiate(prefab) as GameObject;
            go.name = assetName;
            go.layer = LayerMask.NameToLayer("Default");
            go.transform.SetParent(Parent);
            go.transform.localScale = Vector3.one;
            go.transform.localPosition = Vector3.zero;
            // go.AddComponent<LuaObjBehaviour>();

            if (func != null) func.Call(go);
            // Debug.LogWarning("CreateObj::>> " + name + " " + prefab);
        });
#else
             GameObject prefab = ResManager.LoadAsset<GameObject>(name, assetName);
            if (prefab == null) return;

            GameObject go = Instantiate(prefab) as GameObject;
            go.name = assetName;
            go.layer = LayerMask.NameToLayer("Default");
            go.transform.SetParent(Parent);
            go.transform.localScale = Vector3.one;
            go.transform.localPosition = Vector3.zero;
            // go.AddComponent<LuaObjBehaviour>();

            if (func != null) func.Call(go);
            // Debug.LogWarning("CreateObj::>> " + name + " " + prefab);
#endif

    }

    public void RemoveObj(string name) {
       GameObject gameObj =  GameObject.Find(name);
       Destroy(gameObj);
    }


	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}


}
