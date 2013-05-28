package com.tipyx.games.mteproject.gameObject;

import com.eclecticdesignstudio.spritesheet.AnimatedSprite;
import com.eclecticdesignstudio.spritesheet.data.BehaviorData;
import com.eclecticdesignstudio.spritesheet.data.SpritesheetFrame;
import com.eclecticdesignstudio.spritesheet.Spritesheet;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.Assets;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author Tipyx
 */
class BossEnvironment extends Sprite
{
	private var arChain:Array<Bitmap>;
	private var step:Int = 2;
	private var jail:Bitmap;
	
	public function new() 
	{
		super();
		
		arChain = [];
		
		var bossBD:BitmapData = Assets.getBitmapData("img/boss.png");
		var boss:Bitmap = new Bitmap(bossBD);
		boss.x = 181;
		boss.y = 50;
		addChild(boss);
		
		var jailBD:BitmapData = Assets.getBitmapData("img/jail.png");
		jail = new Bitmap(jailBD);
		jail.x = 290;
		jail.y = 191;
		addChild(jail);
		
		for (i in 0...2) {
			var chainBD:BitmapData = Assets.getBitmapData("img/chain.png");
			var chain:Bitmap = new Bitmap(chainBD);
			arChain.push(chain);
			chain.x = 290 + 168 * i;
			chain.y = 155;
			addChild(chain);
		}
	}
	
	public function getJail():Bitmap {
		return this.jail;
	}
	
	public function nextStep() {
		step--;
		removeChild(arChain[step]);
	}
	
}