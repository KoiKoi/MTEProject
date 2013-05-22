package com.tipyx.games.mteproject;

import com.tipyx.games.mteproject.gui.FadeBlackScreen;
import com.tipyx.games.mteproject.screen.Game;
import com.tipyx.games.mteproject.screen.Home;
import motion.Actuate;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author Tipyx
 */

class Main extends Sprite 
{
	private var blackScreenFade:FadeBlackScreen;
	private var home:Home;
	private var game:Game;
	
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
		blackScreenFade = new FadeBlackScreen();
		
		var maskObject:Sprite = new Sprite();
		maskObject.graphics.beginFill(0x000000);
		maskObject.graphics.drawRect(0, 0, Lib.stage.stageWidth, Lib.stage.stageHeight);
		addChild(maskObject);
		this.mask = maskObject;
		
		//gotoHomePage();
		
		changeScreen("home");
	}
		
	public function changeScreen(newScreen:String):Void {
		addChild(blackScreenFade);
		Actuate.tween(blackScreenFade, 0.5, { alpha : 1 }).onComplete(removeBlackScreen, [newScreen]);
		//.to(blackScreenFade, 0.25, { alpha : 1, onComplete: removeBlackScreen, onCompleteParams: [newScreen] } );
	}
	
	private function removeBlackScreen(newScreen:String):Void { 
		changePage(newScreen);
		Actuate.tween(blackScreenFade, 0.5, { alpha : 0 }).onComplete(endAnim);
		//TweenMax.to(blackScreenFade, 0.25, { alpha : 0, onComplete: endAnim} );
	}
	
	private function endAnim():Void {
		removeChild(blackScreenFade);
	}
	
	private function changePage(newScreen:String):Void {
		// Remove old Screen
		if (home != null) {
			home.removeEventListener("playButtonClicked", gotoGamePage);
			//home.removeEventListener("continueButtonClicked", gotoGamePage);
			//home.removeEventListener("optionsButtonClicked", gotoGamePage);
			removeChild(home);
			home = null;
		}
		else if (game != null) {
			removeChild(game);
			game = null;
		}
		
		// Add new Screen
		if (newScreen == "home") {
			home = new Home();
			home.addEventListener("playButtonClicked", gotoGamePage);
			//home.addEventListener("continueButtonClicked", gotoGamePage);
			//home.addEventListener("optionsButtonClicked", gotoGamePage);
			addChild(home);
		}
		else if (newScreen == "game") {
			game = new Game();
			addChild(game);
		}
		
		this.setChildIndex(blackScreenFade, this.numChildren - 1);
	}
	
	private function gotoGamePage(e:Event = null) 
	{
		changeScreen("game");	
	}
	
	//
	//private function gotoHomePage() 
	//{
		//var home:Home = new Home();
		//home.addEventListener("playButtonClicked", gotoGamePage);
		//home.addEventListener("continueButtonClicked", gotoGamePage);
		//home.addEventListener("optionsButtonClicked", gotoGamePage);
		//addChild(home);		
	//}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
