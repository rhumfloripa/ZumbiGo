using UnityEngine;
using System.Collections;


public class SwipeDetector : MonoBehaviour 
{
	
	public float minSwipeDistY;
	
	public float minSwipeDistX;
	
	public static float auxD = 0;
	public static bool startGame = false;
	
	private Vector2 startPos;
	float startTime = 0;
	
	public TextMesh texto;
	
	public static float tempoTxt;
	
	void Start(){
		//tempoTxt = GetComponent<TextMesh> ();
	
	}
	
	void Update()
	{
		
		
		//#if UNITY_ANDROID
		//texto.text="CorY?: "+auxD;
		if (Input.touchCount == 0) {
			if (auxD > 0){
			auxD -= Time.deltaTime*10;
			}else{
			auxD = 0;
			}
		}
		
		if (startGame){
		
		startTime += Time.deltaTime;
		
		}
		texto.text = "Time:"+startTime;
		tempoTxt = startTime;
		//auxD += (50);
		if (Input.touchCount > 0) 
			
		{
			
			Touch touch = Input.touches[0];
			
			startGame = true;
			
			switch (touch.phase) 
				
			{
			case TouchPhase.Began:
				startPos = touch.position;
				//auxD += (50);
			break;
		
			case TouchPhase.Moved:
				
				float swipeDistVertical = (new Vector3(0, touch.position.y, 0) - new Vector3(0, startPos.y, 0)).magnitude;
				
				if (swipeDistVertical > minSwipeDistY) 
					
				{
					
					float swipeValue = Mathf.Sign(touch.position.y - startPos.y);
					
					//texto.text="CorY?: "+(touch.deltaTime*1);
					
					if (swipeValue > 0){//up swipe
						
						//Jump ();
						//auxD += swipeValue * Time.deltaTime;
						
						}else if (swipeValue < 0){//down swipe
							
						//Shrink ();
						//auxD += (touch.deltaTime * 1);//)/5;
						auxD += (touch.deltaPosition.y)*-1;// touch.deltaTime);
						//auxD += (1.5f *Time.deltaTime);
						//auxD += (swipeDistVertical / 200)*Time.deltaTime;
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