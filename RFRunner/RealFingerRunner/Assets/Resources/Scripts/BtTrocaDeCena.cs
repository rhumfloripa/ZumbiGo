using UnityEngine;
using System.Collections;

public class BtTrocaDeCena : MonoBehaviour {
	
	// Use this for initialization
	void Start () {
		if (this.tag=="reload"){
				this.gameObject.SetActive(false);
		}
	}
	
	// Update is called once per frame
	void Update () {
		
	
	}
	
	public void vaiPara(string cena){
		SwipeDetector.tempoTxt = 0;
		SwipeDetector.auxD = 0;
		SwipeDetector.startGame=false;
		Application.LoadLevel(cena);
		
		
	}
}
