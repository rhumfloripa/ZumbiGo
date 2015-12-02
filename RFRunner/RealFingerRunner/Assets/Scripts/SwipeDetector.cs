using UnityEngine;
using System.Collections;


public class SwipeDetector : MonoBehaviour
{
	AudioSource audioStep;
	Rigidbody rgbody;
	public Camera camera;
	public float minSwipeDistY;
	public static float accelarator = 0;
	public static bool queimouLargada;

	private Vector2 startPos;
	float xzRotation = .5f;
	bool startRunning;

	bool stepLeft;
	bool stepRight;
	bool isTouch;
	float counter;

	void Start ()
	{
		isTouch = false;
		queimouLargada = false;
		startRunning = false;

		rgbody = GetComponent<Rigidbody> ();
		audioStep = GetComponent<AudioSource> ();

		accelarator = 0;
		counter = 0;
    }

    void SetSpeed()
    {
        if (accelarator >= 58) { accelarator = 70; return; }
        else if (accelarator >= 46) { accelarator = 60; return; }
        else if (accelarator >= 35) { accelarator = 50; return; }
        else if (accelarator >= 25) { accelarator = 40; return; }
        else if (accelarator >= 20) { accelarator = 30; return; }
        else if (accelarator >= 15) { accelarator = 25; return; }
        else if (accelarator >= 8) { accelarator = 20; return; }
        else accelarator = 10;
    }


	void Update ()
	{
        if (!Score.startGame && !queimouLargada)
        {
			camera.transform.rotation = Quaternion.Slerp (camera.transform.rotation, Quaternion.Euler (25, 0, 0), .1f);
			camera.transform.position = Vector3.Lerp (camera.transform.position,
                    new Vector3 (camera.transform.position.x, 10, camera.transform.position.z), .075f);
		}

		if (startRunning)
        {
			camera.transform.position = Vector3.Lerp (camera.transform.position,
                    new Vector3 (camera.transform.position.x, 13, camera.transform.position.z), .01f);
			camera.transform.rotation = Quaternion.Slerp (camera.transform.rotation, Quaternion.Euler (xzRotation, 0, xzRotation), .1f);
		}


#if UNITY_EDITOR

		if (Input.GetKeyDown (KeyCode.Space))
        {
			SetSpeed ();
			xzRotation *= -1;
			startRunning = true;
			audioStep.Play ();

			if (!Score.startGame)
				queimouLargada = true;
        }

        if (accelarator > 0)
            accelarator -= accelarator * .016f;

        rgbody.velocity = new Vector3(0, 0, accelarator);

#else
 	
		if (accelarator > 0)
			accelarator -= accelarator * .0016f; //desacelara total em 1 seg (1.6% ao frame)

        rgbody.velocity = new Vector3 (0, 0, accelarator * Time.deltaTime);


		//verifica queimou largada
		if (Input.touchCount > 0 && !Score.startGame) 
        {
		    queimouLargada = true;
		}
			
        //print (Input.mousePosition.y);
        if (Input.touchCount > 0)
        {	
			Touch touch = Input.touches [0];
			startRunning = true;
			
			if (touch.position.y < Screen.height / 2) // verifica se o touch foi tocado
			{
                isTouch = true;				

            switch (touch.phase) 
            {

                case TouchPhase.Began:
				startPos = touch.position;
				
				// faz passos alternado 
				if (stepRight == true) {
					stepLeft = true;
					stepRight = false;
				} else {
					stepRight = true;
					stepLeft = false;
				}
				
				// faz som dos passos 
				if (stepRight)
				{
					audioStep.pitch = 1.5f;
					audioStep.Play ();
					stepRight = true;
				} else {
					audioStep.pitch = 1f;
					audioStep.Play ();
					//stepLeft = true;
				}			
				break;

			// verifica se o touch esta em movimento
			case TouchPhase.Moved:
				
				float swipeDistVertical = (new Vector3 (0, touch.position.y, 0) - new Vector3 (0, startPos.y, 0)).magnitude;
				
					if (swipeDistVertical > minSwipeDistY)
                    {
					float swipeValue = Mathf.Sign (touch.position.y - startPos.y);
					if (swipeValue < 0) //down swipe
                    { 		
						if (Score.startGame)
                        {
                                    
                            xzRotation *= -1;
                            // 1st step
							if (counter == 0)
                            { 
							    accelarator += 500;
								counter ++;
							}
									
							// 2nd e 3rd steps
							if (counter >= 1 && counter < 3)
                            { 
							    accelarator += 200;
								counter ++;			
							}

                            else
                            { 
                                accelarator = touch.deltaPosition.y * -.1f;
								//accelarator += ((touch.deltaPosition.y) / 2) * -1;
							}
                         }
				   }
                }
				break;
		    }
		}
	}
#endif
    }
}