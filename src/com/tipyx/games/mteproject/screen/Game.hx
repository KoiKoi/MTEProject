package com.tipyx.games.mteproject.screen;

import com.tipyx.games.mteproject.bgObject.TileNormal;
import com.tipyx.games.mteproject.ConfigLevels;
import com.tipyx.games.mteproject.gameObject.Hero;
import com.tipyx.games.mteproject.gameObject.SkillIcon;
import com.tipyx.games.mteproject.gameObject.SkillSelect;
import com.tipyx.games.mteproject.Input;
import com.tipyx.games.mteproject.Settings;
import nme.display.Bitmap;
import nme.display.Shape;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.geom.Point;
import nme.Lib;
import nme.Assets;

/**
 * ...
 * @author Tipyx
 */
class Game extends Sprite
{
	private var input:Input;
	private var hero:Hero;
	private var arTiles:Array<TileNormal>;
	private var speedJump:Float = 0;
	private var jumpEnable:Bool = false;
	private var skillSelection:SkillSelect;
	
	private var goLeft:Bool = false;
	private var goRight:Bool = false;

	public function new() 
	{
		super();
		init();
	}
	
	private function init() {
		input = new Input();
		arTiles = [];
		
		// Init Levels
		var actualBlocSelected:Int = 0;
		for (i in 0...15) {
			for (j in  0...25) {
				if (ConfigLevels.AR_LEVELS_TILES[0][actualBlocSelected] != -1) {
					var tile:TileNormal = new TileNormal(ConfigLevels.AR_LEVELS_TILES[0][actualBlocSelected]);
					arTiles.push(tile);
					tile.x = tile.width * j;
					tile.y = tile.width * i;
					tile.addEventListener(MouseEvent.CLICK, onClickTile);
					addChild(tile);
				}
				actualBlocSelected++;
			}
		}
		
		hero = new Hero();
		hero.scaleX = hero.scaleY = 1.5;
		hero.x = 10;
		hero.y = 200;
		addChild(hero);
		
		skillSelection = new SkillSelect();
		skillSelection.addEventListener("playButtonClicked", play);
		skillSelection.addEventListener("pauseButtonClicked", pause);
		addChild(skillSelection);
		
	}
	
	private function play(e:Event):Void 
	{
		hero.showNormal();
		this.addEventListener(Event.ENTER_FRAME, update);		
	}
	
	private function pause(e:Event):Void 
	{
		hero.showHidden();
		this.removeEventListener(Event.ENTER_FRAME, update);		
	}
	
	private function onClickTile(e:MouseEvent):Void {
		if (skillSelection.getSelectedSkill() != null) e.currentTarget.setSkillIcon(skillSelection.getSelectedSkill().getType());
	}
	
	private function update(e:Event):Void {
		// Movement
		
		if (!checkCollisionUnder()) {
			hero.y += speedJump;
			if (speedJump < Settings.SPEED_JUMP_MAX) {
				if (speedJump < 0) speedJump += 1;
				else speedJump += 0.4;
			}
		}
		else {
			if (getTileUnder() != null) {
				hero.y = getTileUnder().y;
				switch (getTileUnder().getSkillType()) 
				{
					case 0:
						goLeft = goRight = false;
						speedJump = -15;
						jumpEnable = false;
						
					case 1:
						goRight = false;
						goLeft = true;
					
					case 2:
						goLeft = false;
						goRight = true;
						
					default:
						jumpEnable = true;
						speedJump = 0;
						
				}
			}
		}
		
		if (goLeft || input.left) {
			//if (checkCollisionRight())
			hero.x -= Settings.SPEED_X_MAX;
		}
		else if (goRight || input.right) {
			if (checkCollisionRight()) hero.x += Settings.SPEED_X_MAX;
		}
		
		if (input.space && jumpEnable) {
			//hero.y -= speedJump;
			speedJump = -15;
			jumpEnable = false;
		}
		
		// Animation
		for (tile in arTiles) tile.update();
	}
	
	private function getTileUnder():TileNormal {
		for (tile in arTiles) {
			if (hero.x >= tile.x && hero.x <= tile.x + tile.width) return tile;
		}
		return null;
	}
	
	private function checkCollisionUnder():Bool {
		for (tile in arTiles) {
			if (tile.collideY(hero.x, hero.y + speedJump, 8 * hero.scaleX)) return true;
		}
		return false;
	}
	
	private function checkCollisionRight():Bool {
		for (tile in arTiles) {
			if (tile.collideX(hero.x + hero.width + Settings.SPEED_X_MAX, hero.y, hero.height)) return true;
		}
		return false;
	}
	
}