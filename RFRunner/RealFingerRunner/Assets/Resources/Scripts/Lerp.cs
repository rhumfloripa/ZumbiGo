using UnityEngine;
using System.Collections;

public class Lerp : MonoBehaviour {

	public int tipo;

    //public int direct;
    public float tempo;

	float lerpTime = 1f;
	float currentLerpTime;
	
	float moveDistance = 10f;
	
	Vector3 startPos;
	Vector3 endPos;
    bool carregou;
    float contador;
	
	
	
		
	protected void Start () {

        //rnd = Random.Range(1,5);
        carregou = false;
        contador = 0;
        

            startPos = transform.position;
			endPos = transform.position + transform.right * moveDistance;
        currentLerpTime = 0f;

    }
		
	protected void Update () {

        //int rnd = Random.Range(1,5);
        //tipo = (int)rnd;

        contador++;
        

        if (!carregou )
        {
            if(contador >= tempo)
              carregou = true;
        }
        else
        {
            currentLerpTime += Time.deltaTime;
            if (currentLerpTime > lerpTime)
            {
                currentLerpTime = lerpTime;
            }

            float perc = currentLerpTime / lerpTime;
            if (tipo == 1) perc = Mathf.Sin(perc * Mathf.PI * 0.5f);//ease=out
            if (tipo == 2) perc = 1f - Mathf.Cos(perc * Mathf.PI * 0.5f);//ease=in
            if (tipo == 3) perc = perc * perc;// exponencial
            if (tipo == 4) perc = perc * perc * (3f - 2f * perc);//smoth step
            if (tipo == 5) perc = perc * perc * perc * (perc * (6f * perc - 15f) + 10f);//smother step
            transform.position = Vector3.Lerp(startPos, endPos, perc);
        }
			
		
		
		
		
	
	}
}
