using System.Collections.Generic;
using UnityEngine;

public class FixShader : MonoBehaviour
{
    public List<Material> thisMaterial;
    public List<Shader> shaders;

    void Start()
    {

        //MeshRenderer[] meshRenderer = GetComponentsInChildren<MeshRenderer>();
        //int length = meshRenderer.Length;

        //for (int i = 0; i < length; i++)
        //{
        //    int count = meshRenderer[i].materials.Length;
        //    for (int j = 0; j < count; j++)
        //    {
        //        Material _mater = meshRenderer[i].materials[j];
        //        thisMaterial.Add(_mater);
        //        shaders.Add(_mater.shader.name);
        //       
        //    }
        //}

        //SkinnedMeshRenderer[] meshSkinRenderer = GetComponentsInChildren<SkinnedMeshRenderer>();
        //length = meshSkinRenderer.Length;

        //for (int i = 0; i < length; i++)
        //{
        //    int count = meshSkinRenderer[i].materials.Length;
        //    for (int j = 0; j < count; j++)
        //    {
        //        Material _mater = meshSkinRenderer[i].materials[j];
        //        thisMaterial.Add(_mater);
        //        shaders.Add(_mater.shader.name);
        //    }
        //}


        for (int i = 0; i < thisMaterial.Count; i++)
        {
            thisMaterial[i].shader = Shader.Find(shaders[i].name);
        }
    }
}