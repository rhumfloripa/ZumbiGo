using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class Score : MonoBehaviour {
	Text score;
	public bool is3D;
	//public TextMesh texto3D;
	public TextMesh timerTxt;
	//public TextMesh timer;
	//public float endTime;
	// Use this for initialization
	void Start () {
		if (is3D) {
			//texto3D = GetComponent<TextMesh> ();
			//timerTxt = GetComponent<TextMesh> ();
		} else {
			score = GetComponent<Text> ();
			//timerTxt = GetComponent<TextMesh> ();
		}
		
		//endTime = Time.time + 60;
		//timer = GetComponent<TextMesh> ();;
		//textMesh.text = "60";
	}
	// Update is called once per frame
	void Update () {

		if (is3D) {
			//texto3D.text = "Score3D: " + SwipeDetector.tempoTxt;
			//texto3D.text = "TIME: " + SwipeDetector.timer;
		} else {
			score.text = "Score: " + SwipeDetector.tempoTxt;
			
			if (SwipeDetector.timer == "0"){
				timerTxt.text = "GO!";
				
			}else {
			
				timerTxt.text = "" + SwipeDetector.timer;
			
			}
			if (SwipeDetector.timer == "-1"){
				timerTxt.text = "";
				//SwipeDetector.startGame = true;
				SwipeDetector.timer="-20";
			}
		}
		//var timeLeft : int = endTime - Time.time;
		//if (timeLeft < 0) timeLeft = 0;
		//textMesh.text = timeLeft.ToString();
	}
	

}
