package com.tipyx.games.mteproject;

import nme.events.KeyboardEvent;
import nme.Lib;
import nme.ui.Keyboard;

/**
 * ...
 * @author Tipyx
 */
class Input
{
	public var left:Bool = false;
	public var right:Bool = false;
	public var space:Bool = false;

	public function new() 
	{
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void {
		if (e.keyCode == Keyboard.LEFT) left = true;
		if (e.keyCode == Keyboard.RIGHT) right = true;
		if (e.keyCode == Keyboard.SPACE) space = true;
	}
	
	private function onKeyUp(e:KeyboardEvent):Void {
		if (e.keyCode == Keyboard.LEFT) left = false;
		if (e.keyCode == Keyboard.RIGHT) right = false;
		if (e.keyCode == Keyboard.SPACE) space = false;
	}
}