package com.tipyx.games.mteproject.gui;

import com.tipyx.games.mteproject.gui.TutoMessage;
import nme.events.Event;
import nme.display.Sprite;

/**
 * ...
 * @author Tipyx
 */
class Tuto extends Sprite
{
	private var arPositionMessage:Array<Array<Float>>;
	private var arTutoMessage:Array<TutoMessage>;
	private var step:Int = 0;
	private var level:Int;

	public function new(_level:Int) 
	{
		super();
		
		this.level = _level;
		arTutoMessage = [];
		
		if (this.level == 1) {
			arPositionMessage = [[235,175],[450,300],[235,175],[70,60],[70,60],[450,60],[235,175],[450,60],[235,175]];
			
			for (i in 0...9) {
				var tutoMessage:TutoMessage = new TutoMessage(i);
				tutoMessage.x = arPositionMessage[i][0];
				tutoMessage.y = arPositionMessage[i][1];
				arTutoMessage.push(tutoMessage);
			}			
		}
		else {
			for (i in 9...12) {
				var tutoMessage:TutoMessage = new TutoMessage(i);
				tutoMessage.x = 235;
				tutoMessage.y = 175;
				arTutoMessage.push(tutoMessage);
			}
		}
		
		
		addChild(arTutoMessage[0]);
	}
	
	public function gotoNextStep():Void {
		removeChild(arTutoMessage[step]);
		step++;
		if ((this.level == 1 && step < 9) || (this.level == 2 && step < 3)) addChild(arTutoMessage[step]);
		else dispatchEvent(new Event("endTuto"));
	}
	
	public function getStep():Int {
		return this.step;
	}
	
}