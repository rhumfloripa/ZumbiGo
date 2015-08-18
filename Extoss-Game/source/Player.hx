package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxVelocity;
import flixel.util.FlxAngle;
import flixel.util.FlxPoint;
import flixel.group.FlxTypedGroup;
import flixel.ui.FlxButton;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.XboxButtonID;
//import flixel.input.touch.FlxTouch;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

import flash.sensors.Accelerometer;
import flash.events.AccelerometerEvent;


/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batistaa
 * Roger Humphreys
 */




class Player extends FlxSprite
{

    private static var SPEED:Float = 200;
    private static var SPEED_AC:Float = 0;
    private static var JUMP:Float = 2500;
    private static var JUMP_AC:Float = 0;
    private static var aceleration:Float = 15; // Set Gravity
    private var originalColor:Int;

    private var runTo:Bool = true; // false = left  -->  true = right
    private var bulletArray:FlxTypedGroup<Bullet>;
    private var stage:TiledStage; 
    
    public var isOnGround:Bool = false; // set Ground
    public var isOnArmor:Bool = false; // set Armor
    public var keyPress:Int = 0;
    public var reload:Float = 150;

    private var check_touch:Bool = true;
    private var damageTimer:FlxTimer;
    private var shootTimer :FlxTimer;
    private var tween:FlxTween;

    //screen
    public static var SCR_WIDTH = 800;
    public static var SCR_HEIGHT = 480;
    
    public var accelerometer:Accelerometer;
    public var check_ac:Bool;


    public function new(X:Float, Y:Float,playerBulletArray:FlxTypedGroup<Bullet>)
    {
        super(X,Y);

        accelerometer = new Accelerometer();

        check_ac = true;
        
        #if mobile
            accelerometer.addEventListener(AccelerometerEvent.UPDATE, updateAccelerometer);
        #end 



        alive = true;

        //playerC = new PlayerCoords(X,Y);

        // Set Ground
        isOnGround == true;
        // Set Animated sprite
        loadGraphic(Reg.PLAYER, true, 64, 70);
        // boy without armor
        animation.add("runR", [ 0, 1, 2, 1], 10, true);
        animation.add("jumpR",[ 4, 5, 6, 9], 7, false);
        animation.add("idleR",[ 9, 10],3,true);
        animation.add("shotR",[ 7, 8],25,false);
        animation.add("runL", [ 21, 21, 23, 22], 7, true);
        animation.add("shotR",[ 7, 8],5,false);
        animation.add("runL", [ 21, 22, 23, 22], 7, true);
        animation.add("jumpL",[ 25, 26, 27, 30], 10, false);
        animation.add("idleL",[ 30, 31],3,true);
        animation.add("shotL",[ 28, 29],25,false);
        animation.add("explode", [14, 15, 16, 17], 5, false);

        // boy with armor
        animation.add("runRarmor", [ 56, 57, 58, 57], 8, true);
        animation.add("jumpRarmor",[ 49, 50, 51, 56], 3, false);
        animation.add("idleRarmor",[ 70, 71],3,true);
        animation.add("shotRarmor",[ 63, 64],25,false);
        animation.add("runLarmor", [ 59, 60, 61, 60], 8, true);
        animation.add("jumpLarmor",[ 52, 53, 54, 60], 3, false);
        animation.add("idleLarmor",[ 72, 73],3,true);
        animation.add("shotLarmor",[ 65, 66],25,false);
        animation.add("explodeArmor", [39, 40, 41, 42, 43], 5, false);

        animation.play("idleR");

        width = 30;
        height = 65;
        offset.set(18,5);
        originalColor = this.color;

        bulletArray = playerBulletArray;
    }

    override public function update():Void
    {      
        velocity.x=0;
        velocity.y += aceleration;

        check_reload ();

        check_ac = true;

        if (this.isTouching(FlxObject.FLOOR))
            {
                isOnGround = true;
            }
       

        if (FlxG.keys.justPressed.BACKSPACE){
                FlxG.switchState(new TitleState());
                
        }


        if (alive){
            //set mobile
           
        #if mobile
            // Simple routine to move bat to x position of touch
            for (touch in FlxG.touches.list)
            {
                
                if (touch.pressed)
                {
                    

                    //right
                    if ((touch.screenX > (SCR_WIDTH / 100) && touch.screenX < (SCR_WIDTH / 100 + 70 ))&&(touch.screenY > (SCR_HEIGHT /10 * 9 -20) && touch.screenY < (SCR_HEIGHT /10 * 9 + 60 -20))){
                        
                        runTo = false;
                        moveLeft();
                        check_ac = false;
                        
                    }

                    //left
                    if ((touch.screenX > (SCR_WIDTH / 100 + 70 + 5) && touch.screenX < (SCR_WIDTH / 100 + 70 + 70))&&(touch.screenY > (SCR_HEIGHT /10 * 9 -20) && touch.screenY < (SCR_HEIGHT /10 * 9 + 60 -20))){
                        
                        runTo = true;
                        moveRight();
                        check_ac = false;
                       
                    }


                    // jump A
                    if ( check_touch){
                        if ((touch.screenX > (SCR_WIDTH - 80 - 75 * 2 ) && touch.screenX < SCR_WIDTH - 85)&&(touch.screenY > (SCR_HEIGHT /10 * 9 -30) && touch.screenY < (SCR_HEIGHT /10 * 9 + 75 - 30))){
                            attack(runTo);
                            check_touch = false;
                           
                            keyPress = 3;
                            if ( reload <= 0 ){
                                 shootTimer = new FlxTimer(1.0,Timershoot);
                            }
                            if ( reload > 0 ){
                                 shootTimer = new FlxTimer(0.2,Timershoot);
                            }

                            if ( reload < -30){
                                reload = -30;
                            }




                        }
                    }



                    
                    //shot B
                    if ((touch.screenX > (SCR_WIDTH - 80) && touch.screenX < SCR_WIDTH - 5)&&(touch.screenY > (SCR_HEIGHT /10 * 8 -30) && touch.screenY < (SCR_HEIGHT /10 * 8 + 75-30))){
                        
                        jump(runTo);
                       
                    }  

                }else{

                    if(isOnArmor){
                        if (runTo){
                            animation.play("idleRarmor");
                        }else{
                            animation.play("idleLarmor"); 
                        }
                    }else{
                        if (runTo){
                            animation.play("idleR");
                        }else{
                            animation.play("idleL"); 
                        }
                    }
                }
                
            }
            
        #end
           

            
            //if(velocity.y == 0 ){
              //  isOnGround = true;
                

            //}

            //set desktop 
        #if desktop
            if (FlxG.keys.justReleased.A || FlxG.keys.justReleased.RIGHT || FlxG.keys.justReleased.LEFT || FlxG.keys.justReleased.SPACE && isOnGround ){
                if(isOnArmor){
                    if (runTo){
                        animation.play("idleRarmor");
                    }else{
                        animation.play("idleLarmor"); 
                    }
                }else{
                    if (runTo){
                        animation.play("idleR");
                    }else{
                        animation.play("idleL"); 
                    }
                }
            }

            
            // to the left...
            if (FlxG.keys.pressed.LEFT){
                runTo = false;
                moveLeft();
                keyPress = 1;
            }
            // to the right...
            if (FlxG.keys.pressed.RIGHT){
                runTo = true; 
                moveRight();
                keyPress = 2;
            }

            //Step it up, step it up, it's alright, yeah!!!!

            if (FlxG.keys.justPressed.A){
               if (reload > 70){
                   check_shooter(); 
                   keyPress = 3;
                }
                attack(runTo);
                
            }

            // set shot and move to right
            if (FlxG.keys.justPressed.A && FlxG.keys.justPressed.RIGHT){
                
                attack(runTo);
                if (reload > 70){
                    
                }
            }
            // set shot and move to left
            if (FlxG.keys.justPressed.A && FlxG.keys.justPressed.LEFT){
                
                attack(runTo);
                if (reload > 70){
                    
                }
            }
            // jump
            if (FlxG.keys.pressed.SPACE){ 

                jump(runTo);
                


            }
            // jump width move right
            if (FlxG.keys.pressed.SPACE && FlxG.keys.justPressed.RIGHT){ 

                jump(runTo);
                


            }
            // jump width move left
            if (FlxG.keys.pressed.SPACE && FlxG.keys.justPressed.LEFT){ 

                jump(runTo);
               


            }
        #end



        }

        //minion.getX(this.x, this.y)

        super.update();
    }

    

    override public function destroy():Void{
        super.destroy();
    }

    public function killPlayer():Void{
        alive = false;
        animation.play("explode");
        FlxG.sound.play(Reg.SND_PLAYER_EXPLODES);
    }

    private function attack(runTo:Bool):Void{

        //set shot to right
       
            
        if(isOnArmor){
            if (runTo){
                animation.play("shotRarmor");
                //trace("SHOT Armor R");
                var newBullet = new Bullet(x + 40, y + 35,500,FlxObject.RIGHT,15);
                bulletArray.add(newBullet);
                FlxG.sound.play(Reg.SND_ROB);
            }else{
                animation.play("shotLarmor"); 
                //trace("SHOT Armor L");
                var newBullet = new Bullet(x - 20, y + 35,500,FlxObject.LEFT,15);
                bulletArray.add(newBullet);
                FlxG.sound.play(Reg.SND_ROB);
            }
         }else{
            if (runTo){
                animation.play("shotR");
                //trace("SHOT R");
                var newBullet = new Bullet(x + 50, y + 35,500,FlxObject.RIGHT,10);
                bulletArray.add(newBullet);
                FlxG.sound.play(Reg.SND_BULLET_FIRE);
            }else{
                animation.play("shotL");
                //trace("SHOT L"); 
                var newBullet = new Bullet(x-10, y + 35,500,FlxObject.LEFT,10);
                bulletArray.add(newBullet);
                FlxG.sound.play(Reg.SND_BULLET_FIRE);
            }

        }
    }
    // to the Right
    private function moveRight():Void{
        if(isOnArmor){
            
            animation.play("runRarmor");
            velocity.x += SPEED;
            if (velocity.x == 0){
                animation.play("idleRarmor");
            }

        }else{

            animation.play("runR");
            velocity.x += SPEED;
            if (velocity.x == 0){
                animation.play("idleR");
            }

        }
    }
    // to the Left
    private function moveLeft():Void{
        if(isOnArmor){
            
            animation.play("runLarmor");
            velocity.x -= SPEED;
            if (velocity.x == 0){
                animation.play("idleLarmor");
            }

        }else{

            animation.play("runL");
            velocity.x -= SPEED;
            if (velocity.x == 0){
                animation.play("idleL");
            }

        }
    }


    
    private function jump(dir:Bool):Void{
        if(isOnArmor){

            if (isOnGround == true && dir == true) {
                animation.play("jumpRarmor");
                velocity.y -= JUMP;
                isOnGround = false;

            }
            if (isOnGround == true && dir == false) {
                animation.play("jumpLarmor");
                velocity.y -= JUMP;
                isOnGround = false;

            }


        }else{

            if (isOnGround == true && dir == true) {
                animation.play("jumpR");
                velocity.y -= JUMP;
                isOnGround = false;

            }
            if (isOnGround == true && dir == false) {
                animation.play("jumpL");
                velocity.y -= JUMP;
                isOnGround = false;

            }

        }    //velocity.y = -maxVelocity.y;
    }


    public function check_reload(){

        if (reload < 150){
            reload += 1;
        }
       
        if ( reload  >= 150){
            reload = 150;
        }

    }

    public function check_shooter(){
        if ( reload > 20 ){
            reload -=30;
         
        }

     
    }

    private function Timershoot(Timer:FlxTimer):Void
    {
        shootTimer.cancel();
        
        #if mobile
                 
            check_touch = true;

          
        #end

    }

    public function Hurt():Void
    {
        tween = FlxTween.color(this, .1, FlxColor.WHITE, originalColor, .2, 1);
        //this.alpha = .25;
        //damageTimer = new FlxTimer(.1, ReturnAlpha);
    }

    private function ReturnAlpha(Timer:FlxTimer):Void
    {
        damageTimer.cancel();
        this.alpha = 1;
    }

    public function updateAccelerometer( evt: AccelerometerEvent){

            SPEED_AC = 0.03* (evt.accelerationY *FlxG.width);
            JUMP_AC =  0.03* (evt.accelerationX *FlxG.height);
            
            if (alive == true && check_ac == true ){
                if (SPEED_AC > 0){
                    this.x += SPEED_AC; 
                    runTo = true;
                    moveRight();     
                }
                if (SPEED_AC < 0){
                    this.x += SPEED_AC;
                    runTo = false;
                    moveLeft();          
                }
                if (JUMP_AC < 3 && isOnGround == true){
                    this.y -= JUMP_AC;
                    jump(runTo);
                    trace (" pulei " + JUMP_AC);
                }
                
            }

            
    }
}