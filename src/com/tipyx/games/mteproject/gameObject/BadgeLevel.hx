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
class BadgeLevels extends Sprite
{
	private var num:Int;
	private var previousTime:Int;
	private var anim:AnimatedSprite;
	private var spritesheet:Spritesheet;

	public function new(_num:Int) 
	{
		super ();
		
		this.num = _num;
		
		var arSpritesheetFrame:Array<SpritesheetFrame> = [];
		if (this.num < 5) arSpritesheetFrame.push(new SpritesheetFrame(78 * num, 0, 78, 78));
		else arSpritesheetFrame.push(new SpritesheetFrame(78 * (this.num - 5), 78, 78, 78));
		
		
		//spritesheet = new Spritesheet(Assets.getBitmapData ("img/skill_icon.png"), arSpritesheetFrame);
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/btn_levels.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normal", [0], true, 2));
		anim.showBehavior("normal");
		addChild(anim);
		
		//anim.update(10);
	}
	
	public function getNum():Int {
		return this.num;
	}
}