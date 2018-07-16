using UnityEngine;
using System.Collections;

public class SelectMouseEnter : MonoBehaviour {

	public string overCall = "";
	public string exitCall = "";
	void OnMouseOver (){
		//LuaFramework.Util.CallMethod("CH_GameMainCtrl", "MouseOver", this.gameObject);
		string[] args = overCall.Split ('/');
		LuaFramework.Util.CallMethod(args[0], args[1], this.gameObject);
	}

	void OnMouseExit (){
		//LuaFramework.Util.CallMethod("CH_GameMainCtrl", "MouseExit",this.gameObject);
		string[] args = exitCall.Split ('/');
		LuaFramework.Util.CallMethod(args[0], args[1], this.gameObject);
	}
}
