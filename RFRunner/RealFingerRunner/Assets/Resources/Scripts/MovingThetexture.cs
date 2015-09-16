using UnityEngine;
using System.Collections;

public class MovingThetexture : MonoBehaviour {
	//public float speed;
	private float offSet;
	public Material currentMaterial;
	//public currentMaterial renderer.material; 
	
	// Use this for initialization
	void Start () {
		currentMaterial = GetComponent<Renderer>().material;
		
	}
	
	// Update is called once per frame
	void Update () {
		offSet += SwipeDetector.auxD;
		
		currentMaterial.SetTextureOffset("_MainTex",new Vector2(0,offSet));
	}
	
}