using UnityEngine;
using System.Collections;

public class BtTrocaDeCena : MonoBehaviour
{
	public static bool viuSplash = false;
	
	// Use this for initialization
	void Start ()
	{
		if (this.tag == "reload") {
			this.gameObject.SetActive (false);
		}
		//viuSplash = false;
	}
	
	// Update is called once per frame
	void Update ()
	{
		
	
	}
	
	public void vaiPara (string cena)
	{
		SwipeDetector.tempoTxt = 0;
		SwipeDetector.startTime = 0;
		SwipeDetector.auxD = 0;
		SwipeDetector.startGame = false;
		SwipeDetector.timeLeft = 3;
		Application.LoadLevel (cena);
		
		
		//print ("colidiu ="+SwipeDetector.startGame);
		
		
	}
    public void sairSistema()
    {
        
        PlayerPrefs.Save();
        Application.Quit();


        //print ("colidiu ="+SwipeDetector.startGame);


    }

}
