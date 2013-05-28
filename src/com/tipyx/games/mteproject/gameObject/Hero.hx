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
	 * 3 : Jump Left
	 * 4 : Jump Right
	 */

	public function new() 
	{
		super ();
		
		
		var arSpritesheetFrame:Array<SpritesheetFrame> = [];
		
		// Normal Right
		arSpritesheetFrame.push(new SpritesheetFrame(0, 0, 14, 60, 0, -60));
		
		// Hidden
		arSpritesheetFrame.push(new SpritesheetFrame(15, 0, 14, 60, 0, -60));
		
		// Walk Right
		arSpritesheetFrame.push(new SpritesheetFrame(30, 0, 14, 60, 0, -60));
		arSpritesheetFrame.push(new SpritesheetFrame(45, 0, 19, 60, 0, -60));
		arSpritesheetFrame.push(new SpritesheetFrame(65, 0, 19, 60, 0, -60));
		arSpritesheetFrame.push(new SpritesheetFrame(85, 0, 18, 60, 0, -60));
		arSpritesheetFrame.push(new SpritesheetFrame(104, 0, 14, 60, 0, -60));
		arSpritesheetFrame.push(new SpritesheetFrame(119, 0, 15, 60, 0, -60));
		
		// Walk Left
		arSpritesheetFrame.push(new SpritesheetFrame(135, 0, 15, 60, -1, -60));
		arSpritesheetFrame.push(new SpritesheetFrame(151, 0, 14, 60, -1, -60));
		arSpritesheetFrame.push(new SpritesheetFrame(166, 0, 18, 60, -3, -60));
		arSpritesheetFrame.push(new SpritesheetFrame(185, 0, 19, 60, -3, -60));
		arSpritesheetFrame.push(new SpritesheetFrame(205, 0, 19, 60, -2, -60));
		arSpritesheetFrame.push(new SpritesheetFrame(225, 0, 14, 60, 0, -60));
		
		// Normal Left
		arSpritesheetFrame.push(new SpritesheetFrame(241, 0, 14, 60, 0, -60));
		
		//spritesheet = new Spritesheet(Assets.getBitmapData ("img/hero.png"), arSpritesheetFrame);
		//spritesheet = new Spritesheet(Assets.getBitmapData ("img/heroV2.png"), arSpritesheetFrame);
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/heroV3.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normalRight", [0], true, 2));
		anim.spritesheet.addBehavior(new BehaviorData("normalLeft", [14], true, 2));
		anim.spritesheet.addBehavior(new BehaviorData("hidden", [1], true, 2));
		anim.spritesheet.addBehavior(new BehaviorData("walkRight", [2,3,4,5,6,7,2], true , 15));
		anim.spritesheet.addBehavior(new BehaviorData("walkLeft", [13,12,11,10,9,8,13], true, 15));
		addChild(anim);
		showHidden();
		
		collideBox = new Shape();
		collideBox.graphics.beginFill(0xFF0000);
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
		update();
	}
	
	public function showNormal():Void {
		if(anim.currentBehavior.name == "walkRight" || anim.currentBehavior.name == "hidden") anim.showBehavior("normalRight");
		else if(anim.currentBehavior.name == "walkLeft") anim.showBehavior("normalLeft");
		update();
	}
	
	public function showWalk(_reverse:Bool = false):Void {
		if (!_reverse && anim.currentBehavior.name != "walkRight") anim.showBehavior("walkRight");
		else if (_reverse && anim.currentBehavior.name != "walkLeft") anim.showBehavior("walkLeft");
		update();
	}
	
}