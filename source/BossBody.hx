package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxVelocity;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
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

class BossBody extends FlxSprite
{

    public function new(X:Float, Y:Float)
    {
        super(X,Y);
        loadGraphic(Reg.BOSS, true, 128, 90);
        animation.add("moveL", [9, 9, 9, 9, 3], 5, true);
        animation.add("moveR", [11, 11, 11, 11, 3], 5, true);
        animation.add("hit", [2, 3, 4, 4, 3, 2, 1, 8], 10, false);
        animation.add("shoot", [4, 5, 5, 6, 6, 6, 8], 10, false);
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