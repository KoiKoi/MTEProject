package com.tipyx.games.mteproject;

import com.tipyx.games.mteproject.gui.FadeBlackScreen;
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
		
		//gotoHomePage();
		
		changeScreen("home");
	}
		
	public function changeScreen(_newScreen:String, _level:Int = 1):Void {
		addChild(blackScreenFade);
		Actuate.tween(blackScreenFade, 0.5, { alpha : 1 }).onComplete(removeBlackScreen, [_newScreen, _level]);
	}
	
	private function removeBlackScreen(_newScreen:String, _level:Int):Void { 
		changePage(_newScreen, _level);
		Actuate.tween(blackScreenFade, 0.5, { alpha : 0 }).onComplete(endAnim);
	}
	
	private function endAnim():Void {
		removeChild(blackScreenFade);
	}
	
	private function changePage(newScreen:String, _level:Int):Void {
		// Remove old Screen
		if (home != null) {
			home.removeEventListener("playButtonClicked", gotoStoryScreen);
			home.removeEventListener("continueButtonClicked", gotoLevelsScreen);
			//home.removeEventListener("optionsButtonClicked", gotoGamePage);
			removeChild(home);
			home = null;
		}
		else if (game != null) {
			removeChild(game);
			game.removeEventListener("nextLevel", gotoGameScreen);
			game = null;
		}
		else if (story != null) {
			removeChild(story);
			story.removeEventListener("gotoLevel1", gotoGameScreen);
			story = null;
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
			//home.addEventListener("optionsButtonClicked", gotoGamePage);
			addChild(home);
		}
		else if (newScreen == "game") {
			game = new Game(_level);
			setCookie();
			game.addEventListener("nextLevel", gotoGameScreen);
			//SoundManager.overworld.play();
			addChild(game);
		}
		else if (newScreen == "story") {
			story = new Story();
			story.addEventListener("gotoLevel1", gotoGameScreen);
			addChild(story);
		}
		else if (newScreen == "levels") {
			levels = new Levels();
			levels.addEventListener("gotoLevel", gotoGameScreen);
			addChild(levels);
		}
		
		this.setChildIndex(blackScreenFade, this.numChildren - 1);
	}
	
	private function gotoLevelsScreen(e:Event = null) {
		changeScreen("levels");	
	}
	
	private function gotoStoryScreen(e:Event = null) {
		changeScreen("story");	
	}
	
	private function gotoGameScreen(e:Event = null) {
		changeScreen("game", Settings.NEXT_LEVEL);	
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
