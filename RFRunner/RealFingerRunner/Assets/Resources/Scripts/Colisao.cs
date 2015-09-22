using UnityEngine;
using System.Collections;

public class Colisao : MonoBehaviour {

	// Use this for initialization;
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnCollisionEnter (Collision collision){
		if (collision.gameObject.tag == "Player" && SwipeDetector.startGame) {
			//Main.score  += 100;
			//Destroy(collision.gameObject);
			//Destroy (this.gameObject);
			SwipeDetector.startGame = false;
		}


	
	}

}
