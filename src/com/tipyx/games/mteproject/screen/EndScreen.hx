package com.tipyx.games.mteproject.screen;

import com.tipyx.games.mteproject.Settings;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Assets;

/**
 * ...
 * @author Tipyx
 */
class EndScreen extends Sprite
{

	public function new() {
		super ();
		
		var endScreenBD:BitmapData = Assets.getBitmapData("img/EndScreen.png");
		var endScreen:Bitmap = new Bitmap(endScreenBD);
		addChild(endScreen);
		
		this.addEventListener(MouseEvent.CLICK, onClick);
	}
	
	private function onClick(e:MouseEvent):Void {
		Settings.NEXT_LEVEL = 1;
		dispatchEvent(new Event("gotoHome"));
	}
	
}