using UnityEngine;
using System.Collections;
using System;

[RequireComponent(typeof(AudioSource))]

public class BtTrocaDeCena : MonoBehaviour
{
	public static bool viuSplash = false;
    public AudioSource click;

    // Use this for initialization
    void Start ()
	{
		if (this.tag == "reload") 
			this.gameObject.SetActive (false);
        click = GetComponent<AudioSource>();
	}
	

	public void vaiPara (string cena)
	{
        click.Play();
        StartCoroutine(GoToNextScene(cena));        
	}

    private IEnumerator GoToNextScene(string cena)
    {
        yield return new WaitForSeconds(.25f);
        Application.LoadLevel(cena);
        yield break;
    }

    public void sairSistema()
    {
        PlayerPrefs.Save();
        Application.Quit();
    }
}
