package com.nakand.core {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	public class BaseTake extends Sprite {
		
		private var _id : String;
		private var _image : String;
		private var _sound : String;
		
		private var _modals : Array;
		
		private var _modals_index : Number = 0;
		
		private var finished : Boolean = false;
		
		public function BaseTake(take_xml:XML){
			super();
			this.id		= take_xml.attribute('id');
			this.image 	= take_xml.attribute('image_path');
			this.sound 	= take_xml.attribute('sound_path');
			this.modals = new Array();
			for each(var modal_xml:XML in take_xml.modal) {
				var base_modal:BaseModal = new BaseModal(modal_xml);
				this.modals.push(base_modal);
			}
		}

		public function playIt() : void {
			//add the image of this take
			var loader : Loader = new Loader();
			loader.load(new URLRequest(image));
			addChild(loader);
			
			// then the sound
			var background_sound:Sound = new Sound();
			var sound_channel:SoundChannel = new SoundChannel;
			background_sound.load(new URLRequest(sound));
			sound_channel = background_sound.play();
			
			trace('Playing take ' + id);
			sound_channel.addEventListener(Event.SOUND_COMPLETE, finish_take);
		}
		
		// finish the take and start modals if any
		public function finish_take(e:Event) : void {
			
			if (modals.length > 0) {
				trace('existem ' + modals.length + ' modais a serem exibidos');
				show_modal(modals[modals_index]);
			} else {
				trace('não existem modais');
				dispatch_finished_event();
			}
		}
		
		public function dispatch_finished_event() : void {
			dispatchEvent(new Event('onTakeFinished'));		
		}	
		
		public function show_next_modal(e : *) : void {
			modals_index++;
			removeChild(e.target as DisplayObject);
			if (modals_index < modals.length ) {
				show_modal(modals[modals_index]);	
			} else {
				dispatch_finished_event();
			}
		}
		
		public function show_modal(the_modal : BaseModal) : void {
			the_modal.x = the_modal.y = 20;
			addChild(the_modal);
			the_modal.show_it();
			the_modal.addEventListener('onModalFinished', show_next_modal);
		}	
		
		public function get modals_index():Number
		{
			return _modals_index;
		}
		
		public function set modals_index(value:Number):void
		{
			_modals_index = value;
		}

		
		public function get modals():Array
		{
			return _modals;
		}
		
		public function set modals(value:Array):void
		{
			_modals = value;
		}
		
		public function get sound():String
		{
			return _sound;
		}
		
		public function set sound(value:String):void
		{
			_sound = value;
		}
		
		public function get image():String
		{
			return _image;
		}
		
		public function set image(value:String):void
		{
			_image = value;
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