package com.tipyx.games.mteproject.bgObject;

import com.eclecticdesignstudio.spritesheet.AnimatedSprite;
import com.eclecticdesignstudio.spritesheet.data.BehaviorData;
import com.eclecticdesignstudio.spritesheet.data.SpritesheetFrame;
import com.eclecticdesignstudio.spritesheet.Spritesheet;
import nme.display.Shape;
import nme.display.Sprite;
import nme.Assets;
import nme.events.Event;
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

	public function new(_type:Int = 1) 
	{
		super ();
		
		this.type = _type;
		
		var arSpritesheetFrame:Array<SpritesheetFrame> = [];
		
		switch (type) 
		{
			case 0: for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(16 * i, 0, 16, 20, 0, -4));
			
			case 2: for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(16 * (i + 2), 0, 16, 20, 0, -4));
			
			case 4: for (i in 0...2) arSpritesheetFrame.push(new SpritesheetFrame(16 * (i + 4), 0, 16, 20, 0, -4));
				
			default:
				
		}
		
		
		spritesheet = new Spritesheet(Assets.getBitmapData ("img/tileGround.png"), arSpritesheetFrame);
		anim = new AnimatedSprite(spritesheet);
		anim.spritesheet.addBehavior(new BehaviorData("normal", [0, 1, 0, 1, 0], true, 2));
		anim.showBehavior("normal");
		addChild(anim);
		
		//anim.update(10);
		
		previousTime = Lib.getTimer ();
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		
		collideBox = new Shape();
		collideBox.graphics.beginFill(0x86B1FB);
		collideBox.graphics.drawRect(0, 0, 16, 16);
		collideBox.alpha = 0;
		addChild(collideBox);
		
	}
	
	private function this_onEnterFrame (event:Event):Void {
		
		var currentTime = Lib.getTimer ();
		var deltaTime:Int = currentTime - previousTime;
		
		anim.update(deltaTime);
		
		previousTime = currentTime;
		
	}
	
	public function collideY(_heroX:Float, _heroY:Float):Bool {
		var pointTemp:Point = globalToLocal(new Point(_heroX, _heroY));
		if (pointTemp.x >= collideBox.x && pointTemp.x <= collideBox.x + collideBox.width && pointTemp.y > collideBox.y && pointTemp.y < collideBox.y + collideBox.height) return true;
		else return false;
	}
	
}