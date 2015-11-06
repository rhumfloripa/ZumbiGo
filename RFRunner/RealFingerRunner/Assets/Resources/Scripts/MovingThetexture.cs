using UnityEngine;
using System.Collections;
// Script que faz a movimentaçao do player sobre a pista
public class MovingThetexture : MonoBehaviour
{
	public float speed;
	private float offSet;
	//public Material currentMaterial;
	public float velocidadeX;
	public float velocidadeY;
	public float velocidadeZ;
	//public currentMaterial renderer.material; 
	Rigidbody rgbody;
	
	// Use this for initialization
	void Start ()
	{
		
		rgbody = GetComponent<Rigidbody> ();
		
	}
	
	// Update is called once per frame
	void Update ()
	{
		//acelera o player com os dados do swipedetector
		offSet = SwipeDetector.auxD * Time.deltaTime;
		
		rgbody.velocity = new Vector3 (0, -10, offSet);
	}
	
}