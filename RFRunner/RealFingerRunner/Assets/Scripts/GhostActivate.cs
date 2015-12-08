using UnityEngine;
using UnityEngine.UI;


public class GhostActivate : MonoBehaviour {

    public static bool isActive = false;
    public GameObject recordButton;
    public Color color = new Color(1, 1, 255, .75f);

    void Start ()
    {
        ChangeColor(isActive);
    }

    public void SetActive()
    {
        isActive = !isActive;
        ChangeColor(isActive);
    }

    void ChangeColor(bool greenOrGray)
    {
        if (!greenOrGray)
            recordButton.GetComponent<Image>().color = Color.grey; 
        else
            recordButton.GetComponent<Image>().color = Color.green;
    }
}
