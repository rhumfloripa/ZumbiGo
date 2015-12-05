using UnityEngine;
using System.Collections;

public class GhostLerp : MonoBehaviour
{
    public Vector3 way;

    float lerpTime; 
    float currentLerpTime = 0f;

    public Transform startPos;
    public Transform endPos;
     
    void Start()
    {
        lerpTime = PlayerPrefs.GetFloat(Colisao.key);
    }

    void Update()
    {
        if (Score.startGame)
        {
            currentLerpTime += Time.deltaTime;

            if (currentLerpTime > lerpTime)
            {
                currentLerpTime = lerpTime;
            }

            float perc = currentLerpTime / lerpTime;

            perc = 1f - Mathf.Cos(perc * Mathf.PI * 0.5f);

            transform.position = Vector3.Lerp(startPos.position, endPos.position, perc);
        }
    }
}
