using UnityEngine;
using System.Collections;

public class Colisao : MonoBehaviour
{

	public GameObject botao;
	AudioSource audioFinish;

	// Use this for initialization;
	void Start ()
	{
		audioFinish = GetComponent<AudioSource> ();
	}
	
	// Update is called once per frame
	void Update ()
	{
	
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
			botao.SetActive (true);
			audioFinish.Play ();
			
		}


	
	}

}
