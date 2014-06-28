using UnityEngine;
using System.Collections;
using System.Linq;

public class Rotate : MonoBehaviour {

	void Start(){
	
	}
	
	// Update is called once per frame
	void Update () {
		transform.Rotate(new Vector3(0,1,0), .5f);
		
	}
}
