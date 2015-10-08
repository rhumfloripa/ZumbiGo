using UnityEngine;
using System.Collections;

public class GetScore : MonoBehaviour
{
	
	public TextMesh texto;
	bool foi;
	// Use this for initialization
	void Start ()
	{
		SaveLoad.Load ();//chama carregador de arquivo
		foi = true;
		print (Application.persistentDataPath);
	
	}
	
	// Update is called once per frame
	void Update ()
	{
	
		Game.current.score += 0.1f;
		texto.text = "Score :" + Game.current.score;
		if (Game.current.score > 100 && foi) {
		
			SaveLoad.Save ();
			foi = false;
		}
	
	}
}
