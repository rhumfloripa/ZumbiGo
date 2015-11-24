using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class Score : MonoBehaviour
{
	Text time;
	public Text highScore;
	public TextMesh countDownText;

	public static float startTime;
	public static bool startGame;
	public static bool gameFinished;

	public GameObject botaoReplay;
	public GameObject botaoExit;

	void Start ()
	{
		time = GetComponent<Text> ();
		StartCoroutine (CountDown ());
		startTime = 0;
		startGame = false;
		gameFinished = false;

		botaoReplay.SetActive (false);
		botaoExit.SetActive (false);
	}

	IEnumerator CountDown ()
	{
		for (int i = 3; i > 0; i--) {
			countDownText.text = i.ToString (); 
			yield return new WaitForSeconds (1);
		}
		countDownText.color = Color.green;
		countDownText.text = "GO!";
		startGame = true;
		yield return new WaitForSeconds (1);
		countDownText.text = "";
		yield break;
	}

	void Update ()
	{
		if (startGame && !gameFinished)
        {
			startTime += Time.deltaTime;
		    Debug.Log(SwipeDetector.accelarator);

			time.text = "Time: " + FloatToTime (startTime, "#0.0");
			if (startTime > 59)
				time.text = "Time: " + FloatToTime (startTime, "#0:0.0");
		}

        else
        {
			if (SwipeDetector.queimouLargada)
            {
				StopAllCoroutines ();
				time.color = Color.red;
				time.text = "False Start";
				countDownText.text = "";
				ShowButtonsToReplay ();
			}

            else if (gameFinished)
            {
				ShowButtonsToReplay ();
				ShowScore ();
			}
		}
	}

	void ShowButtonsToReplay ()
	{
		botaoReplay.SetActive (true);
		botaoExit.SetActive (true);
	}

    void Boost()
    {
        countDownText.color = Color.green;
        countDownText.text = "Booost!";
    }

	void ShowScore ()
	{
		if (Colisao.isRecord)
        {
			highScore.color = Color.green;
			highScore.text = "New Record: " + FloatToTime (PlayerPrefs.GetFloat (Colisao.key), "#0.0");
		}

        else
			highScore.text = "Best Time: " + FloatToTime (PlayerPrefs.GetFloat (Colisao.key), "#0.0");
	}

	// formata o tempo na tela
	public static string FloatToTime (float toConvert, string format)
	{
		switch (format)
        {
		    case "#0:0.0":
			    return string.Format ("{0:#0}:{1:#0}.{2:0}",
                                     Mathf.Floor (toConvert / 60),//minutes
                                     Mathf.Floor (toConvert) % 60,//seconds
			                         Mathf.Floor ((toConvert * 10) % 10));//miliseconds
			    break;

		    case "#0.0":
			    return string.Format ("{0:#0}.{1:0}", 
			                         Mathf.Floor (toConvert) % 60,//seconds
			                         Mathf.Floor ((toConvert * 10) % 10));//miliseconds
			    break;
		}
		return "error";
	}
}
