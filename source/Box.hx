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

class Box extends FlxSprite
{
    public var canGet:Bool;
 
    public function new(X:Float, Y:Float,Health:Float)
    {
        super(X,Y);
        active = true;
        health = Health;
        setBox();
        immovable = false;
        canGet = false;
    }

    override public function update():Void
    {
        super.update();
        velocity.y = 50;
    }

    override public function destroy():Void
    {
        super.destroy();
    }

    private function setBox(){

        loadGraphic(Reg.BOXARMOR, true, 32, 32);
        animation.add("box", [5], 5, true);
        animation.add("armor",[10,11,12,13], 5, true);

        animation.play("box");

    }

    public function setArmor(){

        animation.play("armor");
        canGet =  true;

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