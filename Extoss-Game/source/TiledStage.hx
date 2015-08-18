

package;

import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;

/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */

class TiledStage extends TiledMap
{
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image 
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	
	
	// Array of tilemaps used for collision
	public var foregroundTiles:FlxGroup;
	public var backgroundTiles:FlxGroup;
	public var scenarioTiles:FlxGroup;
	public var player:Player;

	//object groups
	
	private var collidableTileLayers:Array<FlxTilemap>;
	
	public function new(tiledLevel:Dynamic, theplayer:Player)
	{
		super(tiledLevel);
		
		foregroundTiles = new FlxGroup();
		backgroundTiles = new FlxGroup();
		scenarioTiles = new FlxGroup();

		


		
		
		FlxG.camera.setBounds(0, 0, fullWidth, fullHeight, true);

	
		// Load Tile Maps
		for (tileLayer in layers)
		{
			var tileSheetName:String = tileLayer.properties.get("tileset");
			
			if (tileSheetName == null)
				throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
				
			var tileSet:TiledTileSet = null;
			for (ts in tilesets)
			{
				if (ts.name == tileSheetName)
				{
					tileSet = ts;
					break;
				}
			}
			
			if (tileSet == null)
				throw "Tileset '" + tileSheetName + " not found. Did you mispell the 'tilesheet' property in " + tileLayer.name + "' layer?";
				
			var imagePath 		= new Path(tileSet.imageSource);
			var processedPath 	= Reg.PATH_TILESHEETS + imagePath.file + "." + imagePath.ext;
			
			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.widthInTiles = width;
			tilemap.heightInTiles = height;
			tilemap.loadMap(tileLayer.tileArray, processedPath, tileSet.tileWidth, tileSet.tileHeight, 0, tileSet.firstGID, 1, 1);
			
			if (tileLayer.name == "bg"){

				backgroundTiles.add(tilemap);	

			}else if (tileLayer.name == "fg"){

				foregroundTiles.add(tilemap);

			}else{	

				if (collidableTileLayers == null)
					collidableTileLayers = new Array<FlxTilemap>();

				if (tileLayer.name == "scenario"){
					scenarioTiles.add(tilemap);
				}
				
				collidableTileLayers.push(tilemap);
			}
		}

		player = theplayer;
	}
	
	public function loadObjects(state:StageState){
		for (group in objectGroups){
			for (o in group.objects){
				loadObject(o, group, state);
			}
		}
	}
	
	private function loadObject(o:TiledObject, g:TiledObjectGroup, state:StageState){
		var x:Int = o.x;	
		var y:Int = o.y;
		
		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1)
			y -= g.map.getGidOwner(o.gid).tileHeight;
		
		switch (o.type.toLowerCase())
		{				
			case "enemy":

				var health:Float = 10;
				var customHealth = o.custom.get("health");
				if (customHealth != null){
					health = Std.parseFloat(customHealth);
				}
				 var enemy = new Enemy(x,y,health, player);
				 if (state.enemies == null){
				 	state.enemies = new FlxTypedGroup<Enemy>();
				 }
				 state.enemies.add(enemy);



			case "coin":

				var coin = new Coin(x,y);
				if (state.coins == null){
					state.coins = new FlxTypedGroup<Coin>();
				}
				state.coins.add(coin);


			case "box_armor":

				var health:Float = 10;
				var customHealth = o.custom.get("health");
				if (customHealth != null){
					health = Std.parseFloat(customHealth);
				}
				var box = new Box(x,y,health);
				if (state.boxes == null){
					state.boxes = new FlxTypedGroup<Box>();
				}
				state.boxes.add(box);
				//trace ("box");


			case "alien":

				var health:Float = 50;
				var customHealth = o.custom.get("health");
				if (customHealth != null){
					health = Std.parseFloat(customHealth);
				}
				var alien = new Alien(x,y,50,player);
				if (state.aliens == null){
					state.aliens = new FlxTypedGroup<Alien>();
				}
				state.aliens.add(alien);
				//trace (health);


			case "minion":

				var health:Float = 20;
				var customHealth = o.custom.get("health");
				if (customHealth != null){
					health = Std.parseFloat(customHealth);
				}
				var minion = new Minion(x,y,health, player);
				if (state.minions == null){
					state.minions = new FlxTypedGroup<Minion>();
				}
				state.minions.add(minion);
				//trace ("box");



			case "block":
				var health:Float = 10;
				var customHealth = o.custom.get("health");
				if (customHealth != null){
					health = Std.parseFloat(customHealth);
				}
				var block = new Block(x,y,health);
				if (state.blocks == null){
					state.blocks = new FlxTypedGroup<Block>();
				}
				state.blocks.add(block);
		}
	}
}