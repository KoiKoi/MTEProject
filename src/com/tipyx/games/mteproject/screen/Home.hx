package com.tipyx.games.mteproject.screen;

import com.tipyx.games.mteproject.gui.BtnHome;
import com.tipyx.games.mteproject.Settings;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Assets;

/**
 * ...
 * @author Tipyx
 */
class Home extends Sprite
{

	public function new() 
	{
		super ();
		if (stage != null) init();
		else addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(e:Event = null):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		var titleBD:BitmapData = Assets.getBitmapData("img/title.png");
		var title:Bitmap = new Bitmap(titleBD);
		title.x = 294;
		title.y = 50;
		addChild(title);
		
		var playButton:BtnHome = new BtnHome(0);
		playButton.name = "playButton";
		playButton.x = 400;
		playButton.y = 200;
		playButton.addEventListener(MouseEvent.CLICK, onClickButton);
		
		var continueButton:BtnHome = new BtnHome(1);
		continueButton.name = "continueButton";
		continueButton.x = 400;
		continueButton.y = 300;
		continueButton.addEventListener(MouseEvent.CLICK, onClickButton);
		
		var optionsButton:BtnHome = new BtnHome(2);
		optionsButton.name = "optionsButton";
		optionsButton.x = 400;
		optionsButton.y = 400;
		optionsButton.addEventListener(MouseEvent.CLICK, onClickButton);
		
		addChild(playButton);
		addChild(continueButton);
		addChild(optionsButton);
	}
	
	private function onClickButton(e:MouseEvent):Void {
		if (e.currentTarget.name == "playButton") dispatchEvent(new Event("playButtonClicked"));
		else if (e.currentTarget.name == "continueButton") dispatchEvent(new Event("continueButtonClicked"));
		else if (e.currentTarget.name == "optionsButton") dispatchEvent(new Event("optionsButtonClicked"));
	}
	
}