using UnityEngine;
using System.Collections;
using UnityEngine.UI;
//script para formatar e imprimir o tempo na tela
public class Score : MonoBehaviour
{
	public static Text score;
	public bool is3D;
	//public TextMesh texto3D;
	public TextMesh timerTxt;
	//public TextMesh timer;
	//public float endTime;
	// Use this for initialization
	void Start ()
	{
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
	void Update ()
	{
		// mostra queimou largada
		if (SwipeDetector.queimouLargada) {
			score.color = new Color (255, 0, 0);
			score.text = "Queimou Largada";
			SwipeDetector.auxD = 0;
			SwipeDetector.counter = 0;
			Colisao.ganhou = false;
			//texto3D.text = "TIME: " + SwipeDetector.timer;
		} else {
			
			// mostra o tempo na tela com a formataçao dos segundos
			score.text = "Time: " + FloatToTime (SwipeDetector.tempoTxt, "#0.0");
			//Game.setAtual (SwipeDetector.tempoTxt);//score.text = "Timer: " + SwipeDetector.tempoTxt;
			
			// mostra o GO! no lugar o ZERO
			if (SwipeDetector.timer == "0") {
				timerTxt.text = "GO!";
				SwipeDetector.startGame = true; // habilita o player a correr
				Colisao.ganhou = false;
				
			} else {
			
				timerTxt.text = "" + SwipeDetector.timer;
			
			}
			// faz o contador regressivo sumir da tela
			if (SwipeDetector.timer == "-1") {
				timerTxt.text = "";
				//SwipeDetector.startGame = true;
				SwipeDetector.timer = "-20";
			}
		}
		//var timeLeft : int = endTime - Time.time;
		//if (timeLeft < 0) timeLeft = 0;
		//textMesh.text = timeLeft.ToString();
	}
	
	// formata o tempo na tela
	public static string FloatToTime (float toConvert, string format)
	{
		switch (format) {
		case "00.0":
			return string.Format ("{0:00}:{1:0}", 
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 10) % 10));//miliseconds
			break;
		case "#0.0":
			return string.Format ("{0:#0}.{1:0}", 
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 10) % 10));//miliseconds
			break;
		case "00.00":
			return string.Format ("{0:00}:{1:00}", 
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 100) % 100));//miliseconds
			break;
		case "00.000":
			return string.Format ("{0:00}:{1:000}", 
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 1000) % 1000));//miliseconds
			break;
		case "#00.000":
			return string.Format ("{0:#00}:{1:000}", 
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 1000) % 1000));//miliseconds
			break;
		case "#0:00":
			return string.Format ("{0:#0}:{1:00}",
			                     Mathf.Floor (toConvert / 60),//minutes
			                     Mathf.Floor (toConvert) % 60);//seconds
			break;
		case "#00:00":
			return string.Format ("{0:#00}:{1:00}", 
			                     Mathf.Floor (toConvert / 60),//minutes
			                     Mathf.Floor (toConvert) % 60);//seconds
			break;
		case "0:00.0":
			return string.Format ("{1:00}.{2:0}",
			                     //Mathf.Floor(toConvert / 60),//minutes
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 10) % 10));//miliseconds
			break;
		case "#0:00.0":
			return string.Format ("{1:00}.{2:0}",
			                     //Mathf.Floor(toConvert / 60),//minutes
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 10) % 10));//miliseconds
			break;
		case "0:00.00":
			return string.Format ("{0:0}:{1:00}.{2:00}",
			                     Mathf.Floor (toConvert / 60),//minutes
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 100) % 100));//miliseconds
			break;
		case "#0:00.00":
			return string.Format ("{0:#0}:{1:00}.{2:00}",
			                     Mathf.Floor (toConvert / 60),//minutes
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 100) % 100));//miliseconds
			break;
		case "0:00.000":
			return string.Format ("{0:0}:{1:00}.{2:000}",
			                     Mathf.Floor (toConvert / 60),//minutes
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 1000) % 1000));//miliseconds
			break;
		case "#0:00.000":
			return string.Format ("{0:#0}:{1:00}.{2:000}",
			                     Mathf.Floor (toConvert / 60),//minutes
			                     Mathf.Floor (toConvert) % 60,//seconds
			                     Mathf.Floor ((toConvert * 1000) % 1000));//miliseconds
			break;
		}
		return "error";
	}
	

}
