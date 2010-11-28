package com.nakand.core {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class BaseScene extends Sprite{
		
		private var _id : String;
		private var _sound : String;
		private var _badScene : String;
		private var _regularScene : String;
		private var _goodScene : String;
		
		private var _rules : Object;
		
		private var _takes : Array;
		private var _takes_index : Number = 0;
		
		public function BaseScene(scene_xml:XML) {
			super();
			this.id 			= scene_xml.attribute('id');
			this.sound 			= scene_xml.attribute('sound_path');
			this.badScene 		= scene_xml.attribute('bad') || null;
			this.regularScene	= scene_xml.attribute('regular');
			this.goodScene 		= scene_xml.attribute('good') || null;
			this.takes = new Array();
			for each (var take:XML in scene_xml.take ) {
				trace('loop take');
				var base_take:BaseTake = new BaseTake(take);
				this.takes.push(base_take);
			}
		}

		public function playIt() : void {
			//add the sound of this scene
			var background_sound:Sound = new Sound();
			var sound_channel:SoundChannel = new SoundChannel;
			background_sound.load(new URLRequest(sound));
			sound_channel = background_sound.play();
			var st:SoundTransform = new SoundTransform();
			st.volume = .3;
			sound_channel.soundTransform = st;

			var current_take : BaseTake = takes[takes_index];
			play_take(current_take);
		}
		
		public function play_next_take(e : *) : void {
			takes_index++;
			removeChild(e.target as DisplayObject);
			if (takes_index < takes.length ) {
				play_take(takes[takes_index]);	
			} 
		}
		
		public function play_take(the_take : BaseTake) : void {
			 addChild(the_take);
			 the_take.playIt();
			 the_take.addEventListener('onTakeFinished', play_next_take);
		}
		
		
		public function get takes_index():Number
		{
			return _takes_index;
		}
		
		public function set takes_index(value:Number):void
		{
			_takes_index = value;
		}
		
		public function get takes():Array
		{
			return _takes;
		}

		public function set takes(value:Array):void
		{
			_takes = value;
		}
		
		public function get goodScene():String
		{
			return _goodScene;
		}
		
		public function set goodScene(value:String):void
		{
			_goodScene = value;
		}
		
		public function get regularScene():String
		{
			return _regularScene;
		}
		
		public function set regularScene(value:String):void
		{
			_regularScene = value;
		}
		
		public function get badScene():String
		{
			return _badScene;
		}
		
		public function set badScene(value:String):void
		{
			_badScene = value;
		}
		
		public function get sound():String
		{
			return _sound;
		}
		
		public function set sound(value:String):void
		{
			_sound = value;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
	}
}