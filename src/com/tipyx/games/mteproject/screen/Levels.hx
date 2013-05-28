package com.tipyx.games.mteproject.screen;

import com.tipyx.games.mteproject.Settings;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import com.tipyx.games.mteproject.gameObject.BadgeLevel;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Assets;

/**
 * ...
 * @author Tipyx
 */
class Levels extends Sprite
{

	public function new() 
	{
		super();
		
		var titleBD:BitmapData = Assets.getBitmapData("img/selectLevel.png");
		var title:Bitmap = new Bitmap(titleBD);
		title.x = 293;
		title.y = 50;
		addChild(title);
		
		for (i in 0...10) {
			var btn_level:BadgeLevel = new BadgeLevel(i);
			if (i < 5) {
				btn_level.x = i * 135 + 100;
				btn_level.y = 100;
			}
			else {
				btn_level.x = (i - 5) * 135 + 100;
				btn_level.y = 250;
			}
			if (i > 0 && !Settings.AR_LEVELS_FINISHED[i - 1]) btn_level.alpha = 0.5;
			else btn_level.addEventListener(MouseEvent.CLICK, onClickBtn);
			addChild(btn_level);
		}
	}
	
	private function onClickBtn(e:MouseEvent):Void {
		Settings.NEXT_LEVEL = e.currentTarget.getNum() + 1;
		dispatchEvent(new Event("gotoLevel"));
	}
	
}