using UnityEngine;
using System.Collections;
// esse SCRIPT nao serve pra nada....
public class Movimentacao : MonoBehaviour
{
	bool isRight;
	bool toque;
	public static float auxD;
	float meiaTela;
	public float speed;
	
	float oldX, oldY;
	// Use this for initialization
	public TextMesh texto;
	void Start ()
	{
		isRight = true;
		toque = false;
		//speed=2;
		meiaTela = Screen.width / 2;
		auxD = 0;
	}
	
	// Update is called once per frame
	void Update ()
	{
		//botao esquerdo
		texto.text = "Eh pra direita?: " + isRight;
		if (Input.GetMouseButtonDown (0)) {
			toque = true;
			//oldX=Input.mousePosition.x;
			oldY = Input.mousePosition.y;
			
		}
		if (Input.GetMouseButtonUp (0)) {
			toque = false; 
			oldX = 0;
			oldY = 0;
		}
		if (!Input.GetMouseButtonUp (0)) {
			if (auxD > 0.0) {
				auxD -= Time.deltaTime;
			} else {
				auxD = 0;
			}
		}
		if (toque) {//se ta arrastando "dragging" simula o touch
			//verifica se o mouse andou
			if (oldX != Input.mousePosition.x 
				&& oldY > Input.mousePosition.y) {
				//se for a direita
				if (isRight) {
					if (Input.mousePosition.x >= meiaTela) {
						//calcula a velocida para a andada pra direita
						auxD += Time.deltaTime;
						isRight = false;
						
					}
				} else {
					if (Input.mousePosition.x < meiaTela) {
						//calcula a velocida para a andada pra esquerda
						auxD += Time.deltaTime;
						isRight = true;
					}
				}
			
			}
			//pedaço como se fosse o moved
		}
		
	}
}
