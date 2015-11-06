using UnityEngine;
using System.Collections;
using UnityEngine.UI;
// Script para mostrar hiscore na tela
public class TextoHiScore : MonoBehaviour
{
	public static Text texto;
	// Use this for initialization
	void Start ()
	{
		texto = GetComponent<Text> ();
		
	}
	
	// Update is called once per frame
	void Update ()
	{
	
	}
	
	public static void mostraScore ()
	{
		if (PlayerPrefs.HasKey (Colisao.key)) {
			texto.text = "Best Time: " + Score.FloatToTime (PlayerPrefs.GetFloat (Colisao.key), "#0.0");
		} else {
		
			texto.text = "errou";
			
		}
	}
}
