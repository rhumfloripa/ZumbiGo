package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxVelocity;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;

/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */

class Block extends FlxSprite
{
    //private static var GRAVITY:Int = 50;

    private var aceleration:Float=20;
    private var isOnGround:Bool = true;



    public function new(X:Float, Y:Float,Health:Float)
    {
        super(X,Y);
        health = Health;
        loadGraphic(Reg.BLOCK, true, 32, 32, true, "block");
        immovable = false;
    }

    override public function update():Void
    {
        super.update();
        //velocity.y = GRAVITY ; 
        check_isOnGround();       
    }

    public function check_isOnGround(){
        if (isOnGround){
            immovable=true;
        }else{
            immovable=false;
            velocity.y += aceleration;

        }


    } 

    override public function destroy():Void
    {
        super.destroy();
    }

    public function damage(damage:Float){
        health -= damage;
    }

    public function isDestroyed():Bool{
        if (health <= 0){
            return true;
        }
        return false;
    }

}