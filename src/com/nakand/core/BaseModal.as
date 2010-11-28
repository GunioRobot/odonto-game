package com.nakand.core {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import sweatless.graphics.SmartRectangle;
	
	public class BaseModal extends Sprite {
		
		private static const ITEM_SIZE : Number = 150;
		private static const MARGIN : Number = 25;
		
		private var _id : String;
		private var _sound : String;
		private var _type : String;
		
		private var _items : Array;
		
		private var loaded_sound : SoundChannel = new SoundChannel();
		
		public function BaseModal(modal_xml:XML) {
			super();
			this.id 	= modal_xml.attribute('id');
			this.sound	= modal_xml.attribute('sound_path');
			this.type	= modal_xml.attribute('type');

			this.items = new Array();
			for each (var item_xml:XML in modal_xml.item) {
				var base_item:BaseItem = new BaseItem(item_xml);
				this.items.push(base_item);
			}
		}

		public function show_it() : void {
			// load the sound
			var background_sound:Sound = new Sound();
			loaded_sound = new SoundChannel;
			background_sound.load(new URLRequest(sound));
			loaded_sound = background_sound.play();
			
			// will set the modal size
			var modal_width : Number;
			var modal_height : Number;
			if (items.length <= 3) {
				modal_width 	= ITEM_SIZE + (MARGIN * 2);
				modal_height 	= ITEM_SIZE * items.length + (MARGIN * (items.length + 1));
			} else {
				var total_items : Number = items.length;
				var total_columns : Number = Math.floor(total_items / 3);
				if (total_items % 3 != 0) total_columns++;
				modal_width  = ITEM_SIZE * total_columns + (MARGIN * (total_columns + 1));
				modal_height = ITEM_SIZE * 3 + (MARGIN * 4);
			}
			
			// then build the modal
			var bg_shape : SmartRectangle = new SmartRectangle(modal_width, modal_height);
			addChild(bg_shape);
			bg_shape.colors = [0x000000];
			bg_shape.alpha = .5;
			bg_shape.bothCorners = 15;
			
			// positionate items through modal
			var i : Number = 0;
			var item_x : Number = MARGIN;
			for each (var item : BaseItem in items) {
				addChild(item);
				item.y = i * ITEM_SIZE + (MARGIN * (i + 1)); 
				item.x = item_x;
				item.addEventListener(MouseEvent.CLICK, on_click);
				item.construct();
				if (i == 2) {
					i = 0;
					item_x += ITEM_SIZE + MARGIN;
				} else {
					i++;
				}
			}
			
		}
		
		public function finish_modal(e : Event) : void {
			
		}
		
		public function dispatch_finished_event() : void {
			dispatchEvent(new Event("onModalFinished"));
		}
		
		public function on_click(e : MouseEvent) : void {
			trace(e.target.parent.label as String);
			loaded_sound.stop();
			dispatch_finished_event();
		}
		
		public function get items():Array
		{
			return _items;
		}
		
		public function set items(value:Array):void
		{
			_items = value;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
		}
		
		public function get sound():String
		{
			return _sound;
		}
		
		public function set sound(value:String):void
		{
			_sound = value;
		}
		
	}
}