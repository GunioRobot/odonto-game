package com.nakand.core
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class BaseItem extends Sprite
	{
		private var _image : String;
		private var _sound : String;
		private var _label : String;
		private var _option : String;
		private var _points : Number;

		public function BaseItem()
		{
			super();
		}
		
		public function construct() : void {
			trace('construindo item');
			//add the image of this take
			var loader : Loader = new Loader();
			loader.load(new URLRequest(image));
			addChild(loader);
			loader.scaleX = loader.scaleY = .25;
			
			// then the sound
			/*
			var background_sound:Sound = new Sound();
			var sound_channel:SoundChannel = new SoundChannel;
			background_sound.load(new URLRequest(sound));
			sound_channel = background_sound.play();
			*/
			
		}

		public function get image():String
		{
			return _image;
		}

		public function set image(value:String):void
		{
			_image = value;
		}

		public function get sound():String
		{
			return _sound;
		}

		public function set sound(value:String):void
		{
			_sound = value;
		}

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}

		public function get option():String
		{
			return _option;
		}

		public function set option(value:String):void
		{
			_option = value;
		}

		public function get points():Number
		{
			return _points;
		}

		public function set points(value:Number):void
		{
			_points = value;
		}

	}
}