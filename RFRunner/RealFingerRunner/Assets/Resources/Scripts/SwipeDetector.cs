using UnityEngine;
using System.Collections;


public class SwipeDetector : MonoBehaviour 
{
	
	public float minSwipeDistY;
	
	public float minSwipeDistX;
	
	public static float auxD = 0;
	public static bool startGame = false;
	
	private Vector2 startPos;
	public static float startTime = 0;
	
	public TextMesh texto;
	
	public static float tempoTxt;
	public static bool run;
	public bool isDebug;
	public static string timer;
	public int endTime;
	public static int timeLeft;
	
	
	void Start(){
		//tempoTxt = GetComponent<TextMesh> ();
	run = false;
	endTime = 3;
	timeLeft = 3;
	if(isDebug)auxD=20;
	}
	
	void Update()
	{
		if(isDebug && startGame ){
			auxD+=20;
			//startGame=true;
		}
		
		//#if UNITY_ANDROID
		//texto.text="CorY?: "+auxD;
		if (Input.touchCount == 0) {
			if (auxD > 0){
			auxD -= Time.deltaTime*50;
			}else{
			auxD = 0;
			}
		}
		//print ("ST:"+ startGame);
		//print ("RUN:"+ run);
		
		if (run && startGame){
		
			startTime += Time.deltaTime;
		
		}
		//texto.text = "Time:"+startTime;
		tempoTxt = startTime;
		//auxD += (50);
		
		timeLeft = endTime - (int)Time.timeSinceLevelLoad;
		if (timeLeft < -1) timeLeft = -1;
		timer = timeLeft.ToString();
		
		if(isDebug)
		if(Input.GetMouseButtonDown(0)){
		startGame = true;
		}
		print (Input.mousePosition.y);
		if (Input.touchCount > 0) 
		{
			
			Touch touch = Input.touches[0];
			
				if(touch.position.y < Screen.height/2 && run){
					//texto.text="pos: "+touch.position.y;
					startGame = true;
				}
			
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
					if (swipeValue < 0){//down swipe
							
						//Shrink ();
						//auxD += (touch.deltaTime * 1);//)/5;
						auxD += (touch.deltaPosition.y)*-1;// touch.deltaTime);
						//auxD += (1.5f *Time.deltaTime);
						//auxD += (swipeDistVertical / 200)*Time.deltaTime;
					}	
				}
				break;
			}
		}
	}
}