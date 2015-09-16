using UnityEngine;
using System.Collections;

public class MobileDevice : MonoBehaviour {

	// Use this for initialization
	void Start () {
		Input.simulateMouseWithTouches=true;
	}
	
	// Update is called once per frame
	void Update () {
	
		//touche dos aparelhos
		int nbTouches = Input.touchCount;
		//print (nbTouches);
		if(nbTouches > 0){
			
			//for (int i = 0; i < nbTouches; i++){
				//if(Input.GetTouch(i).phase == TouchPhase.Began){
					//faz alguma coisa
					//dispara um raio (raycast), colide com
					// alguma coisa e tals
					//Ray ray = Camera.main.ScreenPointToRay (Input.GetTouch(i).position);
					//RaycastHit2D hit = Physics2D.Raycast(ray.origin, ray.direction);
					//if (hit != null) {
					//	if (hit.collider !=null){
					//		GameObject aux = hit.transform.gameObject;
					//		aux.GetComponentInChildren<SpriteRenderer>()
					//			.color = Color.blue;
					//	}
					//}
					
		}
	
		
		
		
		
	}
}
