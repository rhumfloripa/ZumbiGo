using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class GetScore : MonoBehaviour
{
	
	public TextMesh texto;
	bool foi;
	TextMesh teste;
	// Use this for initialization
	void Start ()
	{
		SaveLoad.Load ();//chama carregador de arquivo
		foi = true;
		print (Application.persistentDataPath);
		teste = GetComponentInChildren<TextMesh> ();
	
	}
	
	// Update is called once per frame
	void Update ()
	{
		teste.text = Game.getTodos ();
		print (Application.persistentDataPath);
		//Game.somaAtual(float.Parse (Score.score.text));//SwipeDetector.tempoTxt;
		Game.setAtual (10);
		texto.text = "Score :" + Game.getAtual ();
		if (Colisao.ganhou) {
		
			SaveLoad.Save ();
			foi = false;
		}
	
	}
}
