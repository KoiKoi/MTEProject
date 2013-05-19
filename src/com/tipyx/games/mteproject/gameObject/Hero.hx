package com.tipyx.games.mteproject.gameObject;

import com.eclecticdesignstudio.spritesheet.AnimatedSprite;
import com.eclecticdesignstudio.spritesheet.data.BehaviorData;
import com.eclecticdesignstudio.spritesheet.data.SpritesheetFrame;
import com.eclecticdesignstudio.spritesheet.Spritesheet;
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
		
		arSpritesheetFrame.push(new SpritesheetFrame(11, 7, 16, 57, -2, -57));
		
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/hero.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normal", [0], true, 2));
		anim.showBehavior("normal");
		addChild(anim);
		
		//anim.update(10);
		
		previousTime = Lib.getTimer ();
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		
	}
	
	private function this_onEnterFrame (event:Event):Void {
		
		var currentTime = Lib.getTimer ();
		var deltaTime:Int = currentTime - previousTime;
		
		anim.update(deltaTime);
		
		previousTime = currentTime;
		
	}
	
}