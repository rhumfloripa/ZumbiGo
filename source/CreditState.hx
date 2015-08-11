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

import flixel.effects.FlxFlicker;

import extension.admob.AdMob;
import extension.admob.GravityMode;

/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */

class CreditState extends FlxState{

    private var stageWidth:Int = 800;
    private var stageHeight:Int = 480;
    private var creditButton:FlxButton;


    override public function create():Void{

        super.create();

        #if desktop
        FlxG.mouse.visible = true;
        #end 

        var bg = new FlxSprite(0, 0);
        bg.makeGraphic(stageWidth,stageHeight, FlxColor.GREEN);
        bg.immovable = true;
        add(bg);

        AdMob.initAndroid("ca-app-pub-5661718225550185/2249487354","ca-app-pub-5661718225550185/2653113358",  GravityMode.TOP); // may also be GravityMode.TOP
        //AdMob.initIOS("ca-app-pub-5661718225550185/2249487354","ca-app-pub-5661718225550185/3726220553", GravityMode.TOP);





        
        creditButton = new FlxButton(137, 195, "", onStart);
        // We add a couple of sprites to the button to act as normal and mouseover states
        creditButton.loadGraphic(Reg.BTN_CREDITS);
        creditButton.x = (stageWidth / 2) - creditButton.width / 2;
        creditButton.y = (stageHeight / 2) + (creditButton.height * 1.5);
        creditButton.onOver.callback = onStartOver;
        creditButton.onOut.callback = onStartOut;




        


        var auth = new FlxText(320,440,300,"ZumbiGO! 2015",14,false);
        
        add(auth);

        var devText = new FlxText(220,50,400,"Desenvolvedores",35);
        add(devText);
        
        #if mobile 
        var touchText = new FlxText(280,400,400," TOUCH to Return",20);

        add(touchText);
        #end

        var daniel = new FlxSprite(100,150);
        daniel.loadGraphic(Reg.DANIEL,false,120,150);
        add(daniel);

        var dText = new FlxText(120,300,400,"Daniel",20);
        add(dText);

        var felipe = new FlxSprite(260,150);
        felipe.loadGraphic(Reg.FELIPE,false,120,150);
        add(felipe);

        var fText = new FlxText(280,300,400,"Felipe",20);
        add(fText);

        var leandro = new FlxSprite(400,150);
        leandro.loadGraphic(Reg.LEANDRO,false,120,150);
        add(leandro);

        var lText = new FlxText(400,300,400,"Leandro",20);
        add(lText);

        var roger = new FlxSprite(560,150);
        roger.loadGraphic(Reg.ROGER,false,120,150);
        add(roger);

        var rText = new FlxText(580,300,400,"Roger",20);
        add(rText);

        add(creditButton);

        FlxG.sound.play(Reg.MUSIC_START);





       
        
        



    }


    

    private function onStart():Void
    {
        
        AdMob.showInterstitial(0);

        //FlxG.cameras.fade(FlxColor.BLACK, 1, false,  musicFinishedPlaying());
        FlxG.switchState(new TitleState());
        FlxG.sound.play(Reg.MUSIC_START);


       
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

    override public function destroy():Void{
        //call super to destroy the core state class objects
        super.destroy();
    }
}