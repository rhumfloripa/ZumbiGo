using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class Colisao : MonoBehaviour
{

	public GameObject botao;
	AudioSource audioFinish;
	public static bool ganhou;
	public InputField name;
	public static float tempoFinal;
	public static float highscore;
	public static string key;
	float myscore;
	float score;
	//ArrayList lNames = new ArrayList ();



	// Use this for initialization;
	void Start ()
	{
		audioFinish = GetComponent<AudioSource> ();
		ganhou = false;
		key = "score";
		//score = 0;
	}
	
	// Update is called once per frame
	void Update ()
	{
		if (SwipeDetector.queimouLargada) {
			
			//SwipeDetector.queimouLargada = true;
			botao.SetActive (true);
			SwipeDetector.startGame = false;
			SwipeDetector.run = false;
			SwipeDetector.timer = "3";
			
		}
	}

	void OnCollisionEnter (Collision collision)
	{
		if (collision.gameObject.tag == "Player" && SwipeDetector.startGame) {
			//Main.score  += 100;
			//Destroy(collision.gameObject);
			//Destroy (this.gameObject);
			
			tempoFinal = SwipeDetector.startTime;
			myscore = tempoFinal;
			
			if (PlayerPrefs.HasKey (key)) {
				
				highscore = PlayerPrefs.GetFloat (key);
				
				if (highscore > myscore) {
					
					PlayerPrefs.SetFloat (key, myscore);
					
					highscore = myscore;
					//score = myscore;
					
					
					PlayerPrefs.Save ();
					
				}
				
				//score = highscore;
				//print (PlayerPrefs.GetFloat (key));
				
			} else {
				PlayerPrefs.SetFloat (key, myscore);
				PlayerPrefs.Save ();
			}
			TextoHiScore.mostraScore ();
			//PlayerPrefs.SetFloat ("Score", tempoFinal);//grava o dado
			//PlayerPrefs.Save ();
			
			
			SwipeDetector.startGame = false;
			SwipeDetector.run = false;
			SwipeDetector.timer = "3";
			SwipeDetector.isTouch = true;
			ganhou = true;
			botao.SetActive (true);
			audioFinish.Play ();
			
			//print (PlayerPrefs.GetFloat("Score"));//le o dado

			//ADICAO DE NOME E ARRAY LISTA COM SAVE
			name.text = "Enter your name :";
    
		}
		
		
	
	}

}
