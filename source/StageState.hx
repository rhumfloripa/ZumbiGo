package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.util.FlxTimer;
import flixel.effects.FlxFlicker;
import flixel.FlxCamera;
import flixel.effects.particles.FlxEmitter;
import flixel.addons.display.FlxBackdrop;
import openfl.system.System;
import flixel.ui.FlxButton;

import extension.admob.AdMob;
import extension.admob.GravityMode;


/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */




//import openfl.system.System;
//import openfl.display.FPS;


class StageState extends FlxState
{

    //counter
   // public var counter:Number = 0;

	//bullets
	public var playerBullets:FlxTypedGroup<Bullet>;

	//buttons for Mobile

	public var btnLeft:FlxSprite;
	public var btnRight:FlxSprite;
	public var btnA:FlxSprite;
	public var btnSpace:FlxSprite;
	public var attackTimer:FlxTimer;

	public var btnEnd:FlxButton;

	//enemies
	public var enemies:FlxTypedGroup<Enemy>;
	public var enemyBullets:FlxTypedGroup<Bullet>;
	private var _explosion:FlxEmitter;
	private var _explosion_Minions:FlxEmitter;
	private var _explosion_Boss:FlxEmitter;
	private var _explosion_Box:FlxEmitter;
	private var _explosion_Block:FlxEmitter;
	private var _explosion_Diveros:FlxEmitter;
	private var _explosion_Alien:FlxEmitter;

	


	//prism
	public var coins:FlxTypedGroup<Coin>;

	//box
	public var boxes:FlxTypedGroup<Box>;
	//public var boxArmor:FlxSprite;

	//boss
	public var BOSS_HEALTH:Float = 500;
	public var boss:Boss = null;

	//blocks
	public var blocks:FlxTypedGroup<Block>;

	//screen
	public static var SCR_WIDTH = 800;
	public static var SCR_HEIGHT = 480;
	public var screenPositionX:Float = 0;
	public var screenSpeed:Float = 0;
	public var scroll:Bool = true;

	//player
	public var player:Player;
    public var life_player: Int = 200;
    
    //check prism
    public var check_prism:Int = 0;
    public var prisma:FlxSprite;
    public var prisma_barr:FlxText;

    public var spirit:Spirit;

	//score
	public var score:Float;
	public var scoreText:FlxText;

	//score_bullet
	public var score_bullet:FlxSprite;
	public var damage_bullet:FlxSprite;
	public var damage_score:Int = 50;
	public var bullet_txt:FlxText;
	
	// score life
	public var score_life:FlxSprite;
	public var damage_life:FlxSprite;
	public var damage_collision:Int = 300;
	public var life_txt:FlxText;

	public var attack:Int;

	//bg
	public var bg:FlxSprite;
	//public var bg1:FlxSprite;
	//public var fg:FlxSprite;

	//stage
	private var stage:TiledStage;
	var levelName:String = "stage";
	//var levelName:String = "bossTest";

	//dragon
	public var dragon:Dragon;

	//minion
	public var minion:Minion;
	public var minions:FlxTypedGroup<Minion>;

	public var alien:Alien;
	public var aliens:FlxTypedGroup<Alien>;


	private var check_alive:Bool = true;

	//music
	var musicTimer:FlxTimer;

    //timer stagecompleted
	var stageTimer:FlxTimer;

	//timer timergameOver
	var gameOverTimer:FlxTimer;


	var gameOver:Bool = false;
	var stageCompleted:Bool = false;

	
	
	override public function create():Void
	{
		super.create();

		//AdMob.enableTestingAds();

		AdMob.initAndroid("ca-app-pub-9527771404408649/4405944415","ca-app-pub-9527771404408649/2929211210",  GravityMode.TOP); // may al/so be GravityMode.TOP
        //AdMob.initIOS("ca-app-pub-5661718225550185/2249487354","ca-app-pub-5661718225550185/3726220553", GravityMode.TOP);

		

		FlxG.fixedTimestep = true;

		#if desktop
		FlxG.mouse.visible = false;
		#end

		bg = new FlxSprite(0,0);
		bg.loadGraphic(Reg.BG,false,640,480);

		// Parallax Scrolling
		var bg1:FlxBackdrop = new FlxBackdrop(Reg.BG1, 1/16, 0, true, false);
        var fg:FlxBackdrop = new FlxBackdrop(Reg.BG2, 1/8, 0, true, false);
 
        
        add(bg1);
        add(fg);       
		

		playerBullets = new FlxTypedGroup<Bullet>();

		player = new Player(50,200,playerBullets);
		player.maxVelocity.y = 400;
		player.acceleration.y = 400;

		stage = new TiledStage("assets/data/stage/" + levelName + ".tmx", player);

		//adds stage tiles
		boxes = new FlxTypedGroup<Box>();

		blocks = new FlxTypedGroup<Block>();
		
		enemyBullets = new FlxTypedGroup<Bullet>();
		
		enemies = new FlxTypedGroup<Enemy>();
		
		minions = new FlxTypedGroup<Minion>();
		
		aliens = new FlxTypedGroup<Alien>();

		// Set up the explosions
		// Enimies
		_explosion = new FlxEmitter();
		_explosion.setXSpeed( -150, 150);
		_explosion.setYSpeed( -200, 0);
		_explosion.setRotation( -720, 720);
		_explosion.gravity = 600;
		_explosion.makeParticles(Reg.EXPLOSION_ENEMY, 32, 16, true, .5);
		
		//Minions
		_explosion_Minions = new FlxEmitter();
		_explosion_Minions.setXSpeed( -150, 150);
		_explosion_Minions.setYSpeed( -200, 0);
		_explosion_Minions.setRotation( -720, 720);
		_explosion_Minions.gravity = 600;
		_explosion_Minions.makeParticles(Reg.EXPLOSION_MINIONS, 32, 16, true, .5);
		

		//Blocks
		_explosion_Block = new FlxEmitter();
		_explosion_Block.setXSpeed( -150, 150);
		_explosion_Block.setYSpeed( -200, 0);
		_explosion_Block.setRotation( -720, 720);
		_explosion_Block.gravity = 600;
		_explosion_Block.makeParticles(Reg.EXPLOSION_BLOCK, 32, 32, true, .5);
		

		//Box
		_explosion_Box = new FlxEmitter();
		_explosion_Box.setXSpeed( -150, 150);
		_explosion_Box.setYSpeed( -200, 0);
		_explosion_Box.setRotation( -720, 720);
		_explosion_Box.gravity = 600;
		_explosion_Box.makeParticles(Reg.EXPLOSION_BOX, 32, 16, true, .5);
		

		//Box
		_explosion_Boss = new FlxEmitter();
		_explosion_Boss.setXSpeed( -150, 150);
		_explosion_Boss.setYSpeed( -200, 0);
		_explosion_Boss.setRotation( -720, 720);
		_explosion_Boss.gravity = 600;
		_explosion_Boss.makeParticles(Reg.EXPLOSION_BOSS, 64, 32, true, .5);
		

		//alienadd(_explosion_Block);
		_explosion_Alien = new FlxEmitter();
		_explosion_Alien.setXSpeed( -150, 150);
		_explosion_Alien.setYSpeed( -200, 0);
		_explosion_Alien.setRotation( -720, 720);
		_explosion_Alien.gravity = 600;
		_explosion_Alien.makeParticles(Reg.EXPLOSION_ALIEN, 64, 32, true, 2);
		
		coins = new FlxTypedGroup<Coin>();
		
		
		// add all in stage
		add(stage.scenarioTiles);
		add(boxes);		
		add(blocks);
		add(playerBullets);
		add(enemyBullets);		
		add(enemies);
		add(minions);
		add(aliens);
		add(_explosion);
		add(_explosion_Box);
		add(_explosion_Block);
		add(_explosion_Boss);
		add(_explosion_Alien);
		add(_explosion_Minions);
		add(coins);
		add(player);

		dragon = new Dragon (3525, 200);
		add (dragon);

		//minion = new Minion (1535, 300, 300, player);
		//add(minion);

		//alien = new Alien (2250, 300, player);
		//add (alien);


		//loads stage objects
		stage.loadObjects(this);

		//score
		score = 0;
		scoreText = new FlxText(250,70,200,"Score: " + score,20,false);
		add(scoreText);

        //score bullet
        score_bullet = new FlxSprite(500, 50);
		score_bullet.makeGraphic(150, 20, FlxColor.RED);
		score_bullet.immovable = true;
		add(score_bullet);

		bullet_txt = new FlxText(500,70,200,"Bullet" ,20,false);
		add(bullet_txt);

		damage_bullet = new FlxSprite(500, 50);
		damage_bullet.immovable = true;
		add(damage_bullet);

		life_txt = new FlxText(50,70,200,"Life" ,20,false);
		add(life_txt);

		// score life
		score_life = new FlxSprite(50, 50);
		score_life.makeGraphic(300, 20, FlxColor.RED);
		score_life.immovable = true;
		add(score_life);

		damage_life = new FlxSprite(50, 50);		
		damage_life.immovable = true;
		add(damage_life);

		prisma = new FlxSprite(700,50);
        prisma.loadGraphic(Reg.COIN,true,18,30);
        prisma.animation.add("run",[0,1,2,3], 15, true);
        prisma.animation.play("run");
        add(prisma);

        prisma_barr = new FlxText(720,50,200," X " + check_prism,20,false);
		add(prisma_barr);

        /*boxArmor = new FlxSprite(700,5);
        boxArmor.loadGraphic(Reg.BOXARMOR,true,18,30);
        boxArmor.animation.add("run",[0,1,2,3], 15, true);
        boxArmor.animation.play("run");
        add(boxArmor);
		*/
		#if mobile
			btnLeft = new FlxSprite(SCR_WIDTH / 100 , SCR_HEIGHT /10 * 9-20);
			btnLeft.loadGraphic(Reg.BTN_LEFT, true, 70, 60);
			btnLeft.alpha = 0.5;
			
			add(btnLeft);
			
			btnRight = new FlxSprite(SCR_WIDTH / 100 + btnLeft.width + 5,SCR_HEIGHT /10 * 9-20);
			btnRight.loadGraphic(Reg.BTN_RIGHT, true, 70, 60);
			btnRight.alpha = 0.5;
			add(btnRight);

			btnSpace = new FlxSprite(SCR_WIDTH - 80,SCR_HEIGHT /10 * 8 -30);
			btnSpace.loadGraphic(Reg.BTN_SPACE, true, 75, 75);
			btnSpace.alpha = 0.5;
			add(btnSpace);

			btnA = new FlxSprite(SCR_WIDTH - btnSpace.width * 2 - 5 ,SCR_HEIGHT /10 * 9 -30);
			btnA.loadGraphic(Reg.BTN_A, true, 75, 75);
			btnA.alpha = 0.5;
			add(btnA);

			

			
			btnEnd = new FlxButton(SCR_WIDTH -60, 90, "", onStart);
			btnEnd.loadGraphic(Reg.BTN_RESET, true, 60, 40);
			//btnEnd.alpha = 0.5;
			add(btnEnd);


		    //function init admob
		    showbanner();  
        

		
		#end



       


		FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN, 1);
		

		//starts playing music
		FlxG.sound.playMusic(Reg.MUSIC1,1,false);
		//sets up timer so when music1 is done we start playing music2
		musicTimer = new FlxTimer(31.0, playMusic2);

		//DEBUG
		FlxG.debugger.visible = false;

		//var fps:FPS = new FPS(10, 100, 0xffffff);
		//add(fps);

		//vida = new FlxText(260,430,300," Lifes  :   " + life_player ,14,false);
		//add(vida);
	}
	

	private function playMusic2(Timer:FlxTimer):Void
	{
		musicTimer.cancel();
		FlxG.sound.playMusic(Reg.MUSIC2,1,true);
	}


	private function playBossMusic():Void
	{
		FlxG.sound.playMusic(Reg.MUSIC3,1,true);
	}


	override public function destroy():Void
	{
		super.destroy();
	}


	override public function update():Void
	{
		if (FlxG.keys.pressed.HOME){
                System.exit(0);
		
        }
		
            
        // Test input to scroll the camera. FlxBackdrop will
        // handle the parallax scrolling automatically.
        //if (FlxG.keys.pressed.LEFT) FlxG.camera.scroll.add(-5, 0);
        //if (FlxG.keys.pressed.RIGHT) FlxG.camera.scroll.add(5, 0);   
		
        check_damage();

        check_shot();

        check_touch();

 
		if (boss != null)
		{
			boss.update();
		}

		if (gameOver || stageCompleted)
		{
			if (FlxG.keys.pressed.R)
			{

                #if mobile
                  // Simple routine to move bat to x position of touch
                  	for (touch in FlxG.touches.list){
                    	if (touch.pressed){
                        onStart();

                    //spacePressed = true;
                   // FlxFlicker.stopFlickering(text);
                     	}
            		}
            
            	#end



				FlxG.sound.destroy(true);
				FlxG.switchState(new TitleState());
			}
		}

		damage_life.makeGraphic(damage_collision, 20, FlxColor.GREEN);
		damage_bullet.makeGraphic(damage_score, 20, FlxColor.GREEN);

		//everyt hing on screen must move at screen speed
		var cameraPosition = FlxG.camera.scroll;
		scoreText.scrollFactor.set(0, 0);
		score_bullet.scrollFactor.set(0, 0);
		damage_bullet.scrollFactor.set(0, 0);
		score_life.scrollFactor.set(0, 0);
		damage_life.scrollFactor.set(0, 0);
		life_txt.scrollFactor.set(0, 0);
		bullet_txt.scrollFactor.set(0, 0);
		prisma.scrollFactor.set(0, 0);
		prisma_barr.scrollFactor.set(0, 0);

		#if mobile
			btnLeft.scrollFactor.set(0, 0);
			btnRight.scrollFactor.set(0, 0);
			btnA.scrollFactor.set(0,0);
			btnSpace.scrollFactor.set(0, 0);

			btnEnd.scrollFactor.set(0,0);
		#end

		// Call BIG BOSS to FIGHT!!!	dletar
		if (scroll){

			//trace ( "scroll  " + cameraPosition.x);

			if (cameraPosition.x + SCR_WIDTH + 64 >= stage.fullWidth)
			{
				scroll = false;     
			}			
		}

		//creates boss when player reaches stage's end
		if (boss == null && !scroll && !gameOver && !stageCompleted){
			playBossMusic();
			boss = new Boss(cameraPosition.x, cameraPosition.x + 400, 200, BOSS_HEALTH,enemyBullets, player);
			add(boss);

		}

		//updates enemies
		//if enemy is inside bounds and not yet activated we turn it on
		for (e in enemies)
		{  
			if (!e.active && isInsideOfBounds(e))
			{
				e.active = true;
			}else{
					e.active = false;
			}
			// destroy enemies after exit of the stage
			if(e.x < cameraPosition.x - 32){
				e.destroy();				

			}

		}


		// Coins
		for (e in coins)
		{
			if (!e.active && isInsideOfBounds(e))
			{
				e.active = true;
			}else{
					e.active = false;
				 }
		}



		//updates player
			//inside of bounds
		if (player.x > cameraPosition.x + SCR_WIDTH-32){
			player.x = cameraPosition.x + SCR_WIDTH-32;	
		}
		if (player.x < cameraPosition.x){
			player.x = cameraPosition.x;
		}
		if (player.y > cameraPosition.y + SCR_HEIGHT-32){
			player.y = cameraPosition.y + SCR_HEIGHT-32;	
		}
		if (player.y < cameraPosition.y){
			player.y = cameraPosition.y;
		}


		//collides blocks with stage
		FlxG.overlap(stage.scenarioTiles,blocks,null,FlxObject.separate);

		//collides bullets with blocks
		FlxG.overlap(playerBullets,blocks,null,overlapped);
	
		// collides bullets with boxes
		FlxG.overlap(playerBullets,boxes,null,overlapped);
		

		//collides blocks with blocks
		FlxG.overlap(blocks,blocks,null,FlxObject.separate);

		//collides player with stage
		FlxG.overlap(stage.scenarioTiles, player, null, FlxObject.separate);

		//collides playerBullets with scenario
		FlxG.collide(stage.scenarioTiles,playerBullets,null);

		//collides playerBullets with enemies
		FlxG.overlap(playerBullets,enemies,null,overlapped);

		//collides player with prisma
		FlxG.overlap(player, coins, null, overlapped);

		//collides player with armor
		FlxG.overlap(player, boxes, null, overlapped);
		//FlxG.collide(player, boxes);
		

		FlxG.overlap(blocks, player, null, FlxObject.separate);

		FlxG.overlap(player, dragon, null, overlapped);
		if(dragon.packageWasDelivered != true)
		{
			FlxG.collide(player, dragon, null); 
		}
		
		// explosion collides
		FlxG.collide(_explosion, stage.scenarioTiles, null);
		FlxG.collide(_explosion_Block, stage.scenarioTiles, null);
		FlxG.collide(_explosion_Box, stage.scenarioTiles, null);
		FlxG.collide(_explosion_Boss, stage.scenarioTiles, null);
		FlxG.collide(_explosion_Minions, stage.scenarioTiles, null);
		FlxG.collide(_explosion_Alien, stage.scenarioTiles, null);

		FlxG.collide(aliens, stage.scenarioTiles, null);
		FlxG.collide(minions, stage.scenarioTiles, null);

		FlxG.overlap(playerBullets, minions, null, overlapped);
		FlxG.overlap(playerBullets, aliens, null, overlapped);
		FlxG.overlap(stage.scenarioTiles, alien, null, FlxObject.separate);
		FlxG.overlap(stage.scenarioTiles, minion, null, FlxObject.separate);
		FlxG.collide(boxes, stage.scenarioTiles);
		FlxG.collide(boxes, blocks);
		FlxG.collide(minions, stage.scenarioTiles);





		
		//updates boss
		if (boss != null){
			FlxG.overlap(playerBullets,boss,null,overlapped);	
			FlxG.overlap(boss,player,null,overlapped); 
		}

		//player bullet update
		for (pb in playerBullets){
			//position
			pb.x += screenSpeed;

			//destroyed?
			if (pb.isTouching(FlxObject.ANY) || (pb.x > (cameraPosition.x + SCR_WIDTH))){
				playerBullets.remove(pb);
				pb.destroy();
			}
		}

		//enemy bullet update
		for (eb in enemyBullets){

			//destroyed?
			if (eb.isTouching(FlxObject.ANY) || (eb.x < cameraPosition.x)){
				enemyBullets.remove(eb);
				eb.destroy();
			}
		}

		//player collision
		if (player.alive)
		{
			FlxG.overlap(enemyBullets, player, null, overlapped);
			FlxG.overlap (enemies, player, null, overlapped);
			FlxG.collide(player, minions, overlapped);
			FlxG.collide(player, aliens, overlapped);
		}

		super.update();
		
	}	


	private function overlapped(Sprite1:FlxObject, Sprite2:FlxObject):Bool
	{
		var sprite1ClassName:String = Type.getClassName(Type.getClass(Sprite1));
		var sprite2ClassName:String = Type.getClassName(Type.getClass(Sprite2));

		if (sprite1ClassName == "Bullet" && sprite2ClassName == "Enemy")
		{
			var b: Dynamic = cast(Sprite1,Bullet);
			var e: Dynamic = cast(Sprite2,Enemy);

			//damages enemy
			e.damage(b.damage);
			FlxG.sound.play(Reg.SND_BULLET_HIT);
			
			if (e.isDead())
			{
				enemies.remove(e);
				Sprite2.destroy();
				score +=10;
				scoreText.text = "Score: " + score;

				//creates explosion at enemy position
				var e = new Explosion(e.x,e.y,50,_explosion, "Enemy");
				add(e);
			}

			//destroys bullet
			playerBullets.remove(b);
			Sprite1.destroy();

			return true;
		}

		if (sprite1ClassName == "Bullet" && sprite2ClassName == "Alien")
		{
			var bullet: Dynamic = cast(Sprite1,Bullet);
			var _alien: Dynamic = cast(Sprite2,Alien);

			
			//_alien.damage(50);
			_alien.damage(bullet.damage);
			if (_alien.isDead())
			{	
				
				Sprite2.destroy();
				score +=100;
				scoreText.text = "Score: " + score;
				var e = new Explosion(_alien.x,_alien.y,50,_explosion_Alien, "Alien");
				add(e);

			}
			playerBullets.remove(bullet);
			Sprite1.destroy();
			
			return true;			
		}

		if (sprite1ClassName == "Bullet" && sprite2ClassName == "Minion")
		{
			var bullet: Dynamic = cast(Sprite1,Bullet);
			var _minion: Dynamic = cast(Sprite2,Minion);

			
			//_minion.damage(50);
			_minion.damage(bullet.damage);
			if (_minion.isDead())
			{
				
				Sprite2.destroy();
				score +=100;
				scoreText.text = "Score: " + score;
				var e = new Explosion(_minion.x,_minion.y,50,_explosion_Minions, "Minion");
				add(e);
				

			}
			playerBullets.remove(bullet);
			Sprite1.destroy();
			return true;			
		}

		//get prisma

		if (sprite1ClassName == "Player" && sprite2ClassName == "Coin")
		{
			var b: Dynamic = cast(Sprite1,Player);
			var e: Dynamic = cast(Sprite2,Coin);

			FlxG.sound.play(Reg.COIN_COLLECT);
			
			coins.remove(e);
			Sprite2.destroy();
			score +=100;
			check_prism +=1;
			prisma_barr.text = " X " + check_prism;
			scoreText.text = "Score: " + score;

			if(damage_collision >= 280){
				damage_collision = 300;
			}
			else{
				damage_collision +=20;
			}
			
			return true;			
		}

		if (sprite1ClassName == "Player" && sprite2ClassName == "Box")
		{
			var b: Dynamic = cast(Sprite1,Player);
			var box: Dynamic = cast(Sprite2,Box);

			if (box.active && box.canGet == true){
				FlxG.sound.play(Reg.SND_ROB);
				
				boxes.remove(box);
				Sprite2.destroy();
				score +=100;
				player.isOnArmor = true;
				scoreText.text = "Score: " + score;
			}
			
			return true;			
		}

		if (sprite1ClassName == "Player" && sprite2ClassName == "Dragon")
		{
			var b: Dynamic = cast(Sprite1,Player);
			var e: Dynamic = cast(Sprite2,Dragon);
			dragon.readyToFly = true;
			return true;
		}

		if (sprite1ClassName == "Player" && sprite2ClassName == "Minion")
		{
			var b: Dynamic = cast(Sprite1,Player);
			var minion: Dynamic = cast(Sprite2,Minion);
			
			if(minion.readyToDamageAgain == true)
			{
				minion.readyToDamageAgain = false;
				
				if(damage_collision <= 30)
				{
					damage_collision -= damage_collision;
					GameOver();
				}
				else{
					damage_collision -=30;
					//attackTimer = new FlxTimer(.1, CanAttack);
				}
				minion.StepBack();
				player.Hurt();
			}
		}


		if (sprite1ClassName == "Player" && sprite2ClassName == "Alien")
		{
			var b: Dynamic = cast(Sprite1,Player);
			var alien: Dynamic = cast(Sprite2,Alien);
			
			if(alien.readyToDamageAgain == true)
			{
				alien.readyToDamageAgain = false;
				
				if(damage_collision <= 50)
				{
					damage_collision -= damage_collision;
					GameOver();
					alien.animation.play("iWin");
				}
				else{
					damage_collision -=50;
				}

				alien.StepBack();
				player.Hurt();
			}
		}




	
			
		
		if (sprite1ClassName == "Bullet" && sprite2ClassName == "Box")
		{
			//FlxG.sound.play(Reg.SND_BULLET_HIT);
			var bullet: Dynamic = cast(Sprite1,Bullet);
			var box: Dynamic = cast(Sprite2,Box);
			
			//Sprite2.destroy();
			score +=50;
			scoreText.text = "Score: " + score;
			box.damage(bullet.damage);
			bullet.destroy();

			if (box.isDestroyed())
			{
				//boxes.remove(box);
				
				//FlxG.sound.play				(Reg.SND_BLOCK_DESTROYED);

				//creates explosion at block position
				var e = new Explosion(box.x,box.y,50,_explosion_Box, "Box");
				add(e);
				//box.destroy();
				box.setArmor();
				//add(box.setArmor());
				//var b = new ArmorUnBox(box.x,box.y);
				//add(b);
			}

	       // check_prism += 1;
	        //trace ( " prism " + check_prism);
	        //prisma_barr.text = " X   " + check_prism;
			return true;
		}
		

		if (sprite1ClassName == "Bullet" && sprite2ClassName == "Block"){

			var bullet: Dynamic = cast(Sprite1,Bullet);
			var block: Dynamic = cast(Sprite2,Block);

			//Sprite2.destroy();
			score +=50;
			scoreText.text = "Score: " + score;

			//damages enemy
			block.damage(bullet.damage);
			//FlxG.sound.play(Reg.SND_BULLET_HIT2);
			bullet.destroy();
			if (block.isDestroyed())
			{
				blocks.remove(block);
				
				//FlxG.sound.play				(Reg.SND_BLOCK_DESTROYED);

				//creates explosion at block position
				var e = new Explosion(block.x,block.y,50,_explosion_Block, "Block");
				add(e);
				block.destroy();
				block.isOnGround = false;
				//trace(block.isOnGround);
			}

			//destroys bullet
			playerBullets.remove(bullet);
			

			return true;
		}

		if ((sprite1ClassName == "Enemy" || sprite1ClassName == "Block" || sprite1ClassName == "BossBody" 
			|| sprite1ClassName == "Bullet") && sprite2ClassName == "Player")
		{

			if (player.alive)
			{
				
				if ( sprite1ClassName  != "Block" && sprite2ClassName == "Player")
			    {

					if ( damage_collision == 1)
	                {	
	                	GameOver(); 
	                }
	      
	                damage_collision -= 1;
	                player.Hurt();			
			    }
		    }
		    return true;
		}


		if (sprite1ClassName == "Bullet" && sprite2ClassName == "BossBody")
		{
			var bullet: Dynamic = cast(Sprite1,Bullet);
			//destroys bullet
			playerBullets.remove(bullet);
			bullet.destroy();
		}


		if (sprite1ClassName == "Bullet" && sprite2ClassName == "HitSpot") //"HitSpot"
		{
			var bullet: Dynamic = cast(Sprite1,Bullet);
			boss.damage(bullet.damage);
			//this create the flicks
			FlxFlicker.flicker(boss.body,0.2,0.04,true,false,null,null);
			FlxG.sound.play(Reg.SND_BULLET_HIT);
			playerBullets.remove(bullet);
			bullet.destroy();
			
			if (boss.isDead())
			{
				//creates explosions at boss position
				var e = new Explosion(boss.body.x,boss.body.y,50,_explosion_Boss, "Boss");
				add(e);
				
				boss.destroy();
				boss = null;

				FlxG.sound.play(Reg.SND_EXPLOSION);

				stageCompletedFun();
			}
 		}
		return false;
	}



	private function GameOver():Void
	{		
	   
	    FlxG.camera.flash(FlxColor.BLACK, .5);
		FlxG.camera.shake(0.01, 0.25);
		var cameraPosition = FlxG.camera.scroll;
	    
	    player.killPlayer();
	    spirit = new Spirit(player.x, player.y, player) ;
	    add(spirit);
		
		gameOver = true;

		
		

		var gameOverText = new FlxText(cameraPosition.x + 320,150,300,"GAME OVER",30);
		    add(gameOverText);

	    #if mobile

	        
                 
		    var touchText = new FlxText(cameraPosition.x + 320,230,400," Touch for REPLAY",20);
		   
		    add(touchText);
               
        #end

        #if desktop 

          		    
		    var pressSpaceText = new FlxText(cameraPosition.x + 250,220,400," Press R for REPLAY",30);
		    add(pressSpaceText);


		#end 

		gameOverTimer = new FlxTimer(3.0,TimerGameOver);      
	}


	private function stageCompletedFun()
	{
        
       

        stageCompleted = true;
        var cameraPosition = FlxG.camera.scroll;

        var stageCompletedText = new FlxText(cameraPosition.x + 250,150,400,"STAGE COMPLETED!",30);
		add(stageCompletedText);

        #if mobile
            
		    var pressSpaceText = new FlxText(cameraPosition.x + 250,280,400,"Touch for REPLAY",20);
		    add(pressSpaceText);

                    //spacePressed = true;      
        #end

        #if !mobile
		
			var pressSpaceText = new FlxText(cameraPosition.x + 250,220,400,"Press R for REPLAY",20);
			add(pressSpaceText);

		#end 

		stageTimer = new FlxTimer(3.0,TimerStageCompleted);
	}


    private function TimerStageCompleted(Timer:FlxTimer):Void
	{
		AdMob.showInterstitial(0);

		stageTimer.cancel();

		#if mobile
                 
		    check_alive = false;

          
        #end		
	}


	 private function TimerGameOver(Timer:FlxTimer):Void
	{
		
		AdMob.showInterstitial(0);

		gameOverTimer.cancel();


		
		#if mobile
                 
		    check_alive = false;
  
        #end
    }


	private function isInsideOfBounds(sprite:FlxSprite):Bool
	{
		var cameraPosition = FlxG.camera.scroll;

		if (sprite.x > cameraPosition.x + SCR_WIDTH+32){
			return false;
		}
		if (sprite.x < cameraPosition.x-32){
			return false;
		}
		if (sprite.y + sprite.height > cameraPosition.y + SCR_HEIGHT){
			return false;
		}
		if (sprite.y < cameraPosition.y){
			return false;
		}
		return true;
	}

	private function check_touch (){


		if ( check_alive == false ){ 

		    for (touch in FlxG.touches.list){
               if (touch.pressed){
                
                onStart();
                check_alive = true;
                

               } 
                
            }         
	    }
	} 


	private function check_damage ()
	{
        if ( damage_score < 150)
        {
	        damage_score += 1;
	    }

	    if ( damage_score >= 150)
        {
        	damage_score = 150;
	    }  	    
	}


	private function check_shot ()
	{
        if (player.keyPress == 3)
        {

	        player.keyPress = 0;

	        if ( damage_score > 30)
	        {
				damage_score -= 30;				              
			}
				 //player.reload = damage_score;

		    if ( damage_score  < 20)
	        {
	         	damage_score = 10; 
		    }	 
	   }
	 } 

	private function onStart():Void
    {
        //FlxG.cameras.fade(FlxColor.BLACK, 1, false,  musicFinishedPlaying());
        FlxG.switchState(new TitleState());
        FlxG.sound.play(Reg.MUSIC_START);

        //function destroy banner
        destroybanner();

        
       
    }

     function showbanner() {
        // some implementation
        AdMob.showBanner(); // this will show the AdMob banner.
    }

    function destroybanner() {
        // some implementation
        AdMob.hideBanner(); // if you don't want the banner to be on screen while playing... call AdMob.hideBanner();
    }
            

}