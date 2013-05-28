package com.tipyx.games.mteproject.gameObject;

import com.tipyx.games.mteproject.ConfigLevels;
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
	private var selectedSkill:SkillIcon;
	private var playButton:BtnIG;
	private var stopButton:BtnIG;
	
	private var arSkill:Array<SkillIcon>;
	private var level:Int;
	
	public function new(_level:Int) 
	{
		super();
		
		this.level = _level;
		
		arSkill = [];
		
		var bitmapData:BitmapData = Assets.getBitmapData("img/bg_skillSelectV2.png");
		var bitmap:Bitmap = new Bitmap(bitmapData);
		addChild(bitmap);
		
		for (i in 0...6) {
			if (ConfigLevels.AR_NUM_SKILLZ_ALLOWED[this.level - 1][i] != 0) {
				var skill:SkillIcon = new SkillIcon(i);
				skill.x = 100 + (i * 60);
				skill.y = 7;
				skill.addEventListener(MouseEvent.CLICK, onClickBadge);
				arSkill.push(skill);
				if(this.level != 1) addChild(skill);				
			}
		}
		
		playButton = new BtnIG(0);
		playButton.name = "playButton";
		playButton.x = 600;
		playButton.y = 23;
		playButton.addEventListener(MouseEvent.CLICK, onClickButton);
		
		stopButton = new BtnIG(2);
		stopButton.name = "stopButton";
		stopButton.x = 720;
		stopButton.y = 23;
		stopButton.addEventListener(MouseEvent.CLICK, onClickButton);
	}
	
	private function onClickButton(e:MouseEvent):Void {
		if (e.currentTarget.name == "playButton") dispatchEvent(new Event("playButtonClicked"));
		else if (e.currentTarget.name == "stopButton") dispatchEvent(new Event("stopButtonClicked"));
	}
	
	private function onClickBadge(e:MouseEvent):Void {
		if (selectedSkill != null) selectedSkill.alpha = 1;
		e.currentTarget.alpha = 0.5;
		selectedSkill = e.currentTarget;
	}
	
	public function showSkill():Void {
		for (skill in arSkill) addChild(skill);
	}
	
	public function showPlayButton():Void {
		addChild(playButton);
	}
	
	public function showStopButton():Void {
		addChild(stopButton);
	}
	
	public function getSelectedSkill():SkillIcon {
		return this.selectedSkill;
	}
	
}