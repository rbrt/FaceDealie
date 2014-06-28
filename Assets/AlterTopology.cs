using UnityEngine;
using System.Collections;
using System.Linq;

public class AlterTopology : MonoBehaviour {

	public MeshTopology topology;
	
	// Use this for initialization
	void Start () {
		var meshes = GetComponentsInChildren<MeshFilter>();
		
		meshes.ToList().ForEach(mesh =>
		                        mesh.mesh.SetIndices(mesh.mesh.GetIndices(0), topology, 0)
		                        );
	}
	
	void Update () {
		if (topology != GetComponentsInChildren<MeshFilter>()[0].mesh.GetTopology(0)){
			var meshes = GetComponentsInChildren<MeshFilter>();
			meshes.ToList().ForEach(mesh =>
			                        mesh.mesh.SetIndices(mesh.mesh.GetIndices(0), topology, 0)
			                        );
		}
	}
}
