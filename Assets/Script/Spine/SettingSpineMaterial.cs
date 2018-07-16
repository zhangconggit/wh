using System;
using UnityEngine;
using System.Collections;
using Spine.Unity;

public class SettingSpineMaterial : MonoBehaviour
{
    private SkeletonGraphic graphic;
    private string matName = String.Empty;
    private Material spineMat;
    void Awake()
    {
        graphic = GetComponent<SkeletonGraphic>();
        graphic.raycastTarget = false;
        switch (transform.name)
        {
            case "JoinRoom":
                matName = "ZhuangSp_Material";
                break;
            case "ZhuangSp":
                matName = "ZhuangSp_Material";
                break;
            case "HuDie":
                matName = "HuDie_0_Material";
                break;
            case "Fmsp":
                matName = "Fmsp_Material";
                break;
            case "LogoSp":
                matName = "LogoSp_Material";
                break;
            default:
                matName = "SkeletonGraphicUI";
                break;
        }
        spineMat = Resources.Load<Material>("Spine/" + matName);
    }

    void Update()
    {
        if (graphic.material != spineMat)
        {
            graphic.material = spineMat;
        }
    }
}
