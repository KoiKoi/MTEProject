package com.tipyx.games.mteproject.gui;

import com.tipyx.games.mteproject.Settings;
import nme.display.Shape;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import motion.Actuate;

/**
 * ...
 * @author Tipyx
 */
class FadeWhiteScreen extends Shape
{
	private var delay:Float;
	public function new(_delay:Float) 
	{
		super();
		
		this.delay = _delay;
		
		this.graphics.beginFill(0xD3DDB9);
		this.graphics.drawRect(0, 0, Lib.stage.stageWidth, Lib.stage.stageHeight);
		this.alpha = 0;
		
		Actuate.tween(this, this.delay , { alpha : 1 } ).onComplete(animAddEnd);
	}
	
	public function removeScreen() 
	{
		Actuate.tween(this, this.delay, { alpha : 0 } );
	}
	
	private function animAddEnd() 
	{
		dispatchEvent(new Event("animAddEnd"));
	}
	
}