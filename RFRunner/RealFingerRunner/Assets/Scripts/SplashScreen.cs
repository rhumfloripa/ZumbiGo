using UnityEngine;
using System.Collections;

public class SplashScreen : MonoBehaviour {


	void Start ()
    {
        StartCoroutine(DestroySplashScreen());
    }

    IEnumerator DestroySplashScreen ()
    {
        yield return new WaitForSeconds(3);
        Application.LoadLevel("Menu");
    }
}
