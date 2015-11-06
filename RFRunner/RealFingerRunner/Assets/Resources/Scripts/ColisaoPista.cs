using UnityEngine;
using System.Collections;
// Script para checar se o player tocou na pista na contagem regressiva
public class ColisaoPista : MonoBehaviour
{

	public GameObject botao;
	

	// Use this for initialization;
	void Start ()
	{
	
	}
	
	// Update is called once per frame
	void Update ()
	{
	
	}

	void OnCollisionEnter (Collision collision)
	{
		if (collision.gameObject.tag == "Player" && (SwipeDetector.startGame == false)) {
			
			SwipeDetector.run = true;  // habilita o player a correr
			SwipeDetector.auxD = 0;
			
		}
		
	}
	// esse nao usa pra nada...
	void OnTriggerEnter (Collider other)
	{
		if (other.gameObject.tag == "tri") {
			//Main.score  += 100;
			//Destroy(collision.gameObject);
			//Destroy (this.gameObject);
			
			//botao.SetActive(false);
			//SwipeDetector.startGame = false;
			//SwipeDetector.run = true;
			//SwipeDetector.startGame=true;
			//print ("colidiu pista");
		}
	}

}
