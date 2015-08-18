package;

import flixel.util.FlxSave;

/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */


class Reg
{
	//Sprites

	public static inline var BG:String = "assets/images/sprite/bg.png";
	public static inline var BG1:String = "assets/images/sprite/background.png";
	//public static inline var BG2:String = "assets/images/sprite/background2.png";
	public static inline var BG2:String = "assets/images/sprite/skyalpha.png";
	public static inline var LOGO:String = "assets/images/sprite/intro.png";
	public static inline var MINION:String = "assets/images/sprite/EnemyMinion21wX32.png";
	public static inline var ALIEN:String = "assets/images/sprite/enemyB_64X40px.png";
	public static inline var PLAYER:String = "assets/images/sprite/new_boy_W_armor_64X70px.png";
	public static inline var BOSS:String = "assets/images/sprite/newBoss_128X90px.png";
	public static inline var BULLET:String = "assets/images/sprite/blue_bullet.png";
	public static inline var ENEMY:String = "assets/images/sprite/pacEnemy.png";
	public static inline var COIN:String = "assets/images/sprite/prisma4.png";
	public static inline var BLOCK:String = "assets/images/sprite/block.png";
	public static inline var EXPLOSION:String = "assets/images/sprite/explosion.png";
	public static inline var EXPLOSION_ENEMY:String = "assets/images/sprite/explosion_particles.png";
	public static inline var EXPLOSION_MINIONS:String = "assets/images/sprite/particles_minions.png";
	public static inline var EXPLOSION_BLOCK:String = "assets/images/sprite/particles_blocks.png";
	public static inline var EXPLOSION_BOX:String = "assets/images/sprite/particles_box.png";
	public static inline var EXPLOSION_BOSS:String = "assets/images/sprite/particles_boss.png";
	public static inline var EXPLOSION_ALIEN:String = "assets/images/sprite/particles_alien.png";
	public static inline var TITLE_PRISMA = "assets/images/sprite/logo_extoss_prisma_animado.png";
	public static inline var TITLE_LOGO:String = "assets/images/sprite/logo_extoss.png";
	public static inline var DRAGON:String = "assets/images/sprite/dragon.png";
	public static inline var BOXARMOR:String = "assets/images/sprite/boxes.png";
	public static inline var BTN_CREDITS:String = "assets/images/sprite/btn_credits.png";
	public static inline var BTN_CREDITS_OVER:String = "assets/images/sprite/btn_credits_over.png";
	public static inline var BTN_EXIT:String = "assets/images/sprite/btn_exitA.png";
	public static inline var BTN_EXIT_OVER:String = "assets/images/sprite/btn_exitO.png";
	public static inline var ARMOR_UNBOX:String = "assets/images/sprite/armor_unbox.png";
	public static inline var BTN_LEFT:String = "assets/images/sprite/buttonLeft.png";
	public static inline var BTN_RIGHT:String = "assets/images/sprite/buttonRight.png";
	public static inline var BTN_A:String = "assets/images/sprite/button_A.png";
	public static inline var BTN_SPACE:String = "assets/images/sprite/button_B.png";
	public static inline var BTN_RESET:String = "assets/images/sprite/button_back.png";	

	//Sounds
	public static inline var SND_EXPLOSION:String = "assets/sounds/fx/explosion.wav";	
	public static inline var SND_PLAYER_EXPLODES:String = "assets/sounds/fx/player_explodes.wav";	
	public static inline var SND_BULLET_HIT:String = "assets/sounds/fx/bullet_hit.wav";
	public static inline var SND_BULLET_HIT2:String = "assets/sounds/fx/bullet_hit2.wav";		
	public static inline var SND_BULLET_FIRE:String = "assets/sounds/fx/bullet_fire.wav";
	public static inline var SND_BLOCK_DESTROYED:String = "assets/sounds/fx/block_destroyed.wav";
	public static inline var COIN_COLLECT:String = "assets/sounds/fx/coin_collect.wav";
	public static inline var SND_ROB:String = "assets/sounds/fx/rob_hit.ogg";


	//Music
	public static inline var MUSIC_START:String = "assets/music/start.ogg";
	public static inline var MUSIC1:String = "assets/music/beg.ogg";
	public static inline var MUSIC2:String = "assets/music/stage1.ogg";
	public static inline var MUSIC3:String = "assets/music/boss.ogg";
	public static inline var INTRO:String = "assets/music/introJingle.ogg";


	//Sprite Dev
	public static inline var DANIEL:String = "assets/images/sprite/daniel.png";
	public static inline var FELIPE:String = "assets/images/sprite/felipe.png";
	public static inline var LEANDRO:String = "assets/images/sprite/leandro.png";
	public static inline var ROGER:String = "assets/images/sprite/roger.png";





    //Map
	public static inline var PATH_TILESHEETS:String = "assets/images/map/";

	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
}