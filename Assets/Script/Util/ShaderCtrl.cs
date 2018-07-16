using UnityEngine;
using System.Collections;
#if UNITY_EDITOR
using UnityEditor;
#endif

public class ShaderCtrl : MonoBehaviour {
    #if UNITY_EDITOR
	//tian jia dao cai dan
	const string menuTitle = "Utility/ShaderCtrl";
	[UnityEditor.MenuItem(menuTitle)]
	static void AddComp()
	{
		GameObject[] objSels = Selection.gameObjects;
		Debug.Log("objSels:" + objSels.Length);
		for (int i = 0; i < objSels.Length; ++i)
		{
			GameObject objSelect = objSels[i];
			ShaderCtrl info = objSelect.GetComponent<ShaderCtrl>();
			if (info == null)
			{
				info = objSelect.AddComponent<ShaderCtrl>();
			}
			Debug.Log("objSelect:" + objSelect.name);
		}
	}
#endif


    public bool m_bEnable = true;
    public Color colorSource = new Color(0, 0, 0, 0);
    public Color colorDest = new Color(1, 1, 1, 1);

    public float m_fTimeLoop = 1.0f;
    float m_fTimeElapse = 0f;

    bool m_bToward = true;

    Material m_matCurrent;
    Color m_colorCurrent = new Color(0, 0, 0, 0);

    const string TINT_COLOR = "_TintColor";
	// Use this for initialization
    void Start()
    {
        Renderer render = GetComponent<Renderer>();
        m_matCurrent = render.material;

        //if (m_matCurrent.HasProperty(TINT_COLOR))
        //{

        //    Color colorCur = m_matCurrent.GetColor(TINT_COLOR);
        //    Debug.Log("TintColor:" + colorCur);            
        //}

        m_fTimeElapse = 0f;
    }
	
	// Update is called once per frame
    void Update()
    {
        if (m_bEnable)
        {
            m_fTimeElapse += Time.deltaTime;
            if (m_fTimeElapse >= m_fTimeLoop)
            {
                m_bToward = !m_bToward;
                m_fTimeElapse = 0f;
            }
            float fAlpha = m_fTimeElapse/m_fTimeLoop;
            if (m_bToward)
            {

                m_colorCurrent = Color.Lerp(colorSource, colorDest, fAlpha);
            }
            else
            {
                m_colorCurrent = Color.Lerp(colorDest, colorSource, fAlpha);
            }
            if (m_matCurrent.HasProperty(TINT_COLOR))
            {
                m_matCurrent.SetColor(TINT_COLOR, m_colorCurrent);
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
#endif

}
