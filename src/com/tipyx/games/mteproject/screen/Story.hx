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
class Story extends Sprite
{

	public function new() 
	{
		super ();
		var storyBD:BitmapData = Assets.getBitmapData("img/storyScreen.png");
		var story:Bitmap = new Bitmap(storyBD);
		
		addChild(story);
		
		this.addEventListener(MouseEvent.CLICK, onClick);
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		Settings.NEXT_LEVEL = 1;
		dispatchEvent(new Event("gotoLevel1"));
	}
	
}