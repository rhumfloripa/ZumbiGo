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

class Minion extends FlxSprite
{

    private var player:Player;
    private var speed:Float = 100;
    private var attackSpeed:Float = 150;
    private var aceleration:Float = 15;
    private var onRange:Bool;
    private var startPosX:Float;
    private var startPosY:Float;
    public var distanceX:Float;
    public var distanceY:Float;
    public var isOnGround:Bool;
    public var firstAttack:Bool;
    private static var jump:Float = 325;
    public var damageTimer:FlxTimer;
    private static var minionColor:Int;
    public var readyToDamageAgain:Bool;

 
    public function new(X:Float, Y:Float, Health:Float, thePlayer:Player)
    {
        
        super(X,Y);
        player = thePlayer;
        loadGraphic(Reg.MINION, true, 21, 32);
        animation.add("idle", [0, 1, 2, 3, 2], 5, true);
        animation.add("walkingL", [4, 5, 6, 5], 3, true);
        animation.add("walkingR", [7, 8, 9, 8], 3, true);
        animation.add("sad", [10, 11, 12, 13, 14], 3, true);
        startPosX = this.x;
        startPosY = this.y;
        velocity.x = speed;
        health = Health;
        minionColor = this.color;
        readyToDamageAgain = true;

    }

    override public function update():Void
    {
        
        velocity.y += aceleration;
        
       
        if(firstAttack == true)
        {
            velocity.x = 0;
        }


        if(velocity.y ==15)
        {
            isOnGround = true;
        } 

        distanceX = player.x - this.x;
        distanceY = player.y - this.y;
       
        if(distanceX >= -200 && distanceX <= 200 && distanceY > -75 && distanceY < 75)// && distanceY >= -70 && distanceY <= 70)// && player.y == y)
        {
            onRange = true;
            firstAttack = true;
        } 
         if(distanceX < -200 || distanceX > 200 || distanceY < -70 || distanceY > 70 )//|| distanceY < -70 || distanceY > 70)//|| distanceY > 10 || distanceY < -10)
        {
            onRange = false;
        }



        if (onRange == false)
        {
            Move(); 
        }
        if (onRange == true)
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
        else if (velocity.x == 0) 
        {
            animation.play("sad");
        }
        super.update();
 
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
            if (isOnGround == true)
            {
                Jump();
            }
        }
    }

    
    public function Move():Void
    {

        if(x < startPosX - 40)
        {
            velocity.x = -velocity.x;
            new FlxTimer(2.0, 3);
        }
        if (x > startPosX + 40)
        {
            velocity.x = -velocity.x;
        }
       
    } 

    public function StepBack()
    {
        if(distanceX < 0)
        {
            FlxTween.tween( this, { x:x + 40 }, 1.2, {complete:ResetAttack});
        }
        if (distanceX > 0)
        {
            FlxTween.tween( this, { x:x - 40 }, 1.2, {complete:ResetAttack});
        }  
    }

    private function ResetAttack(Tween:FlxTween):Void
    {
        readyToDamageAgain = true;
    }

    

    public function waitForSecs()
    {
        FlxRandom.floatRanged(0.5,3.5);
    }

    public function Jump()
    {
        isOnGround = false;
        velocity.y -= jump;
    }


    override public function destroy():Void
    {
        super.destroy();
    }

    public function damage(damage:Float)
    {
        health -= damage;
        this.color = FlxColor.HOT_PINK;
        damageTimer = new FlxTimer(.1, timerOver);
    }

    public function isDead():Bool{
        if (health <= 0){
            return true;
        }
        return false;
    }

    private function timerOver(Timer:FlxTimer):Void
    {
        damageTimer.cancel();
        this.color = minionColor;
    }
        
  
    

}