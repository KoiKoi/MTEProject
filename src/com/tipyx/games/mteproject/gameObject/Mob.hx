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
class Mob extends Sprite
{
	private var previousTime:Int;
	private var direction:String = "left";
	
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
		
		arSpritesheetFrame.push(new SpritesheetFrame(1, 3, 30, 29, 0, -29));
		arSpritesheetFrame.push(new SpritesheetFrame(34, 3, 30, 29, 0, -29));
		
		arSpritesheetFrame.push(new SpritesheetFrame(97, 3, 30, 29, 0, -29));
		arSpritesheetFrame.push(new SpritesheetFrame(65, 3, 30, 29, 0, -29));
		
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/mob1.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normalLeft", [0,1], true, 10));
		anim.spritesheet.addBehavior(new BehaviorData("normalRight", [2,3], true, 10));
		addChild(anim);
		anim.showBehavior("normalLeft");
	}
	
	public function update():Void {
		
		var currentTime = Lib.getTimer ();
		var deltaTime:Int = currentTime - previousTime;
		
		anim.update(deltaTime);
		
		previousTime = currentTime;
	}
	
	public function goLeft() {
		this.direction = "left";
		anim.showBehavior("normalLeft");
		update();
	}
	
	public function goRight() {
		this.direction = "right";
		anim.showBehavior("normalRight");
		update();
	}
	
	public function getDirection():String {
		return this.direction;
	}
}