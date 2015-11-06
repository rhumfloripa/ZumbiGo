using UnityEngine;
using System.Collections;
using UnityEngine.UI;
// Script quando o bloco player chega ao final da pista colisao com bloco FIM DA PISTA
public class Colisao : MonoBehaviour
{

	public GameObject botao;
	AudioSource audioFinish;
	public static bool ganhou; // 
	public InputField name;
	public static float tempoFinal; // pega tempo do Swipedetector
	public static float highscore;
	public static string key; // nome da chave que ira gravar
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
	
		// verifica se queimou largada
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
			//Grava o score
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
				// se nao tem save, ele cria agora!!!
				PlayerPrefs.SetFloat (key, myscore);
				PlayerPrefs.Save ();
			}
			TextoHiScore.mostraScore ();
			//PlayerPrefs.SetFloat ("Score", tempoFinal);//grava o dado
			//PlayerPrefs.Save ();
			
			// ajusta as variaveis para o replay
			SwipeDetector.startGame = false;
			SwipeDetector.run = false;
			SwipeDetector.timer = "3";
			SwipeDetector.isTouch = true;
			SwipeDetector.counter = 0;
			SwipeDetector.auxD = 0;
			ganhou = true;
			botao.SetActive (true);
			audioFinish.Play ();
			
			//print (PlayerPrefs.GetFloat("Score"));//le o dado

			//ADICAO DE NOME E ARRAY LISTA COM SAVE
			name.text = "Enter your name :";
    
		}
		
		
	
	}

}
