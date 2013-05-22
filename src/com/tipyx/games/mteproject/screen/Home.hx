package com.tipyx.games.mteproject.screen;

import com.tipyx.games.mteproject.gui.BtnHome;
import com.tipyx.games.mteproject.Settings;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;

/**
 * ...
 * @author Tipyx
 */
class Home extends Sprite
{

	public function new() 
	{
		super ();
		
		var playButton:BtnHome = new BtnHome(0);
		playButton.name = "playButton";
		playButton.x = 325;
		playButton.y = 100;
		playButton.addEventListener(MouseEvent.CLICK, onClickButton);
		
		var continueButton:BtnHome = new BtnHome(1);
		continueButton.name = "continueButton";
		continueButton.x = 325;
		continueButton.y = 200;
		continueButton.addEventListener(MouseEvent.CLICK, onClickButton);
		
		var optionsButton:BtnHome = new BtnHome(2);
		optionsButton.name = "optionsButton";
		optionsButton.x = 325;
		optionsButton.y = 300;
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