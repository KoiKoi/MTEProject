package com.tipyx.games.mteproject.gui;

import com.eclecticdesignstudio.spritesheet.AnimatedSprite;
import com.eclecticdesignstudio.spritesheet.data.BehaviorData;
import com.eclecticdesignstudio.spritesheet.data.SpritesheetFrame;
import com.eclecticdesignstudio.spritesheet.Spritesheet;
import nme.display.Sprite;
import nme.Assets;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Lib;

/**
 * ...
 * @author Tipyx
 */
class BtnIG extends Sprite
{
	private var type:Int;
	private var previousTime:Int;
	private var anim:AnimatedSprite;
	private var spritesheet:Spritesheet;

	public function new(_type:Int) 
	{
		super ();
		
		this.type = _type;
		
		var arSpritesheetFrame:Array<SpritesheetFrame> = [];
		arSpritesheetFrame.push(new SpritesheetFrame(32 * type, 0, 32, 32, -16, -16));
		
		//arSpritesheetFrame.push(new SpritesheetFrame(11, 7, 16, 57, -2, -57));
		
		//spritesheet = new Spritesheet(Assets.getBitmapData ("img/btn_IG.png"), arSpritesheetFrame);
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/btn_IGV2.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normal", [0], true, 2));
		anim.showBehavior("normal");
		addChild(anim);
		
		this.addEventListener(MouseEvent.ROLL_OVER, onRollOverButton);
		this.addEventListener(MouseEvent.ROLL_OUT, onRollOutButton);
	}
	
	private function onRollOverButton(e:MouseEvent):Void {
		this.scaleX = this.scaleY = 1.1;
	}
	
	private function onRollOutButton(e:MouseEvent):Void {
		this.scaleX = this.scaleY = 1;		
	}
	
}