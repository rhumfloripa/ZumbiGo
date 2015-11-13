using UnityEngine;
using System.Collections;

public class Splash : MonoBehaviour
{
	public float tempo;
	float aux;
    AudioSource introSound;

    // Use this for initialization
    void Start ()
	{
	    introSound = GetComponent<AudioSource>();
        introSound.Play();
    }
	
	// Update is called once per frame
	void Update ()
	{

       
        if (!BtTrocaDeCena.viuSplash) {
			aux += Time.deltaTime;
			if (aux >= tempo) {
				aux = 0;
				Destroy (this.gameObject);
				BtTrocaDeCena.viuSplash = true;
			}
		} else {
			Destroy (this.gameObject);	
		
			
		}
	
	}
}
