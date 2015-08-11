package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxVelocity;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxEmitterExt;

/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */

class Explosion extends FlxSprite
{
    private var ttl:Float;
    private var _explosion:FlxEmitter;
    private var _X:Float;
    private var _Y:Float;
    private var who:String;

    public function new(X:Float, Y:Float, TTL:Float,EXPLODE:FlxEmitter, Who:String)
    {
        super(X,Y);

        _X = X;
        _Y = Y;
        
        // old explosion
        ttl = TTL;
        who = Who;
        /*
        loadGraphic(Reg.EXPLOSION, true, 32, 32, true, "explosion");
        animation.add("explode", [2,1,0], 3, false);
        animation.play("explode");
        FlxG.sound.play(Reg.SND_EXPLOSION);
        */    

        // Add new exlposion emitter
        loadGraphic(Reg.EXPLOSION, true, 32, 32, true, "explosion");
        
        _explosion = EXPLODE;
        _explosion.at(this);
        _explosion.start(true, 2.80);
        FlxG.sound.play(Reg.SND_EXPLOSION);
        //add(_explosion);
    }

    override public function update():Void
    {
        super.update();
        ttl--;
        if (ttl <= 0){
            
            destroy();
        }
    }

    override public function destroy():Void
    {
        super.destroy();
    }
    private function explode(X:Float = 0, Y:Float = 0):Void
    {   
        //if (X == 0 && Y == 0)
        //{
        //    X = FlxG.width / 2;
        //    Y = FlxG.height / 2;
        //}
        if (_explosion != null)
        {
            _explosion.at(this);
            _explosion.start(true, 2.80);
            
        }
        
    }
}