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
			className.set ("img/bg_skillSelectV2.png", nme.NME_img_bg_skillselectv2_png);
			type.set ("img/bg_skillSelectV2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/boss.png", nme.NME_img_boss_png);
			type.set ("img/boss.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/btn_home.png", nme.NME_img_btn_home_png);
			type.set ("img/btn_home.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/btn_homeV2.png", nme.NME_img_btn_homev2_png);
			type.set ("img/btn_homeV2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/btn_IG.png", nme.NME_img_btn_ig_png);
			type.set ("img/btn_IG.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/btn_IGV2.png", nme.NME_img_btn_igv2_png);
			type.set ("img/btn_IGV2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/btn_levels.png", nme.NME_img_btn_levels_png);
			type.set ("img/btn_levels.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/chain.png", nme.NME_img_chain_png);
			type.set ("img/chain.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/clickContinueButton.png", nme.NME_img_clickcontinuebutton_png);
			type.set ("img/clickContinueButton.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/EndScreen.png", nme.NME_img_endscreen_png);
			type.set ("img/EndScreen.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/hero.png", nme.NME_img_hero_png);
			type.set ("img/hero.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/heroV2.png", nme.NME_img_herov2_png);
			type.set ("img/heroV2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/heroV3.png", nme.NME_img_herov3_png);
			type.set ("img/heroV3.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/jail.png", nme.NME_img_jail_png);
			type.set ("img/jail.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/mob1.png", nme.NME_img_mob1_png);
			type.set ("img/mob1.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/selectLevel.png", nme.NME_img_selectlevel_png);
			type.set ("img/selectLevel.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/sign.png", nme.NME_img_sign_png);
			type.set ("img/sign.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/skill_icon.png", nme.NME_img_skill_icon_png);
			type.set ("img/skill_icon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/skill_iconV2.png", nme.NME_img_skill_iconv2_png);
			type.set ("img/skill_iconV2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/storyScreen.png", nme.NME_img_storyscreen_png);
			type.set ("img/storyScreen.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/tileGround.png", nme.NME_img_tileground_png);
			type.set ("img/tileGround.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/tileGroundV2-Demi.png", nme.NME_img_tilegroundv2_demi_png);
			type.set ("img/tileGroundV2-Demi.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/tileGroundV2.png", nme.NME_img_tilegroundv2_png);
			type.set ("img/tileGroundV2.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/title.png", nme.NME_img_title_png);
			type.set ("img/title.png", Reflect.field (AssetType, "image".toUpperCase ()));
			className.set ("img/tutoMessage.png", nme.NME_img_tutomessage_png);
			type.set ("img/tutoMessage.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		}
		
	}
	
	
}


class NME_img_bg_skillselect_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_bg_skillselectv2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_boss_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_btn_home_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_btn_homev2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_btn_ig_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_btn_igv2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_btn_levels_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_chain_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_clickcontinuebutton_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_endscreen_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_hero_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_herov2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_herov3_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_jail_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_mob1_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_selectlevel_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_sign_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_skill_icon_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_skill_iconv2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_storyscreen_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_tileground_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_tilegroundv2_demi_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_tilegroundv2_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_title_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_img_tutomessage_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
