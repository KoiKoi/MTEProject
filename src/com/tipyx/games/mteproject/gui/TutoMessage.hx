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
		
		if (this.type % 2 == 0) arSpritesheetFrame.push(new SpritesheetFrame(0, 77 * Std.int(this.type / 2), 329, 77));
		else arSpritesheetFrame.push(new SpritesheetFrame(329, 77 * Std.int(this.type / 2), 329, 77));
		
		spritesheet = new Spritesheet(Assets.getBitmapData("img/tutoMessage.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normal", [0], true, 2));
		anim.showBehavior("normal");
		addChild(anim);
		
		var clickToContinueBD:BitmapData = Assets.getBitmapData("img/clickContinueButton.png");
		var clickToContinue:Bitmap = new Bitmap(clickToContinueBD);
		clickToContinue.x = 82;
		clickToContinue.y = 65;
		
		addChild(clickToContinue);
	}
	
}