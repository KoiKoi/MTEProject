package com.tipyx.lib;


import com.tipyx.games.mteproject.Settings;
import motion.Actuate;
import nme.Lib;
import nme.media.Sound;
import nme.media.SoundChannel;
import nme.media.SoundTransform;
import nme.net.URLRequest;
import nme.events.Event;
import nme.Assets;

/**
 * ...
 * @author Tipyx
 */
class MusicObject
{
		private var channel:SoundChannel;
		private var transform:SoundTransform;
		//private var sound:Sound;
		private var loop:Bool;
		private var isPlaying:Bool;
		private var volumeMax:Float;
		
	/**
	 * Need the Haxelib Actuate !
	 */
	
	public function new(_stringPathFile:String, _loop:Bool = false, _volumeMax:Float = 1) 
	{
		this.volumeMax = _volumeMax;
		this.loop = _loop;
		
		Lib.trace(_stringPathFile);
		
		var sound = Assets.getSound("assets/sound/overworld.mp3");
		sound.play();
	}

	public function play(_delay:Float = 0):Void {
		//if (!isPlaying && Settings.MUSIC_ENABLED) {
			//if (loop) channel = sound.play(_delay, 9999);
			//else channel = sound.play(_delay);
			//transform = channel.soundTransform;
			//transform.volume = volumeMax;
			//channel.soundTransform = transform;
			//isPlaying = true;				
			//channel.addEventListener(Event.SOUND_COMPLETE, stop);
		//}
	}

	//public function stop(e:Event = null):Void {
		//if (isPlaying && Settings.MUSIC_ENABLED) {
			//isPlaying = false;
			//channel.stop();				
		//}
	//}
	//
	//public function fadeOut(_time:Float):Void {
		//if (isPlaying && Settings.MUSIC_ENABLED) Actuate.tween(channel, _time, {volume:0}).onComplete(stop);
	//}
	//
	//public function fadeIn(_time:Float, _delay:Float = 0):Void {
		//if (!isPlaying && Settings.MUSIC_ENABLED) {
			//play(_delay);
			//transform.volume = 0;
			//channel.soundTransform = transform;
			//Actuate.tween(channel, _time, { volume:volumeMax} );				
		//}
	//}
}