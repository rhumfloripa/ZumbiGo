package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxVelocity;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxRandom;
import flixel.group.FlxTypedGroup;

/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */

class Boss extends FlxGroup
{
 
    private static var ENEMY_SPEED:Float = 250;
    public var weakSpot:HitSpot;
    public var body:BossBody;
    public var health:Float;
    public var bX:Float;
    private static var player:Player;

    private var bulletArray:FlxTypedGroup<Bullet>;

    public var isMoving:Bool;
    public var lastTimeShot:Float;
    public var distanceX:Float;
    
    private var tween:FlxTween;
    public var color:Int;
    public var whereToShoot:Int;
    public var randomAttack:Int;


    public function new(baseX:Float,X:Float, Y:Float,Health:Float,bossBulletArray:FlxTypedGroup<Bullet>, thePlayer:Player)
    {
        super(10);
        health = Health;
        active = false;
        body = new BossBody(X,Y);
        add(body);
        weakSpot = new HitSpot(X,Y);
        add(weakSpot);
        bulletArray = bossBulletArray;
        player = thePlayer;
        isMoving = false;
        lastTimeShot = 100;
        bX = baseX;
        color = body.color;
        randomAttack = 0;
    }

    override public function update():Void
    {
        super.update();
        if (!isMoving)// && randomAttack != 1)
        {
            var x = bX + FlxRandom.floatRanged(10,480);
            var y = FlxRandom.floatRanged(80,360);
            var speed = FlxRandom.floatRanged(1.5,4.5);
            moveTo(x,y,speed);
        }
        
        if (randomAttack == 10)
        {
            var x = bX + FlxRandom.floatRanged(10,480);
            moveTo(x, player.y, 500);
            AttackRigthTrue();

        }

        lastTimeShot--;
        if (lastTimeShot <= 0)
        {
            lastTimeShot = 100;
            attack();
        }

       

        //animation
        distanceX = body.x - player.x;

        if(distanceX > 0)
        {
           whereToShoot =  FlxObject.LEFT;
        }
        if (distanceX < 0)
        {
            whereToShoot = FlxObject.RIGHT;
        }

        if(health <200 && health > 100)
        {
            
        }
        if (health < 100)
        {
            //body.color = FlxColor.PURPLE;
            body.color = FlxColor.RED;
        }



    }

    public function moveTo(X,Y,SPEED):Void
    {
        if (isMoving)
        {
            return;
        }
        
        isMoving = true;
        FlxTween.linearMotion(body, body.x, body.y, X, Y, SPEED, true, { complete: finishedMoving,type: FlxTween.ONESHOT }); 
        FlxTween.linearMotion(weakSpot, weakSpot.x, weakSpot.y, X, Y, SPEED, true, {  complete: finishedMoving,type: FlxTween.ONESHOT }); 
    }


    private function attack():Void
    {
        var newBullet = new Bullet(body.x+64, body.y+60,500,whereToShoot,20);
        bulletArray.add(newBullet);
        FlxG.sound.play(Reg.SND_BULLET_FIRE);
        body.animation.play("shoot");
    }


    public function finishedMoving(tween:FlxTween):Void
    {
        isMoving = false;
        //var randomAttack = FlxRandom.intRanged(1,15);
        randomAttack++;
        //trace(randomAttack);
    }


    override public function destroy():Void
    {
        super.destroy();
    }


    public function damage(damage:Float)
    {
        health -= damage;
        body.animation.play("hit");
    }


    public function isDead():Bool
    {
        if (health <= 0)
        {
            return true;
        }
        return false;
    }


     public function AttackRigthTrue():Void
     {
        var newBullet0 = new Bullet(body.x+64, body.y+60,500,whereToShoot,20);
        bulletArray.add(newBullet0);
        var newBullet1 = new Bullet(body.x+64, body.y+70,450,whereToShoot,20);
        bulletArray.add(newBullet1);
        var newBullet2 = new Bullet(body.x+64, body.y+50,450,whereToShoot,20);
        bulletArray.add(newBullet2);
        var newBullet3 = new Bullet(body.x+64, body.y+40,400,whereToShoot,20);
        bulletArray.add(newBullet3);
        var newBullet4 = new Bullet(body.x+64, body.y+80,400,whereToShoot,20);
        bulletArray.add(newBullet4);
        FlxG.sound.play(Reg.SND_BULLET_FIRE);
        body.animation.play("shoot");
        randomAttack = 0;
        //FlxTween.tween( body, { x:body.x, y:player.y }, 2, {complete:NowShootMotherF});
        //FlxTween.tween( weakSpot, { x:body.x, y:player.y }, 2, {  complete: finishedMoving,type: FlxTween.ONESHOT }); 
     }

      public function NowShootMotherF(tween:FlxTween):Void
    {
        /*trace("odsofos");
        var newBullet0 = new Bullet(body.x+64, body.y+60,500,whereToShoot,20);
        bulletArray.add(newBullet0);
        var newBullet1 = new Bullet(body.x+64, body.y+70,450,whereToShoot,20);
        bulletArray.add(newBullet1);
        var newBullet2 = new Bullet(body.x+64, body.y+50,450,whereToShoot,20);
        bulletArray.add(newBullet2);
        var newBullet3 = new Bullet(body.x+64, body.y+40,400,whereToShoot,20);
        bulletArray.add(newBullet3);
        var newBullet4 = new Bullet(body.x+64, body.y+80,400,whereToShoot,20);
        bulletArray.add(newBullet4);
        FlxG.sound.play(Reg.SND_BULLET_FIRE);
        body.animation.play("shoot");
        randomAttack = 0;*/
    }
}