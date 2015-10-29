using UnityEngine;
using System.Collections;
using System.Collections.Generic;

[System.Serializable]
public class Game
{

	public static Game current;
	//public static float[] score;
	public static float atual;
	public static ArrayList score;
	private string meuPehDeJaca;
	public  Game ()
	{
		
		atual = 20000;
		//atual = Colisao.tempoFinal;
		score = new ArrayList ();
		score.Add (atual);
		//score = ;
		meuPehDeJaca = "String marota dos infernos para testar essa gambiarra!!!!";
		
		current = this;
	}
    
	public static void somaAtual (float novo)
	{
		atual += novo;
	}
	
	public static void setAtual (float novo)
	{
		atual = Colisao.tempoFinal;
		
		//score.Add(atual);
	}
	
	public static float getAtual ()
	{
		return atual;
	}
    
	public static string getTodos ()
	{
		return "" + score [0] + "\n";
	}
    
	public static void organize ()
	{
		//adicionar o meu novo atual na lista
    
		//organiza a ordem do vetor de scores
	}
    
}
