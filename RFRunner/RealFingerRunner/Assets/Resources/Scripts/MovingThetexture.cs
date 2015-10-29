using UnityEngine;
using System.Collections;

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
		//currentMaterial = GetComponent<Renderer>().material;
		rgbody = GetComponent<Rigidbody> ();
		//rgbody.velocity = new Vector3(0,0,100000*0.02f);
	}
	
	// Update is called once per frame
	void Update ()
	{
		offSet = SwipeDetector.auxD * Time.deltaTime;
		
		//currentMaterial.SetTextureOffset("_MainTex",new Vector2(0,offSet));
		//transform.Translate (0, 0, offSet);
		rgbody.velocity = new Vector3 (0, -10, offSet);
	}
	
}