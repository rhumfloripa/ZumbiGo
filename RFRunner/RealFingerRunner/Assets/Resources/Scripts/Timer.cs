using UnityEngine;
using System.Collections;
//Script para contar tempo para aparecer o menu na tela depois do splash 
public class Timer : MonoBehaviour
{
	public float tempo;
	float aux;
	// Use this for initialization
	void Start ()
	{
	
	}
	
	// Update is called once per frame
	void Update ()
	{
		aux += Time.deltaTime;
		if (aux >= tempo) {
			aux = 0;
			
			Application.LoadLevel ("Menu");
			
			
		}
	}
}

