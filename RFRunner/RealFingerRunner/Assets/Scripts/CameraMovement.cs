using UnityEngine;
using System.Collections;

public class CameraMovement : MonoBehaviour {

    public Camera camera;

    void Start ()
    {
        StartCoroutine(Shake());
	}
	
    public IEnumerator Shake()
    {
       // camera.GetComponent<Transform>().transform.position =  Vector3(0, 1, 0);
        yield return new WaitForSeconds(1);
        //camera.GetComponent<Transform>().transform.position =  Vector3(0, camera.y -3, 0);
        yield return new WaitForSeconds(1);


    }

	void Update ()
    {
       // camera.GetComponent<Transform>().transform.position = new Vector3(0, 1, 0);
    }
}
