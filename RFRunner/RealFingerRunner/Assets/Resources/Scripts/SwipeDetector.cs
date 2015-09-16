using UnityEngine;
using System.Collections;

public class SwipeDetector : MonoBehaviour 
{
	
	public float minSwipeDistY;
	
	public float minSwipeDistX;
	
	public static float auxD = 0;
	
	private Vector2 startPos;
	
	public TextMesh texto;
	
	void Update()
	{
		//#if UNITY_ANDROID
		if (!(Input.touchCount > 0)) {
			if (auxD > 0){
			auxD -= Time.deltaTime;
			}else{
			auxD = 0;
			}
		}
		
		if (Input.touchCount > 0) 
			
		{
			
			Touch touch = Input.touches[0];
			
			
			
			switch (touch.phase) 
				
			{
			case TouchPhase.Began:
				startPos = touch.position;

			break;
		
			case TouchPhase.Ended:
				
				float swipeDistVertical = (new Vector3(0, touch.position.y, 0) - new Vector3(0, startPos.y, 0)).magnitude;
				
				if (swipeDistVertical > minSwipeDistY) 
					
				{
					
					float swipeValue = Mathf.Sign(touch.position.y - startPos.y);
					
					texto.text="CorY?: "+swipeDistVertical;
					
					if (swipeValue > 0){//up swipe
						
						//Jump ();
						//auxD += swipeValue * Time.deltaTime;
						
						}else if (swipeValue < 0){//down swipe
							
						//Shrink ();
						auxD += (swipeDistVertical / 200)*Time.deltaTime;
						}	
				}
				
				
				
				/*float swipeDistHorizontal = (new Vector3(touch.position.x,0, 0) - new Vector3(startPos.x, 0, 0)).magnitude;
				
				if (swipeDistHorizontal > minSwipeDistX) 
				{
					
					float swipeValue = Mathf.Sign(touch.position.x - startPos.x);
					
					if (swipeValue > 0){//right swipe
						
						//MoveRight ();
						
						}else if{ (swipeValue < 0)//left swipe
							
							//MoveLeft ();
						}
				}
				*/
				break;
			
			}
		}
	}
}