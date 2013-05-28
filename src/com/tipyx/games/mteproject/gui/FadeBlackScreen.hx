package com.tipyx.games.mteproject.gui;

import com.tipyx.games.mteproject.Settings;
import nme.display.Shape;
import nme.display.Sprite;
import nme.Lib;

/**
 * ...
 * @author Tipyx
 */
class FadeBlackScreen extends Shape
{

	public function new() 
	{
		super();
		
		this.graphics.beginFill(0x2B321C);
		this.graphics.drawRect(0, 0, Lib.stage.stageWidth, Lib.stage.stageHeight);
	}
	
}