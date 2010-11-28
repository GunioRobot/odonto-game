package com.nakand.core
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		
		private var loaded_image : Loader;
		private var loaded_sound : SoundChannel = new SoundChannel();

		public function BaseItem()
		{
			super();
		}
		
		public function construct() : void {
			trace('construindo item');
			//add the image of this take
			loaded_image = new Loader();
			loaded_image.load(new URLRequest(image));
			loaded_image.addEventListener(MouseEvent.MOUSE_OVER, on_mouse_over);
			loaded_image.addEventListener(MouseEvent.MOUSE_OUT, on_mouse_out);
			addChild(loaded_image);
			loaded_image.scaleX = loaded_image.scaleY = .5;
			
			// then the sound
			/*
			var background_sound:Sound = new Sound();
			var sound_channel:SoundChannel = new SoundChannel;
			background_sound.load(new URLRequest(sound));
			sound_channel = background_sound.play();
			*/
		}
		
		public function on_mouse_over(e : MouseEvent) : void {
			var mouse_over_sound:Sound = new Sound();
			mouse_over_sound.load(new URLRequest(sound));
			loaded_sound = mouse_over_sound.play();
			loaded_sound.addEventListener(Event.SOUND_COMPLETE, on_sound_complete);
			loaded_image.removeEventListener(MouseEvent.MOUSE_OVER, on_mouse_over);
		}
		
		public function on_mouse_out(e : MouseEvent) : void {
			loaded_sound.stop();
			loaded_image.addEventListener(MouseEvent.MOUSE_OVER, on_mouse_over);
			
		}
		
		public function on_sound_complete(e : Event) : void {
			loaded_image.addEventListener(MouseEvent.MOUSE_OVER, on_mouse_over);
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