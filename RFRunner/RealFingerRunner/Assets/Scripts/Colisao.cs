using UnityEngine;
using System.Collections;
using UnityEngine.UI;

// Script quando o bloco player chega ao final da pista colisao com bloco FIM DA PISTA
public class Colisao : MonoBehaviour
{

	AudioSource audioFinish;

	float myscore;
	public static float highScore;
	public static bool isRecord;
	public static string key = "score"; // nome da chave que ira gravar
	public AudioClip win;
	public AudioClip lose;

	//ArrayList lNames = new ArrayList ();
	//public InputField name;


	void Start ()
	{
		audioFinish = GetComponent<AudioSource> ();
		audioFinish.clip = lose;
		isRecord = false;
	}
	

	void OnTriggerEnter (Collider collider)
	{
		if (collider.gameObject.tag == "Player" && !SwipeDetector.queimouLargada) {
			Score.gameFinished = true;
			myscore = Score.startTime;
            
			//Grava o score
			if (PlayerPrefs.HasKey (key)) {
				highScore = PlayerPrefs.GetFloat (key);

				if (myscore < highScore) {
					isRecord = true;
					PlayerPrefs.SetFloat (key, myscore);
					highScore = myscore;   
					audioFinish.clip = win;
					PlayerPrefs.Save ();
				} 
			} else {
				// se nao tem save, ele cria agora!!!
				PlayerPrefs.SetFloat (key, myscore);
				audioFinish.clip = win;
				PlayerPrefs.Save ();
			}

			audioFinish.Play ();

			//ADICAO DE NOME E ARRAY LISTA COM SAVE
			//name.text = "Enter your name :";
		}
	}
}
