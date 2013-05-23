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
class SkillIcon extends Sprite
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
		arSpritesheetFrame.push(new SpritesheetFrame(32 * type, 0, 32, 32));
		
		//arSpritesheetFrame.push(new SpritesheetFrame(11, 7, 16, 57, -2, -57));
		
		//spritesheet = new Spritesheet(Assets.getBitmapData ("img/skill_icon.png"), arSpritesheetFrame);
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/skill_iconV2.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normal", [0], true, 2));
		anim.showBehavior("normal");
		addChild(anim);
		
		//anim.update(10);
	}
	
	public function getType():Int {
		return this.type;
	}
}