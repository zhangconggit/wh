using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class SliderControl : MonoBehaviour {
	
	public Scrollbar m_Scrollbar;

	public ScrollRect m_ScrollRect;

	private float mTargetValue;

	private bool mNeedMove = false;

	private const float MOVE_SPEED = 1F;

	private  const float SMOOTH_TIME = 0f;

	public float mMoveSpeed = 0f;


	public GameObject image1L;
	public GameObject image1M;
	public GameObject image2L;
	public GameObject image2M;
	public GameObject image3L;
	public GameObject image3M;


	public void OnPointerDown()
	{
		mNeedMove = false;
	}

	public void OnPointerUp()
	{
		// 判断当前位于哪个区间，设置自动滑动至的位置
		if (m_Scrollbar.value <= 0.25f)
		{
			mTargetValue = 0;
			image1L.SetActive (true);
			image1M.SetActive (false);
			image2L.SetActive (false);
			image2M.SetActive (true);
			image3L.SetActive (false);
			image3M.SetActive (true);
		}
		else if (m_Scrollbar.value <= 0.8f )
		{
			mTargetValue = 0.5f;          //0.16
			image1L.SetActive (false);
			image1M.SetActive (true);
			image2L.SetActive (true);
			image2M.SetActive (false);
			image3L.SetActive (false);
			image3M.SetActive (true);
		}
		else
		{
			mTargetValue = 1f;
			image1L.SetActive (false);
			image1M.SetActive (true);
			image2L.SetActive (false);
			image2M.SetActive (true);
			image3L.SetActive (true);
			image3M.SetActive (false);
		}

		mNeedMove = true;
		mMoveSpeed = 0;
	}
		

	void Update()
	{
		if (mNeedMove)
		{
				m_Scrollbar.value = mTargetValue;
				mNeedMove = false;
				return;
			m_Scrollbar.value = Mathf.SmoothDamp(m_Scrollbar.value, mTargetValue, ref mMoveSpeed, SMOOTH_TIME);
		}
	}
}


