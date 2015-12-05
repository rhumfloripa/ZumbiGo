using UnityEngine;
using System.Collections;

public class Lerp : MonoBehaviour
{ 

    public int tipo;
    public float tempo;
    public float moveDistance;
    public Vector3 way;
    public bool mustDestroy;
    public Camera camera;
    public bool isGhost;

    float lerpTime;
    float currentLerpTime = 0f;

    Vector3 startPos;
    Vector3 endPos;

    bool carregou = false;
    float contador = 0;


    protected void Start()
    {
        lerpTime = 1f;
        startPos = transform.position;
        endPos = startPos + way * moveDistance;
    }

    protected void Update()
    {
        contador++;

        if (!carregou)
        {
            if (contador >= tempo)
            {
                carregou = true;    
            }
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

                if (mustDestroy && contador > 200)
                {
                    camera.backgroundColor = Color.black;
                    Destroy(this.gameObject);
                }
            }
        }
    }

