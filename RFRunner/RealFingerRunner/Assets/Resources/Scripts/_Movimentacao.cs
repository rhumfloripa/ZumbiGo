using UnityEngine;
using System.Collections;

public class ____Movimentacao : MonoBehaviour {
	public TextMesh texto3D;
	public static float auxD;
	public static float auxE;
	public bool touchD = false;
	public bool touchE = false;
	public bool controle = false;
	public float speed;
	public float meiaTela = Screen.width/2;
	public int i = 0;
	// Use this for initialization
	void Start () {
		//r2d = GetComponent<Rigidbody2D> ();
		//jump = false;
		//left = false;
		//animator = GetComponentInChildren<Animator> ();
		//filho = transform.GetChild (0).gameObject.GetComponent<Transform>();
		
	}

	// Update is called once per frame
	void Update () {
	
	/*
		if (Input.GetKey (KeyCode.A)) {
			r2d.velocity = new Vector2 (-speed, r2d.velocity.y);
			left = true;
			filho.localRotation = Quaternion.Euler(0, 180, 0);
			state="run";

		}else if (Input.GetKey (KeyCode.D)) {
			filho.localRotation = Quaternion.Euler(0, 0, 0);
			r2d.velocity = new Vector2 (speed, r2d.velocity.y);
			left = false;
			state="run";
		} else {
			r2d.velocity = new Vector2 (0, r2d.velocity.y);
			state="idle";
		}
		switch (state) {
		case "run": 
			animator.Play("run");
			break;
		default: 
			animator.Play("idle");
			break;
		}*/
		oldUpdate();

	}

	void oldUpdate(){
		//touche dos aparelhos
		
		//print ("aux:" + aux);
		
		int nbTouches = Input.touchCount;
		//auxD = 0;
		if(nbTouches > 0){
			for (i = 0; i < nbTouches; i++){
				Touch touch = Input.GetTouch(i);
				
				if (touch.phase != TouchPhase.Stationary){
				
					//if (controle && auxD < 3) { // acelera ate 3.
						//if(aux < 3 && aux > 0.0){
					//	auxD += Time.deltaTime;	
						//}
					//}else{
					//	if(auxD > 0.0){
					//		auxD -= Time.deltaTime;
					//	}else{
					//		auxD = 0;
					//	}
					//}
				
					if (touch.phase == TouchPhase.Moved) {
						
						if ((touchD)&&(touch.position.x < Screen.width/2)){
							controle = true;
							//auxD = 0;
							auxD += Time.deltaTime;	
						}
						
						if ((!touchD)&&(touch.position.x > Screen.width/2)){
							controle = true;
							//auxD = 0;
							auxD += Time.deltaTime;	
						}
						
						
					}else if(touch.phase != TouchPhase.Moved){
						texto3D.text = "aux: "+touchD;
						if ((touchD)&&(touch.position.x > Screen.width/2)){
							controle = false;
							touchD = false;
							if(auxD > 0.0){
									auxD -= Time.deltaTime;
							}else{
								auxD = 0;
							}
						
						}
						
						if ((!touchD)&&(touch.position.x <= Screen.width/2)){
							controle = false;
							touchD = true;
							if(auxD > 0.0){
								auxD -= Time.deltaTime;
							}else{
								auxD = 0;
							}
						}	
					}
				}
				
			
				//touchE = false;

				
				//touchD = true;
				//touchE = false;
				
					//
						if (touch.phase == TouchPhase.Began) {
							controle = true;
							auxD = 0;
						}
						
						if(touch.phase == TouchPhase.Ended){
							controle = false;
						    touchD = true;
						}
					//}
					//touchE = true;
				}
			}
		//print (Gun.shoot);
		
		//Input do pulo
		//if(!jump & Input.GetKeyDown(KeyCode.W)){
		//	r2d.AddForce(Vector2.up*speed*60);
		//	jump=true;
		//	animator.SetBool("isGrounded",false);
			//animator.Play("jump");
		//}
	//}

	//void OnCollisionEnter2D(Collision2D collision){
	//	if(collision.gameObject.tag=="Floor"){
	//		jump=false;
	//		animator.SetBool("isGrounded",true);
	//	}
	}

}
