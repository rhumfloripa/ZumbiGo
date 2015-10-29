using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using System.IO;

public class SaveLoad
{
	public static void Save ()
	{
		Game.organize ();
		BinaryFormatter bf = new BinaryFormatter ();
		FileStream file = File.Create (Application.persistentDataPath + "/SaveGame.dataZumbi");
		
		bf.Serialize (file, Game.current);
		file.Close ();
	
	}
	public static void Load ()
	{
	
		if (File.Exists (Application.persistentDataPath + "/SaveGame.dataZumbi")) {
			
			BinaryFormatter bf = new BinaryFormatter ();
			FileStream file = File.Open (Application.persistentDataPath + "/SaveGame.dataZumbi", FileMode.Open);
			Game.current = (Game)bf.Deserialize (file);
			file.Close ();
			
			
			
		} else {
		
			Game.current = new Game ();
		
		}
		
	}
	
}
