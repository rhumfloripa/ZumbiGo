package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxVelocity;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;
import flixel.util.FlxPath;
import flixel.util.FlxColor;

/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */ 

class Alien extends FlxSprite
{

    private var player:Player;
    private static var speed:Float = 30;
    private static var attackSpeed:Float = 120;
    private static var aceleration:Float = 15;
    private var onRange:Bool;
    private var startPosX:Float;
    public var distanceX:Float;
    public var distanceY:Float;
    private var tween:FlxTween;
    private var currentColor:FlxColor;
    public var readyToDamageAgain:Bool;
    public var haveBeenAttacked:Bool;
   

 
    public function new(X:Float, Y:Float, Health:Float, thePlayer:Player)
    {
        
        super(X,Y);
        player = thePlayer;
        loadGraphic(Reg.ALIEN, true, 64, 40);
        animation.add("sleeping", [1, 2, 2, 2, 2 ], 3, true);
        animation.add("waking", [0, 6, 6, 6, 6, 6], 5, false);
        animation.add("walkingL", [8, 9], 3, true);
        animation.add("walkingR", [10, 11], 3, true);
        animation.add("iWin", [1, 1, 1, 1, 8, 11], 2, true);
        startPosX = this.x;
        velocity.x = speed;
        health = 50;
        readyToDamageAgain = true;
        haveBeenAttacked = false;


    }

   override public function update():Void
    {
        super.update();
        velocity.y += aceleration;
        velocity.x=0;
        
        distanceX = player.x - this.x;
        distanceY = player.y - this.y;
       
        if(distanceX >= -200 && distanceX <= 200 && distanceY > -75 && distanceY < 75 && !haveBeenAttacked == true)
        {
            onRange = true;
        } 
         if(distanceX < -200 || distanceX > 200 || distanceY < -75 || distanceY > 75 )
        {
            onRange = false;
        }
        

        if (onRange == true || haveBeenAttacked == true)
        {
            Attack(); 
        }


        //animation
        if(velocity.x < 0 )
        {
            animation.play("walkingL");
        }
        if(velocity.x > 0)   
        {
            animation.play("walkingR");
        } 

        
        if(!haveBeenAttacked)
        {
            if ( distanceX > 200 && distanceX <300 || distanceX < -200 && distanceX > -300 )
            {
                  animation.play("waking");
            }

            if  (distanceX > 300 || distanceX < -300) 
            {
                animation.play("sleeping");
            }
        }

    }

   
    public function Attack():Void
    {
        if (player.alive == true)
        {
            if (distanceX > 0 )
            {
                velocity.x = attackSpeed;
            }
            if (distanceX < 0 )
            {
                velocity.x = -attackSpeed;
            }
        }
    }


     public function StepBack()
    {
        if(distanceX < 0)
        {
            FlxTween.tween( this, { x:x + 30 }, .5, {complete:ResetAttack});
        }
        if (distanceX > 0)
        {
            FlxTween.tween( this, { x:x - 30 }, .5, {complete:ResetAttack});
        }  
    }

    private function ResetAttack(Tween:FlxTween):Void
    {
        readyToDamageAgain = true;
    }

    

    override public function destroy():Void
    {
        super.destroy();
    }

    public function damage(damage:Float)
    {
        health -= damage;
        tween = FlxTween.color(this, .5, 0xff0000, 16777215, 1, 1);
        if(health <50)
        {
            haveBeenAttacked = true;
        }
    }

    public function isDead():Bool{
        if (health <= 0){
            return true;
        }
        return false;
    }
  
    

}