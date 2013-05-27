package com.tipyx.games.mteproject.bgObject;

import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.Assets;

/**
 * ...
 * @author Tipyx
 */
class ExitSign extends Sprite
{

	public function new() 
	{
		super();
		
		var exitSigneBD:BitmapData = Assets.getBitmapData("img/sign.png");
		var exitSign:Bitmap = new Bitmap(exitSigneBD);
		
		exitSign.x = -exitSign.width / 2;
		exitSign.y = -exitSign.height;
		addChild(exitSign);
	}
	
}