package com.tipyx.games.mteproject.gameObject;

import com.tipyx.games.mteproject.gui.BtnIG;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.Assets;
import nme.Lib;
import nme.events.Event;
import nme.events.MouseEvent;

/**
 * ...
 * @author Tipyx
 */
class SkillSelect extends Sprite
{
	private var arSkill:Array<SkillIcon>;
	private var selectedSkill:SkillIcon;
	
	public function new() 
	{
		super();
		
		arSkill = [];
		
		var bitmapData:BitmapData = Assets.getBitmapData("img/bg_skillSelect.png");
		var bitmap:Bitmap = new Bitmap(bitmapData);
		
		addChild(bitmap);
		
		for (i in 0...5) {
			var skill:SkillIcon = new SkillIcon(i);
			skill.x = 100 + (i * 60);
			skill.y = 7;
			skill.addEventListener(MouseEvent.CLICK, onClickBadge);
			arSkill.push(skill);
			addChild(skill);
		}
		
		var playButton:BtnIG = new BtnIG(0);
		playButton.name = "playButton";
		playButton.x = 600;
		playButton.y = 7;
		playButton.addEventListener(MouseEvent.CLICK, onClickButton);
		
		var pauseButton:BtnIG = new BtnIG(1);
		pauseButton.name = "pauseButton";
		pauseButton.x = 660;
		pauseButton.y = 7;
		pauseButton.addEventListener(MouseEvent.CLICK, onClickButton);
		
		var stopButton:BtnIG = new BtnIG(2);
		stopButton.name = "stopButton";
		stopButton.x = 720;
		stopButton.y = 7;
		stopButton.addEventListener(MouseEvent.CLICK, onClickButton);
		
		addChild(playButton);
		addChild(pauseButton);
		addChild(stopButton);
	}
	
	private function onClickButton(e:MouseEvent):Void {
		if (e.currentTarget.name == "playButton") dispatchEvent(new Event("playButtonClicked"));
		else if (e.currentTarget.name == "pauseButton") dispatchEvent(new Event("pauseButtonClicked"));
		else if (e.currentTarget.name == "stopButton") dispatchEvent(new Event("stopButtonClicked"));
	}
	
	private function onClickBadge(e:MouseEvent):Void {
		if (selectedSkill != null) selectedSkill.alpha = 1;
		
		e.currentTarget.alpha = 0.5;
		selectedSkill = e.currentTarget;
	}
	
	public function getSelectedSkill():SkillIcon {
		return this.selectedSkill;
	}
	
}