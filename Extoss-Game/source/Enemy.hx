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

class Enemy extends FlxSprite
{
 
    private static var ENEMY_SPEED:Float = 250;
    private var player:Player;
    public var distanceX:Float;
    public var distanceY:Float;


    public function new(X:Float, Y:Float, Health:Float, thePlayer:Player)
    {
        super(X,Y);
        health = Health;
        player = thePlayer;
        active = false;
        loadGraphic(Reg.ENEMY, true, 20, 20);
        animation.add("fly", [0, 0, 0, 0, 1], 25, true);
        animation.add("attack", [0, 1, 2, 3, 4, 3, 2], 35, true);
        animation.play("fly");
    }

    override public function update():Void
    {
        super.update();
        velocity.x = 0;
        if (active)
        {
            velocity.x = -ENEMY_SPEED;
        }
        distanceX = player.x - this.x;
        distanceY = player.y - this.y;

        if(distanceX > -200 && distanceX < 75 && distanceY < 50 && distanceY >-50)
        {
            animation.play("attack");
        }
        else{
            animation.play("fly");
        }
    }

    override public function destroy():Void
    {
        super.destroy();
    }

    public function damage(damage:Float){
        health -= damage;
    }

    public function isDead():Bool{
        if (health <= 0){
            return true;
        }
        return false;
    }
}