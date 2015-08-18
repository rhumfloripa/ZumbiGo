package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.effects.FlxFlicker;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxColor;
import flash.Lib;
import flixel.group.FlxTypedGroup;
import flixel.input.mouse.FlxMouse;
import openfl.system.System;

/*
 * Copyright (c) 2015 SENAI ZumbiGo!
 *
 * Developers:
 * Daniel Andrade 
 * Felipe Fetzer
 * Leandro Batista
 * Roger Humphreys
 */



class TitleState extends FlxState
{

	private var emitter:FlxEmitter;
	private var whitePixel:FlxParticle;
	private var text:FlxText;
	private var spacePressed:Bool;
	private var stageWidth:Int = 800;
	private var stageHeight:Int = 480;
	private var creditButton:FlxButton;
	private var exit_Button:FlxButton;
	private var bt_exit:FlxText;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		spacePressed = false;
		
		#if desktop
		FlxG.mouse.visible = true;
		#end
		//star emmiter
		
		emitter = new FlxEmitter(320, 200, 300);
		emitter.setXSpeed(-300, 300);
		emitter.setYSpeed( -100, 100);
		add(emitter);

		
        
		for (i in 0...(Std.int(emitter.maxSize / 2))) 
		{
			whitePixel = new FlxParticle();
			whitePixel.makeGraphic(2, 2, FlxColor.WHITE);
			// Make sure the particle doesn't show up at (0, 0)
			whitePixel.visible = false; 
			emitter.add(whitePixel);
			whitePixel = new FlxParticle();
			whitePixel.makeGraphic(1, 1, FlxColor.WHITE);
			whitePixel.visible = false;
			emitter.add(whitePixel);
		}

		
		emitter.start(false, 10, .01);

		var title = new FlxSprite(10,90);
		title.loadGraphic(Reg.TITLE_LOGO,true,616,131);
		title.x = stageWidth/2 - title.width/2;
		
        
        add(title);

        var prisma = new FlxSprite(265,100);
        prisma.loadGraphic(Reg.TITLE_PRISMA,true,100,100);
        prisma.x = (stageWidth/2) - (prisma.width/2);

        prisma.animation.add("run",[0,1,2,3,4], 15,true);
        prisma.animation.play("run");

        add(prisma);

        creditButton = new FlxButton(137, 195, "", onStart);
		// We add a couple of sprites to the button to act as normal and mouseover states
		creditButton.loadGraphic(Reg.BTN_CREDITS);
		creditButton.x = (stageWidth / 2) - creditButton.width / 2;
		creditButton.y = (stageHeight) - (creditButton.height * 2);
		creditButton.onOver.callback = onStartOver;
		creditButton.onOut.callback = onStartOut;
		add(creditButton);

	    #if mobile

		text = new FlxText(180,230,400,"Touch to play!",20,false);
		text.x = (stageWidth/2) - 100;
		add(text);

		//exit_Button = new FlxButton(0, 0, "", onExit);
		// We add a couple of sprites to the button to act as normal and mouseover states
		//exit_Button.loadGraphic(Reg.BTN_EXIT);
		//exit_Button.x = (stageWidth / 2) - exit_Button.width / 2;
		//exit_Button.y = (stageHeight) - (exit_Button.height *4);
		//exit_Button.onOver.callback = onExitOver;
		//exit_Button.onOut.callback = onExitOut;
		//add(exit_Button);
		#end 

		#if !mobile

		text = new FlxText(180,230,400,"Press Space to play!",20,false);
		text.x = (stageWidth/2) - 120;
		add(text);


        
		bt_exit = new FlxText(180,275,400,"Press Home to Exit!",20,false);
		bt_exit.x = (stageWidth/2) - 120;
		add(bt_exit);
		FlxFlicker.flicker(bt_exit, 0, 0.5, false, false, null, null);
		#end 

		var auth = new FlxText(260,450,300,"ZumbiGO! 2015",14,false);
		auth.x = (stageWidth/2) - 60;

		add(auth);

		FlxFlicker.flicker(text, 0, 0.5, false, false, null, null);
		
	}

	private function onStart():Void
	{
		//FlxG.cameras.fade(FlxColor.BLACK, 1, false,  musicFinishedPlaying());
		FlxG.switchState(new CreditState());
	}

	private function onExit():Void
	{
		//FlxG.cameras.fade(FlxColor.BLACK, 1, false,  musicFinishedPlaying());
		//FlxG.switchState(new CreditState());
		System.exit(0);
	}

	private function onStartOver():Void
	{
		creditButton.loadGraphic(Reg.BTN_CREDITS_OVER);
	}
	
	private function onStartOut():Void
	{
		creditButton.loadGraphic(Reg.BTN_CREDITS);
	}
	
	private function onExitOver():Void
	{
		exit_Button.loadGraphic(Reg.BTN_EXIT_OVER);
	}
	
	private function onExitOut():Void
	{
		exit_Button.loadGraphic(Reg.BTN_EXIT);
	}

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();

		
		#if mobile
            // Simple routine to move bat to x position of touch
            for (touch in FlxG.touches.list){
                if (touch.justReleased){

                    spacePressed = true;
					FlxFlicker.stopFlickering(text);
					FlxG.sound.play(Reg.MUSIC_START,1,false,false,musicFinishedPlaying);
                    
                }
            }
            
         #end

        //set desktop 
        #if !FLX_NO_KEYBOARD
           
		if (FlxG.keys.justPressed.SPACE && !spacePressed){
			spacePressed = true;
			FlxFlicker.stopFlickering(text);
			FlxG.sound.play(Reg.MUSIC_START,1,false,false,musicFinishedPlaying);
		}

		if (FlxG.keys.pressed.HOME){

				FlxFlicker.stopFlickering(text);
                System.exit(0);
		
        }
		#end
	}	

	private function musicFinishedPlaying():Void{
		FlxG.switchState(new StageState());
	}
}