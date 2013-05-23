package com.tipyx.games.mteproject.gameObject;

import com.eclecticdesignstudio.spritesheet.AnimatedSprite;
import com.eclecticdesignstudio.spritesheet.data.BehaviorData;
import com.eclecticdesignstudio.spritesheet.data.SpritesheetFrame;
import com.eclecticdesignstudio.spritesheet.Spritesheet;
import nme.display.Shape;
import nme.display.Sprite;
import nme.Assets;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author Tipyx
 */
class Hero extends Sprite
{
	private var previousTime:Int;
	
	private var anim:AnimatedSprite;
	private var spritesheet:Spritesheet;
	private var collideBox:Shape;
	
	/*
	 * Skill Type :
	 * 0 : Jump
	 * 1 : Left
	 * 2 : Right
	 */

	public function new() 
	{
		super ();
		
		var arSpritesheetFrame:Array<SpritesheetFrame> = [];
		
		//switch (type) 
		//{
			//case 0: for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(16 * i, 0, 16, 20, 0, -4));
			//
			//case 2: for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(16 * (i + 2), 0, 16, 20, 0, -4));
			//
			//case 4: for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(16 * (i + 4), 0, 16, 20, 0, -4));
				//
			//default:
				//
		//}
		
		arSpritesheetFrame.push(new SpritesheetFrame(11, 7, 14, 57, 0, -57));
		arSpritesheetFrame.push(new SpritesheetFrame(43, 7, 14, 57, 0, -57));
		
		//spritesheet = new Spritesheet(Assets.getBitmapData ("img/hero.png"), arSpritesheetFrame);
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/heroV2.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normal", [0], true, 2));
		anim.spritesheet.addBehavior(new BehaviorData("hidden", [1], true, 2));
		addChild(anim);
		showHidden();
		
		collideBox = new Shape();
		collideBox.graphics.beginFill(0xFFFFFF);
		collideBox.graphics.drawRect(0, -57, 14, 57);
		collideBox.alpha = 0;
		addChild(collideBox);
		
	}
	
	public function update():Void {
		
		var currentTime = Lib.getTimer ();
		var deltaTime:Int = currentTime - previousTime;
		
		anim.update(deltaTime);
		
		previousTime = currentTime;
	}
	
	public function showHidden():Void {
		anim.showBehavior("hidden");
	}
	
	public function showNormal():Void {
		anim.showBehavior("normal");
	}
	
}