using UnityEngine;
using System.Collections;

public class Colisao : MonoBehaviour
{

	public GameObject botao;
	AudioSource audioFinish;
	public static bool ganhou;

	// Use this for initialization;
	void Start ()
	{
		audioFinish = GetComponent<AudioSource> ();
		ganhou = false;
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
			
			
			SwipeDetector.startGame = false;
			SwipeDetector.run = false;
			SwipeDetector.timer = "3";
			SwipeDetector.isTouch = true;
			ganhou = true;
			botao.SetActive (true);
			audioFinish.Play ();
			
		}
		
		
	
	}

}
