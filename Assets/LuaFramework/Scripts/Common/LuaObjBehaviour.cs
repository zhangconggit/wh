using UnityEngine;
using LuaInterface;
using System.Collections;
using System.Collections.Generic;
using System;
using UnityEngine.UI;

namespace LuaFramework {

    public class LuaObjBehaviour : Base
    {
        protected void Awake() {
            Util.CallMethod(name, "Awake", gameObject);
            MeshRenderer[] renders = gameObject.GetComponentsInChildren<MeshRenderer>();
            for(int i = 0; i < renders.Length; i++)
            {
                MeshRenderer render = renders[i];
                // render.material.shader = Shader.Find("Mobile/Unlit (Supports Lightmap)");
                string parentName = render.gameObject.transform.parent.name;
                if (render.gameObject.name == "imgDXNBBG" || parentName == "imgDXNBBG" || parentName == "Sanren")
                {
                    render.material.shader = Shader.Find("Sprites/Diffuse");
                }
                else
                {
                    render.material.shader = Shader.Find("Mobile/Diffuse");
                }
            }
            SkinnedMeshRenderer[] skinrenders = gameObject.GetComponentsInChildren<SkinnedMeshRenderer>();
            for(int i = 0; i < skinrenders.Length; i++)
            {
                SkinnedMeshRenderer render = skinrenders[i];
                // render.material.shader = Shader.Find("Mobile/Unlit (Supports Lightmap)");
                string parentName = render.gameObject.transform.parent.name;
                if (render.gameObject.name == "imgDXNBBG" || parentName == "imgDXNBBG" || parentName == "Sanren")
                {
                    render.material.shader = Shader.Find("Sprites/Diffuse");
                }
                else
                {
                    render.material.shader = Shader.Find("Mobile/Diffuse");
                }

                //render.material.shader = Shader.Find("Mobile/Particles/Alpha Blended");
            }
        }

        protected void Start() {
            Util.CallMethod(name, "Start");
        }

        
        protected void Update() {
            
           // Util.CallMethod(name, "Update");
        }
 
        //-----------------------------------------------------------------
        protected void OnDestroy() {
            // Util.ClearMemory();
            Debug.Log("~" + name + " was destroy!");
        }
    }
}