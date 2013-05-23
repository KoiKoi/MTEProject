package com.tipyx.games.mteproject.gui;

import com.eclecticdesignstudio.spritesheet.AnimatedSprite;
import com.eclecticdesignstudio.spritesheet.data.BehaviorData;
import com.eclecticdesignstudio.spritesheet.data.SpritesheetFrame;
import com.eclecticdesignstudio.spritesheet.Spritesheet;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.Assets;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author Tipyx
 */
class TutoMessage extends Sprite
{
	private var type:Int;
	private var previousTime:Int;
	private var anim:AnimatedSprite;
	private var spritesheet:Spritesheet;

	public function new(_type:Int) 
	{
		super ();
		
		this.type = _type;
		
		this.buttonMode = true;
		
		var arSpritesheetFrame:Array<SpritesheetFrame> = [];
		switch (this.type) 
		{
			case 0: arSpritesheetFrame.push(new SpritesheetFrame(0, 0, 329, 77));
			
			case 1: arSpritesheetFrame.push(new SpritesheetFrame(329, 0, 329, 77));
			
			case 2: arSpritesheetFrame.push(new SpritesheetFrame(0, 77, 329, 77));
			
			case 3: arSpritesheetFrame.push(new SpritesheetFrame(329, 77, 329, 77));
			
			case 4: arSpritesheetFrame.push(new SpritesheetFrame(0, 154, 329, 77));
			
			case 5: arSpritesheetFrame.push(new SpritesheetFrame(329, 154, 329, 77));
			
			case 6: arSpritesheetFrame.push(new SpritesheetFrame(0, 231, 329, 77));
			
			case 7: arSpritesheetFrame.push(new SpritesheetFrame(329, 231, 329, 77));
			
			case 8: arSpritesheetFrame.push(new SpritesheetFrame(0, 308, 329, 77));
				
			default:
				
		}
		
		var clickToContinueBD:BitmapData = Assets.getBitmapData("img/clickContinueButton.png");
		var clickToContinue:Bitmap = new Bitmap(clickToContinueBD);
		clickToContinue.x = 82;
		clickToContinue.y = 65;
		
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/tutoMessage.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normal", [0], true, 2));
		anim.showBehavior("normal");
		addChild(anim);
		addChild(clickToContinue);
	}
	
}