package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.ui.FlxButton;
import flixel.group.FlxGroup;
import flash.Lib;
import flixel.group.FlxTypedGroup;
import flixel.input.mouse.FlxMouse;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.effects.FlxFlicker;

/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */

class IntroState extends FlxState{

    private var stageWidth:Int = 800;
    private var stageHeight:Int = 480;
    private var creditButton:FlxButton;
    private var timer:flixel.util.FlxTimer;

    override public function create():Void{

        super.create();

        FlxG.camera.flash(FlxColor.RED, .5);
        //FlxG.camera.shake(0.01, 0.25);
        var cameraPosition = FlxG.camera.scroll;

        #if desktop
        FlxG.mouse.visible = true;
        #end 

        var bg = new FlxSprite(0, 0);
        bg.makeGraphic(stageWidth + 100,stageHeight + 100, FlxColor.RED);
        bg.immovable = true;
        add(bg);

 
        creditButton = new FlxButton(137, 195, "", onStart);
        // We add a couple of sprites to the button to act as normal and mouseover states
        creditButton.loadGraphic(Reg.BTN_CREDITS);
        creditButton.x = (stageWidth / 2) - creditButton.width / 2;
        creditButton.y = (stageHeight) - (creditButton.height * 2);
        creditButton.onOver.callback = onStartOver;
        creditButton.onOut.callback = onStartOut;

    
        
        var logo = new FlxSprite(0,0);
        logo.loadGraphic(Reg.LOGO,false,stageWidth,stageHeight);
        
        add(logo);

        

        //add(creditButton);
        
        timer = new FlxTimer(3.0,Timershoot);
        FlxG.sound.play(Reg.INTRO);


    }


    

    private function onStart():Void
    {
        //FlxG.cameras.fade(FlxColor.BLACK, 1, false,  introCall());
        FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {FlxG.switchState(new TitleState());});
        //FlxG.switchState(new TitleState());
        //FlxG.sound.play(Reg.MUSIC_START);
       
    }

    private function onStartOver():Void
    {
        creditButton.loadGraphic(Reg.BTN_CREDITS_OVER);
    }
    
    private function onStartOut():Void
    {
        creditButton.loadGraphic(Reg.BTN_CREDITS);
    }

    override public function update():Void{
        //call super to update the core state class
        super.update();

        #if mobile
            // Simple routine to move bat to x position of touch
            for (touch in FlxG.touches.list){
                if (touch.pressed){
                    onStart();

                     

        

                    //spacePressed = true;
                   // FlxFlicker.stopFlickering(text);
                   
                    
                }
            }
            
        #end



    }

    private function Timershoot(Timer:FlxTimer):Void
    {
        onStart();
        timer.cancel();
        
    }

    override public function destroy():Void{
        //call super to destroy the core state class objects
        super.destroy();
    }

    private function introCall():Void{

        FlxG.switchState(new TitleState());
        FlxG.sound.play(Reg.MUSIC_START);
    }


}