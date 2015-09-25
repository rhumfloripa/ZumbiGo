using UnityEngine;
using System.Collections;

public class ColisaoPista : MonoBehaviour {

	public GameObject botao;

	// Use this for initialization;
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnCollisionEnter (Collision collision){
		if (collision.gameObject.tag == "Player" && (SwipeDetector.startGame == false)) {
			//Main.score  += 100;
			//Destroy(collision.gameObject);
			//Destroy (this.gameObject);
			
			//botao.SetActive(false);
			//SwipeDetector.startGame = false;
			SwipeDetector.run = true;
			//SwipeDetector.startGame=true;
			//print ("colidiu pista");
		}
	}
	
	void OnTriggerEnter(Collider other) {
		if (other.gameObject.tag == "tri") {
			//Main.score  += 100;
			//Destroy(collision.gameObject);
			//Destroy (this.gameObject);
			
			//botao.SetActive(false);
			//SwipeDetector.startGame = false;
			//SwipeDetector.run = true;
			//SwipeDetector.startGame=true;
			print ("colidiu pista");
		}
	}

}
