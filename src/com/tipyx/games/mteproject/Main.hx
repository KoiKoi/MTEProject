package com.tipyx.games.mteproject;

import com.tipyx.games.mteproject.gui.FadeBlackScreen;
import com.tipyx.games.mteproject.screen.EndScreen;
import com.tipyx.games.mteproject.screen.Game;
import com.tipyx.games.mteproject.screen.Home;
import com.tipyx.games.mteproject.screen.Levels;
import com.tipyx.games.mteproject.screen.Story;
import motion.Actuate;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import nme.net.SharedObject;

/**
 * ...
 * @author Tipyx
 */

class Main extends Sprite 
{
	private var blackScreenFade:FadeBlackScreen;
	private var cookie:SharedObject;
	private var home:Home;
	private var game:Game;
	private var story:Story;
	private var endScreen:EndScreen;
	private var levels:Levels;
	
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
		cookie = SharedObject.getLocal("ZeroToHero");
		if (cookie.size != 0) Settings.AR_LEVELS_FINISHED = cookie.data.arLevelFinished;
		
		blackScreenFade = new FadeBlackScreen();
		
		var maskObject:Sprite = new Sprite();
		maskObject.graphics.beginFill(0x000000);
		maskObject.graphics.drawRect(0, 0, 800, 480);
		addChild(maskObject);
		this.mask = maskObject;
		
		changeScreen("home");
	}
		
	public function changeScreen(_newScreen:String):Void {
		addChild(blackScreenFade);
		Actuate.tween(blackScreenFade, 0.5, { alpha : 1 }).onComplete(removeBlackScreen, [_newScreen]);
	}
	
	private function removeBlackScreen(_newScreen:String):Void { 
		changePage(_newScreen);
		Actuate.tween(blackScreenFade, 0.5, { alpha : 0 }).onComplete(endAnim);
	}
	
	private function endAnim():Void {
		removeChild(blackScreenFade);
	}
	
	private function changePage(newScreen:String):Void {
		// Remove old Screen
		if (home != null) {
			home.removeEventListener("playButtonClicked", gotoStoryScreen);
			home.removeEventListener("continueButtonClicked", gotoLevelsScreen);
			removeChild(home);
			home = null;
		}
		else if (game != null) {
			removeChild(game);
			game.removeEventListener("nextLevel", gotoGameScreen);
			game.removeEventListener("gotoEndScreen", gotoEndScreen);
			game = null;
		}
		else if (story != null) {
			removeChild(story);
			story.removeEventListener("gotoLevel1", gotoGameScreen);
			story = null;
		}
		else if (endScreen != null) {
			removeChild(endScreen);
			endScreen.removeEventListener("gotoHome", gotoHomeScreen);
			endScreen = null;
		}
		else if (levels != null) {
			removeChild(levels);
			levels.removeEventListener("gotoLevel", gotoGameScreen);
			levels = null;
		}
		
		// Add new Screen
		if (newScreen == "home") {
			home = new Home();
			home.addEventListener("playButtonClicked", gotoStoryScreen);
			home.addEventListener("continueButtonClicked", gotoLevelsScreen);
			addChild(home);
		}
		else if (newScreen == "game") {
			game = new Game(Settings.NEXT_LEVEL);
			setCookie();
			game.addEventListener("nextLevel", gotoGameScreen);
			game.addEventListener("gotoEndScreen", gotoEndScreen);
			addChild(game);
		}
		else if (newScreen == "story") {
			story = new Story();
			story.addEventListener("gotoLevel1", gotoGameScreen);
			addChild(story);
		}
		else if (newScreen == "endScreen") {
			endScreen = new EndScreen();
			endScreen.addEventListener("gotoHome", gotoHomeScreen);
			addChild(endScreen);
		}
		else if (newScreen == "levels") {
			levels = new Levels();
			levels.addEventListener("gotoLevel", gotoGameScreen);
			addChild(levels);
		}
		
		this.setChildIndex(blackScreenFade, this.numChildren - 1);
	}
	
	private function gotoHomeScreen(e:Event = null) {
		changeScreen("home");	
	}
	
	private function gotoLevelsScreen(e:Event = null) {
		changeScreen("levels");	
	}
	
	private function gotoStoryScreen(e:Event = null) {
		changeScreen("story");	
	}
	
	private function gotoEndScreen(e:Event = null) {
		changeScreen("endScreen");	
	}
	
	private function gotoGameScreen(e:Event = null) {
		changeScreen("game");	
	}
	
	public function setCookie():Void {
		cookie.data.arLevelFinished = Settings.AR_LEVELS_FINISHED;
	}

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
