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
class TileCastle extends Sprite
{
	private var type:Int;
	private var previousTime:Int;
	
	private var anim:AnimatedSprite;
	private var spritesheet:Spritesheet;
	private var collideBox:Shape;
	private var skill:SkillIcon;

	public function new(_type:Int = 0) 
	{
		super ();
		
		this.type = _type;
		
		this.doubleClickEnabled = true;
		this.mouseChildren = false;
		
		var arSpritesheetFrame:Array<SpritesheetFrame> = [];
		
		if (type < 6) for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(32 * (i + this.type), 0, 32, 30, 0, -8));
		else for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(32 * (i + this.type), 0, 32, 40, 0, -8));
		
		//spritesheet = new Spritesheet(Assets.getBitmapData ("img/tileGround.png"), arSpritesheetFrame);
		//spritesheet = new Spritesheet(Assets.getBitmapData ("img/tileGroundV2.png"), arSpritesheetFrame);
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/tileGroundV2-Demi.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normal", [0, 1, 0, 1, 0], true, 2));
		anim.showBehavior("normal"); 
		addChild(anim);
		
		previousTime = Lib.getTimer ();
		
		collideBox = new Shape();
		collideBox.graphics.beginFill(0xFF0000);
		if (type < 6) collideBox.graphics.drawRect(0, 0, 32, 22);
		else collideBox.graphics.drawRect(0, 0, 32, 32);
		collideBox.alpha = 0;
		addChild(collideBox);
		
	}
	
	private function onRollOver(e:MouseEvent):Void {
		collideBox.alpha = 0.5;
		Lib.trace(collideBox.x + " " + collideBox.y + " " + collideBox.width + " " + collideBox.height);
	}
	
	private function onRollOut(e:MouseEvent):Void {
		collideBox.alpha = 0;
	}
	
	public function enableRollOver():Void {
		this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
		this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
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
	
	public function removeSkillIcon() {
		if (skill != null) {
			removeChild(skill);
			skill = null;			
		}
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
	
	public function getWidth():Float {
		return this.collideBox.width;
	}
	
	public function getHeight():Float {
		return this.collideBox.height;
	}
	
}