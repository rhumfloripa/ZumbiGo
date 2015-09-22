using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class Score : MonoBehaviour {
	Text score;
	public bool is3D;
	public TextMesh texto3D;
	// Use this for initialization
	void Start () {
		if (is3D) {
			texto3D = GetComponent<TextMesh> ();
		} else {
			score = GetComponent<Text> ();
		}
	}
	// Update is called once per frame
	void Update () {

		if (is3D) {
			texto3D.text = "Score3D: " + SwipeDetector.tempoTxt;
		} else {
			score.text = "Score: " + SwipeDetector.tempoTxt;
		}
	}
	

}
