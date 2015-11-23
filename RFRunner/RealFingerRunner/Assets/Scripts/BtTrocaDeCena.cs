using UnityEngine;
using System.Collections;

public class BtTrocaDeCena : MonoBehaviour
{
	public static bool viuSplash = false;
	
	// Use this for initialization
	void Start ()
	{
		if (this.tag == "reload") 
			this.gameObject.SetActive (false);
	}
	

	public void vaiPara (string cena)
	{
		SwipeDetector.accelarator = 0;
		Application.LoadLevel (cena);
	}

    public void sairSistema()
    {
        PlayerPrefs.Save();
        Application.Quit();
    }
}
