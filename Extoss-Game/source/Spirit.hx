package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxPoint;
import flixel.tweens.FlxTween;
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

class Spirit extends FlxSprite
{
    private var player:Player;
    private var tween:FlxTween;
 


    public function new(X:Float, Y:Float, thePlayer:Player)
    {
        super(X,Y);
        player = thePlayer;

        loadGraphic(Reg.PLAYER, true, 64, 70);
        animation.add("oin", [0], 5, false);
        animation.play("oin");
        this.color = FlxColor.CYAN;
        this.alpha = .35;


    }

    
    override public function update():Void
    {
        FlxTween.tween(this, { x:x+35, y:-200 }, 8.0, {complete:DestroyObj});
    }
    
   
    private function DestroyObj(Tween:FlxTween):Void
    {
        super.destroy();
    }
}