package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxVelocity;
import flixel.util.FlxPoint;
import flixel.tweens.FlxTween;

/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */

class Dragon extends FlxSprite
{
 
    private static var FLY_SPEED:Float = 250;
    public var readyToFly:Bool;
    public var packageWasDelivered:Bool;
    public var packageOnTheRun:Bool;

    public function new(X:Float, Y:Float)
    {
        super(X,Y);

        loadGraphic(Reg.DRAGON, true, 100, 60);

        animation.add("idle", [0], 5, true);
        animation.play("idle");
        immovable = true;
        width = 50;
        height = 30;
        offset.set(30,20);

    }

    
    override public function update():Void
    {
        super.update();
        velocity.y = 0;
     
       if (readyToFly == true)
       {
            move();
       } 
       if (packageWasDelivered == true)
       {
            FlxTween.tween(this, { x:x+100, y:-200 }, 2.0);
       }
    }
    
    public function move():Void
    {
       //FlxTween.tween(this, { x:6700, y:0 }, 3.0);//, { ease: FlxEase.quadInOut});
        if (y > 60 && !packageOnTheRun == true)
        {
            velocity.y = -80;
        }
        
        if (y <= 60)
        {
            packageOnTheRun = true;
        }

        if(packageOnTheRun == true)
        {
            velocity.x = FLY_SPEED;
        }
        
        if (x >= 8326)
        {
            packageOnTheRun=false;
            velocity.x = 0;
           
            if(y < 200)
            {
                velocity.y = 80;
            }
            if (y >= 200)
            {
                packageWasDelivered = true;
            }
        }
    }  

}