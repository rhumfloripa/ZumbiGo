using UnityEngine;
using System.Collections;

// Gera aceleraçao da movimentaçao e controles de todo jogo

public class SwipeDetector : MonoBehaviour
{

	
	public float minSwipeDistY;
	public float minSwipeDistX;
	public static float auxD = 0; // acelerador
	public static bool startGame = false; // controle para inicio 
	private Vector2 startPos;
	public static float startTime = 0; // contador de tempo
	public TextMesh texto;
	public static float tempoTxt;
	public static bool run; // verifica se ja pode correr, somente quando o player toca na pista
	public bool isDebug;
	public static string timer; // controle de tempo
	public int endTime; // controle de tempo
	public static int timeLeft; // controle de tempo
	AudioSource audioStep;
	bool stepLeft;
	bool stepRight;
	public static bool isTouch;
	public static bool queimouLargada;
	public static float counter;
	//public AudioSource audioStepRight;
	//public AudioSource audioStepLeft;
	
	//public static float highscore;
	
	//public static float myscore;
	
	
	void Start ()
	{
		//tempoTxt = GetComponent<TextMesh> ();
		run = false;
		endTime = 3;
		timeLeft = 3;
		isTouch = false;
		queimouLargada = false;
		//Colisao.ganhou = false;
		if (isDebug)
			auxD = 20;
			
		audioStep = GetComponent<AudioSource> ();
		auxD = 0;
		counter = 0;
		
	}
	
	void Update ()
	{
		
		if (Input.GetKeyDown (KeyCode.Escape)) 
			//Application.Quit (); 
		
	
		if (isDebug && startGame) {
			auxD += 20;
			//startGame=true;
		}
		
	
		// desacelerador
		if (Input.touchCount == 0) {
			if (auxD > 0) {
				auxD -= Time.deltaTime * 100;
			} else {
				auxD = 0;
			}
		}

		
		
		// conta o tempo
		if (run && startGame) {
		
			startTime += Time.deltaTime;
		
		}
		
		//verifica queimou largada
		if (Input.touchCount > 0 && !startGame && !Colisao.ganhou) {
		
			queimouLargada = true;
		
		}
		//texto.text = "Time:"+startTime;
		tempoTxt = startTime;
		//auxD += (50);
		
		
		// count down
		timeLeft = endTime - (int)Time.timeSinceLevelLoad;
		if (timeLeft < -1)
			timeLeft = -1;
		timer = timeLeft.ToString ();  // converte para string
		
		if (isDebug)
		if (Input.GetMouseButtonDown (0)) {
			startGame = true;
		}
		//print (Input.mousePosition.y);
		if (Input.touchCount > 0) {
			
			Touch touch = Input.touches [0];
			// verifica se o touch foi tocado
			if (touch.position.y < Screen.height / 2 && run) {
				//texto.text="pos: "+touch.position.y;
				isTouch = true;
			}
			
			switch (touch.phase) {
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
				if (stepRight) {
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
				
				if (swipeDistVertical > minSwipeDistY) {
					
					float swipeValue = Mathf.Sign (touch.position.y - startPos.y);
					if (swipeValue < 0) {//down swipe
							
						// verifica de o Run e o startgame estao prontos para acelerar
						if (run && startGame) {
							
							// 1st step
							if (counter == 0) { 
								
								auxD += 500;
								counter ++;
							}
									
							// 2nd e 3rd steps
							if (counter >= 1 && counter < 3) { 
								
								auxD += 200;
								counter ++;
								
								
							} else { 
							
								// more steps
								auxD += ((touch.deltaPosition.y) / 2) * -1;
								
							}
							
							
						} else {
							auxD = 0;
						}
					}	
				}
				break;
			}
		}
	}
}