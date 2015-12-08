using UnityEngine;
using System.Collections;
using System;

[RequireComponent(typeof(AudioSource))]

public class BtTrocaDeCena : MonoBehaviour
{
    public AudioSource click;

    // Use this for initialization
    void Start ()
	{
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

    public void SetRecord()
    {

    } 
}
