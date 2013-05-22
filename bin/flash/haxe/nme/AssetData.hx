package nme;


import nme.Assets;


class AssetData {

	
	public static var className = new #if haxe3 Map <String, #else Hash <#end Dynamic> ();
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();
	
	private static var initialized:Bool = false;
	
	
	public static function initialize ():Void {
		
		if (!initialized) {
			
			className.set ("img/bg_skillSelect.png", nme.NME_img_bg_skillselect_png);
			type.set ("img/bg_skillSelect.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/btn_home.png", nme.NME_img_btn_home_png);
			type.set ("img/btn_home.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/btn_IG.png", nme.NME_img_btn_ig_png);
			type.set ("img/btn_IG.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/hero.png", nme.NME_img_hero_png);
			type.set ("img/hero.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/skill_icon.png", nme.NME_img_skill_icon_png);
			type.set ("img/skill_icon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/tileGround.png", nme.NME_img_tileground_png);
			type.set ("img/tileGround.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/tileGround2.png", nme.NME_img_tileground2_png);
			type.set ("img/tileGround2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_img_bg_skillselect_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_btn_home_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_btn_ig_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_hero_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_skill_icon_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_tileground_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_tileground2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
