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

class ArmorUnBox extends FlxSprite
{
 
    public function new(X:Float, Y:Float)
    {
        super(X,Y);
        //active = false;
        loadGraphic(Reg.ARMOR_UNBOX, true, 32, 32);
        animation.add("fly", [0,1,2,3], 5, true);
        animation.play("fly");
    }

    override public function update():Void
    {
        super.update();
    }

    override public function destroy():Void
    {
        super.destroy();
    }
}