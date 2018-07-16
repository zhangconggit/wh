using UnityEngine;
using LuaInterface;
using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine.UI;
using UnityEngine.EventSystems;

namespace LuaFramework
{
    public class LuaBehaviour : View
    {
        private string data = null;
        private LuaTable table;
        private Dictionary<string, LuaFunction> buttons = new Dictionary<string, LuaFunction>();

        protected void Awake()
        {
            table = Util.GetTable(name);
            if (table != null)
                table.Invoke("Awake", table, gameObject);
        }

        protected void Start()
        {
            if (table != null)
                table.Invoke("Start", table);
        }

        protected void OnClick()
        {
            if (table != null)
                table.Invoke("OnClick", table);
        }

        protected void OnClickEvent(GameObject go)
        {
            if (table != null)
                table.Invoke("OnClick", table, go);
        }

        protected void OnDrag()
        {
            Util.CallMethod(name, "OnDrag");
        }

        protected void OnDragEvent(GameObject go)
        {
            Util.CallMethod(name, "OnDrag", go);
        }

        public void SetText(GameObject go, string str)
        {
            if (go == null) return;
            Text txt = go.GetComponent<Text>();
            txt.supportRichText = true;
            txt.text = str;
        }

        public string GetInputText(GameObject go)
        {
            if (go == null) return "";
            InputField txt = go.GetComponent<InputField>();
            return txt.text;
            Debug.Log("------------------------" + txt.text);
        }

        public void SetInputText(GameObject go, string text)
        {
            if (go == null)
                return;
            InputField txt = go.GetComponent<InputField>();
            txt.text = text;
            Debug.Log("------------------------" + txt.text);
        }

        /// 添加inputField的endEdit事件
        public void AddOnEndEdit(GameObject go, LuaFunction luafunc)
        {
            if (go == null || luafunc == null) return;
            go.GetComponent<InputField>().onEndEdit.AddListener(
                delegate (string b)
                {
                    luafunc.Call(go, b);
                }
            );
        }

        public void SetTextMesh(GameObject go, string str)
        {
            if (go == null) return;
            TextMesh txt = go.GetComponent<TextMesh>();
            txt.text = str;
        }

        public string GetText(GameObject go)
        {
            if (go == null) return "";
            Text txt = go.GetComponent<Text>();
            return txt.text;
        }

        public void SetProgress(GameObject go, float per)
        {
            if (go == null) return;
            go.GetComponent<Image>().fillAmount = per;
        }

        /// <summary>
        /// 添加单击事件
        /// </summary>
        public void AddClick(GameObject go, LuaFunction luafunc)
        {
            if (go == null || luafunc == null) return;
            buttons.Add(go.name, luafunc);
            go.AddComponent<ButtonScaleTweer>().showPressed = true;
            go.GetComponent<Button>().transition = Selectable.Transition.None;
            go.GetComponent<Button>().onClick.AddListener(
                delegate ()
                {
                    luafunc.Call(go);
                }
            );
        }

        public void AddClickNoChange(GameObject go, LuaFunction luafunc)
        {
            if (go == null || luafunc == null) return;
            buttons.Add(go.name, luafunc);
            go.GetComponent<Button>().onClick.AddListener(
                delegate ()
                {
                    luafunc.Call(go);
                }
            );
        }
        /// <summary>
        /// 添加ScrollBar事件
        /// </summary>
        /// <param name="go"></param>
        /// <param name="luafunc"></param>
        public void AddOnScrollValueChange(GameObject go,LuaFunction luafunc)
        {
            if (go == null||luafunc==null) return;
            buttons.Add(go.name, luafunc);
            go.GetComponent<Scrollbar>().onValueChanged.AddListener(delegate(float value)
            {
                luafunc.Call(go, value);
            });
        }

        /// <summary>
        /// 添加Toggle事件
        /// </summary>
        public void AddOnValueChanged(GameObject go, LuaFunction luafunc)
        {
            if (go == null || luafunc == null) return;
            buttons.Add(go.name, luafunc);
            go.GetComponent<Toggle>().onValueChanged.AddListener(
                delegate (bool b)
                {
                    luafunc.Call(go, b);
                }
            );
        }

        /// <summary>
        /// 删除单击事件
        /// </summary>
        /// <param name="go"></param>
        public void RemoveClick(GameObject go)
        {
            if (go == null) return;
            LuaFunction luafunc = null;
            if (buttons.TryGetValue(go.name, out luafunc))
            {
                luafunc.Dispose();
                luafunc = null;
                buttons.Remove(go.name);
            }
        }

        /// <summary>
        /// 清除单击事件
        /// </summary>
        public void ClearClick()
        {
            foreach (var de in buttons)
            {
                if (de.Value != null)
                {
                    de.Value.Dispose();
                }
            }
            buttons.Clear();
        }

        //-----------------------------------------------------------------
        protected void OnDestroy()
        {
            ClearClick();
#if ASYNC_MODE
            // if(name != "Canvas")
            // {
            //     string abName = name.ToLower().Replace("panel", "");
            //     ResManager.UnloadAssetBundle(abName + AppConst.ExtName);
            // }
#endif
            // Util.ClearMemory();
            table = null;
            Debugger.Log("~" + name + " was destroy!");
        }
    }
}