using UnityEngine;
using System.Collections;

[System.Serializable]
public class Game {

	public static Game current;
	public float score;
	
	public Game(){
		score = 0;
		current = this;
	}
}
