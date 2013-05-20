package com.tipyx.games.mteproject.bgObject;

import com.eclecticdesignstudio.spritesheet.AnimatedSprite;
import com.eclecticdesignstudio.spritesheet.data.BehaviorData;
import com.eclecticdesignstudio.spritesheet.data.SpritesheetFrame;
import com.eclecticdesignstudio.spritesheet.Spritesheet;
import com.tipyx.games.mteproject.gameObject.SkillIcon;
import nme.display.Shape;
import nme.display.Sprite;
import nme.Assets;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.geom.Point;
import nme.Lib;

/**
 * ...
 * @author Tipyx
 */
class TileNormal extends Sprite
{
	private var type:Int;
	private var previousTime:Int;
	
	private var anim:AnimatedSprite;
	private var spritesheet:Spritesheet;
	private var collideBox:Shape;
	private var skill:SkillIcon;

	public function new(_type:Int = 1) 
	{
		super ();
		
		this.type = _type;
		
		var arSpritesheetFrame:Array<SpritesheetFrame> = [];
		
		switch (type) 
		{
			case 0: for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(32 * i, 0, 32, 40, 0, -8));
			
			case 2: for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(32 * (i + 2), 0, 32, 40, 0, -8));
			
			case 4: for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(32 * (i + 4), 0, 32, 40, 0, -8));
				
			default:
				
		}
		
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/tileGround.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normal", [0, 1, 0, 1, 0], true, 2));
		anim.showBehavior("normal");
		addChild(anim);
		
		previousTime = Lib.getTimer ();
		
		collideBox = new Shape();
		collideBox.graphics.beginFill(0xFFFFFF);
		collideBox.graphics.drawRect(0, 0, 32, 32);
		collideBox.alpha = 0;
		addChild(collideBox);
		
		this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
		this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
	}
	
	private function onRollOver(e:MouseEvent):Void {
		collideBox.alpha = 0.5;
	}
	
	private function onRollOut(e:MouseEvent):Void {
		collideBox.alpha = 0;
	}
	
	public function update():Void {
		
		var currentTime = Lib.getTimer ();
		var deltaTime:Int = currentTime - previousTime;
		
		anim.update(deltaTime);
		
		previousTime = currentTime;
		
	}
	
	public function collideY(_heroX:Float, _heroY:Float, _distanceCheck:Float):Bool {
		var pointTemp:Point = globalToLocal(new Point(_heroX, _heroY));
		for (i in 0...Std.int(_distanceCheck)) {
			if (pointTemp.x + i >= collideBox.x && pointTemp.x + i <= collideBox.x + collideBox.width && pointTemp.y > collideBox.y && pointTemp.y < collideBox.y + collideBox.height) return true;
		}
		return false;
	}
	
	public function collideX(_heroX:Float, _heroY:Float, _distanceCheck:Float):Bool {
		var pointTemp:Point = globalToLocal(new Point(_heroX, _heroY));
		for (i in 0...Std.int(_distanceCheck)) {
			if (pointTemp.x >= collideBox.x && pointTemp.x <= collideBox.x + collideBox.width && pointTemp.y - i > collideBox.y && pointTemp.y - i < collideBox.y + collideBox.height) return true;
		}
		return false;
	}
	
	public function setSkillIcon(_type:Int) {
		if (skill != null) {
			removeChild(skill);
			skill = null;
		}
		skill = new SkillIcon(_type);
		addChild(skill);		
		this.setChildIndex(collideBox, this.numChildren - 1);
	}
	
	public function getSkillType():Int {
		if (skill != null) return skill.getType();
		else return -1;
	}
	
}