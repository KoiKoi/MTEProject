package com.tipyx.games.mteproject.screen;

import com.tipyx.games.mteproject.bgObject.TileNormal;
import com.tipyx.games.mteproject.bgObject.ExitSign;
import com.tipyx.games.mteproject.ConfigLevels;
import com.tipyx.games.mteproject.gameObject.Hero;
import com.tipyx.games.mteproject.gameObject.Mob;
import com.tipyx.games.mteproject.gameObject.SkillIcon;
import com.tipyx.games.mteproject.gameObject.SkillSelect;
import com.tipyx.games.mteproject.gui.Tuto;
import com.tipyx.games.mteproject.Input;
import com.tipyx.games.mteproject.Settings;
import motion.Actuate;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Shape;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.geom.Point;
import nme.Lib;
import nme.Assets;

using Lambda;

/**
 * ...
 * @author Tipyx
 */
class Game extends Sprite
{
	private var input:Input;
	private var hero:Hero;
	private var skillSelection:SkillSelect;
	
	private var arTiles:Array<TileNormal>;
	private var arSizeLevel:Array<Int>;
	private var arMobs:Array<Mob>;
	private var speedJump:Float = 0;
	private var jumpEnable:Bool = false;
	private var goLeft:Bool = false;
	private var goRight:Bool = false;
	private var level:Int;
	private var tuto:Tuto;
	private var exitSign:ExitSign;

	public function new(_level:Int) 
	{
		super();
		
		this.level = _level;
		init();
	}
	
	private function init() {
		input = new Input();
		arTiles = [];
		arMobs = [];
		
		arSizeLevel = [15, 25];
		
		// Init Levels
		var actualBlocSelected:Int = 0;
		for (i in 0...arSizeLevel[0]) {
			for (j in  0...arSizeLevel[1]) {
				if (ConfigLevels.AR_LEVELS_TILES[this.level - 1][actualBlocSelected] != -1) {
					var tile:TileNormal = new TileNormal(ConfigLevels.AR_LEVELS_TILES[this.level - 1][actualBlocSelected]);
					arTiles.push(tile);
					tile.x = tile.width * j;
					tile.y = tile.width * i;
					if (this.level != 1 || this.level != 2) {
						tile.enableRollOver();
						tile.addEventListener(MouseEvent.CLICK, onClickTile);
						tile.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClickTile);
					}
					addChild(tile);
				}
				actualBlocSelected++;
			}
			var tile:TileNormal = new TileNormal(0);
			arTiles.push(tile);
			tile.x = -tile.width;
			tile.y = tile.width * i;
			addChild(tile);
		}
		
		if (ConfigLevels.AR_MOBS_INIT[this.level - 1][0] != 0) {
			for (i in 0...Std.int(ConfigLevels.AR_MOBS_INIT[this.level - 1][0])) {
				var mob:Mob = new Mob();
				mob.x = ConfigLevels.AR_MOBS_INIT[this.level - 1][1 + (2 * i)];
				mob.y = ConfigLevels.AR_MOBS_INIT[this.level - 1][2 + (2 * i)];
				arMobs.push(mob);
				addChild(mob);
			}
		}
		
		// If Level 1, add Tuto
		if (this.level == 1 || this.level == 2) {
			tuto = new Tuto(this.level);
			tuto.addEventListener("endTuto", endTuto);
			addChild(tuto);			
			Lib.current.stage.addEventListener(MouseEvent.CLICK, onClickStage);
		}
		
		hero = new Hero();
		hero.x = ConfigLevels.AR_POSITION_INIT_HERO[this.level - 1][0];
		hero.y = ConfigLevels.AR_POSITION_INIT_HERO[this.level - 1][1];
		addChild(hero);
		
		exitSign = new ExitSign();
		exitSign.x = ConfigLevels.AR_POSITION_EXIT_SIGN[this.level - 1][0];
		exitSign.y = ConfigLevels.AR_POSITION_EXIT_SIGN[this.level - 1][1];
		addChild(exitSign);
		
		skillSelection = new SkillSelect(this.level);
		if (this.level == 1 || this.level == 2) {
			skillSelection.y = -50;
		}
		else {
			skillSelection.showPlayButton();
			skillSelection.showStopButton();
			skillSelection.addEventListener("playButtonClicked", play);
			skillSelection.addEventListener("stopButtonClicked", resetLevel);			
		}
		addChild(skillSelection);
		
		
	}
	
	private function onClickStage(e:MouseEvent = null):Void {
		tuto.gotoNextStep();
		if (tuto.getStep() == 3) Actuate.tween(skillSelection, 1, { y:0 } );
		else if (tuto.getStep() == 4) {
			for (tile in arTiles) {
				tile.enableRollOver();
				tile.addEventListener(MouseEvent.CLICK, onClickTile);
			}
			skillSelection.showSkill();
			Lib.current.stage.removeEventListener(MouseEvent.CLICK, onClickStage);
		}
		else if (tuto.getStep() == 5) {
			skillSelection.showPlayButton();
			skillSelection.addEventListener("playButtonClicked", play);
		}
		else if (tuto.getStep() == 7) skillSelection.showStopButton();
		else if (tuto.getStep() == 9) Lib.current.stage.removeEventListener(MouseEvent.CLICK, onClickStage);
	}
	
	private function endTuto(e:Event):Void {
		if (this.level == 1) {
			Settings.NEXT_LEVEL++;
			dispatchEvent(new Event("nextLevel"));			
		}
		else {
			Lib.current.stage.removeEventListener(MouseEvent.CLICK, onClickStage);
			Actuate.tween(skillSelection, 1, { y:0 } );
			for (tile in arTiles) {
				tile.enableRollOver();
				tile.addEventListener(MouseEvent.CLICK, onClickTile);
				tile.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClickTile);
			}
			skillSelection.showPlayButton();
			skillSelection.showStopButton();
			skillSelection.addEventListener("playButtonClicked", play);
			skillSelection.addEventListener("stopButtonClicked", resetLevel);	
		}
	}
	
	private function play(e:Event):Void {
		hero.showNormal();
		this.addEventListener(Event.ENTER_FRAME, update);
	}
	
	private function resetLevel(e:Event = null):Void {
		hero.showHidden();
		hero.x = ConfigLevels.AR_POSITION_INIT_HERO[this.level - 1][0];
		hero.y = ConfigLevels.AR_POSITION_INIT_HERO[this.level - 1][1];
		speedJump = 0;
		for (mob in arMobs) {
			mob.x = ConfigLevels.AR_MOBS_INIT[this.level - 1][1 + (2 * arMobs.indexOf(mob))];
			mob.y = ConfigLevels.AR_MOBS_INIT[this.level - 1][2 + (2 * arMobs.indexOf(mob))];
			mob.goLeft();
		}
		goLeft = false;
		goRight = false;
		this.removeEventListener(Event.ENTER_FRAME, update);
	}
	
	private function onDoubleClickTile(e:MouseEvent):Void {
		e.currentTarget.removeSkillIcon();
	}
	
	private function onClickTile(e:MouseEvent):Void {
		if (skillSelection.getSelectedSkill() != null) {
			e.currentTarget.setSkillIcon(skillSelection.getSelectedSkill().getType());
			Lib.trace(arTiles.indexOf(e.currentTarget));
			if (this.level == 1 && tuto.getStep() == 4 && arTiles.indexOf(e.currentTarget) == 14) onClickStage();
		}
	}
	
	private function update(e:Event):Void {
		// Movement
		
		if (speedJump >= 0) {
			if (getTileUnder(hero) != null) {
				switch (getTileUnder(hero).getSkillType()) 
				{
					case 0:
						if (goLeft) getTileUnder(hero).setSkillIcon(1);
						else getTileUnder(hero).setSkillIcon(2);
						goLeft = goRight = false;
						hero.y = getTileUnder(hero).y;
						speedJump = -15;
						jumpEnable = false;
						
					case 1:
						goRight = false;
						goLeft = true;
						hero.y = getTileUnder(hero).y;
					
					case 2:
						goLeft = false;
						goRight = true;
						hero.y = getTileUnder(hero).y;
						
					case 3:
						goRight = false;
						goLeft = true;
						hero.y = getTileUnder(hero).y;
						speedJump = -15;
						jumpEnable = false;
					
					case 4:
						goLeft = false;
						goRight = true;
						hero.y = getTileUnder(hero).y;
						speedJump = -15;
						jumpEnable = false;
						
					default:
						jumpEnable = true;
						hero.y = getTileUnder(hero).y;
						speedJump = 0;
				}
			}
			else hero.y += speedJump;
		}
		else {
			if (getTileAbove(hero) == null) hero.y += speedJump;
			else {
				hero.y = getTileAbove(hero).y + getTileAbove(hero).getHeight() + hero.height;
				speedJump = 0;
			}
		}
		
		
		if (speedJump < Settings.SPEED_JUMP_MAX) {
			if (speedJump < 0) speedJump += 1.5;
			else speedJump += 0.4;
		}
		
		if (this.level == 1 && hero.x >= exitSign.x && tuto.getStep() == 5) {
			onClickStage();
			Lib.current.stage.addEventListener(MouseEvent.CLICK, onClickStage);
		}
		else if (this.level != 1 && hero.x >= exitSign.x && hero.hitTestObject(exitSign)) {
			this.removeEventListener(Event.ENTER_FRAME, update);
			Settings.NEXT_LEVEL++;
			Settings.AR_LEVELS_FINISHED[this.level - 1] = true;
			dispatchEvent(new Event("nextLevel"));
		}
		
		if (goLeft || input.left) {
			if (getTileLeft(hero) == null) {
				hero.x -= Settings.SPEED_X_MAX;
				hero.showWalk(true);
			}
			else {
				if (getTileUnder(hero) == null) {
					hero.x = getTileLeft(hero).x + getTileLeft(hero).getWidth() + 1;
					hero.showNormal();					
				}
				else {
					goLeft = false;
					goRight = true;					
				}
			}
		}
		else if (goRight || input.right) {
			if (getTileRight(hero) == null) {
				hero.x += Settings.SPEED_X_MAX;
				hero.showWalk();
			}
			else {
				if (getTileUnder(hero) == null) {
					hero.x = getTileRight(hero).x - hero.width;
					hero.showNormal();
				}
				else {
					goRight = false;
					goLeft = true;
				}
			}
		}
		else hero.showNormal();
		
		for (mob in arMobs) {
			if (mob.hitTestObject(hero)) resetLevel();
			if (mob.getDirection() == "left") {
				if (getTileLeft(mob) == null) mob.x -= 4;
				else mob.goRight();
			}
			else {
				if (getTileRight(mob) == null) mob.x += 4;
				else mob.goLeft();
			}
		}
		
		// Animation
		for (tile in arTiles) tile.update();
		for (mob in arMobs) mob.update();
		hero.update();
	}
	
	private function getTileUnder(_object:Dynamic):TileNormal {
		for (tile in arTiles) {
			if (tile.collideY(_object.x, _object.y + speedJump, _object.width)) return tile;
		}
		return null;
	}
	
	private function getTileAbove(_object:Dynamic):TileNormal {
		for (tile in arTiles) {
			if (tile.collideY(_object.x, _object.y + speedJump - _object.height, _object.width)) return tile;
		}
		return null;
	}
	
	private function getTileRight(_object:Dynamic):TileNormal {
		for (tile in arTiles) {
			if (tile.collideX(_object.x + _object.width + Settings.SPEED_X_MAX, _object.y, _object.height)) return tile;
		}
		return null;
	}
	
	private function getTileLeft(_object:Dynamic):TileNormal {
		for (tile in arTiles) {
			if (tile.collideX(_object.x - Settings.SPEED_X_MAX, _object.y, _object.height)) return tile;
		}
		return null;
	}
	
}