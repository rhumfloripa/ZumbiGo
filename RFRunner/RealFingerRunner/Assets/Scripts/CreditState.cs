using UnityEngine;
using System.Collections;

public class CreditState : MonoBehaviour {


	void Start ()
    {
        StartCoroutine(CloseCreditState());
	}
	
IEnumerator CloseCreditState()
    {
        yield return new WaitForSeconds(6);
        Application.LoadLevel("Menu");
    }
}
