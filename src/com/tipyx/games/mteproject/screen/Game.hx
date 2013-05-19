package com.tipyx.games.mteproject.screen;

import com.tipyx.games.mteproject.bgObject.TileNormal;
import com.tipyx.games.mteproject.ConfigLevels;
import com.tipyx.games.mteproject.gameObject.Hero;
import com.tipyx.games.mteproject.Input;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author Tipyx
 */
class Game extends Sprite
{
	private var input:Input;
	private var hero:Hero;
	private var arTiles:Array<TileNormal>;

	public function new() 
	{
		super();
		
		arTiles = [];
		input = new Input();
		
		hero = new Hero();
		hero.scaleX = hero.scaleY = 1.5;
		hero.x = hero.y = 200;
		addChild(hero);
		
		var actualBlocSelected:Int = 0;
		for (i in 0...15) {
			for (j in  0...25) {
				if (ConfigLevels.AR_LEVELS_TILES[0][actualBlocSelected] != -1) {
					var tile:TileNormal = new TileNormal(ConfigLevels.AR_LEVELS_TILES[0][actualBlocSelected]);
					arTiles.push(tile);
					tile.scaleX = tile.scaleY = 2;
					tile.x = tile.width * j;
					tile.y = tile.width * i;
					addChild(tile);
				}
				actualBlocSelected++;
			}
		}
		
		this.addEventListener(Event.ENTER_FRAME, update);
		
	}
	
	private function update(e:Event):Void {
		if (!checkCollisionUnder()) hero.y += 2;
		
		if (input.left) hero.x -= 2;
		else if (input.right) hero.x += 2;
	}
	
	private function checkCollisionUnder():Bool {
		for (tile in arTiles) {
			if (tile.collideY(hero.x, hero.y + 2)) return true;
		}
		return false;
	}
	
}