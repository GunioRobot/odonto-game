package com.nakand.core {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BaseModal extends Sprite {
		
		private var _id : String;
		private var _sound : String;
		private var _type : String;
		private var _score : Number;
		
		private var _items : Array;
		
		
		public function BaseModal(modal_xml:XML) {
			super();
			this.id 	= modal_xml.attribute('id');
			this.sound	= modal_xml.attribute('sound_path');
			this.type	= modal_xml.attribute('type');
			this.score = 0;

			this.items = new Array();
			for each (var item_xml:XML in modal_xml.item) {
				var base_item:BaseItem = new BaseItem(item_xml);
				this.items.push(base_item);
			}
		}

		public function show_it() : void {
			for each (var item : BaseItem in items) {
				addChild(item);
				item.addEventListener(MouseEvent.CLICK, on_click_item);
				item.construct();
			}
		}
		
		public function finish_modal(e : Event) : void {
			
		}
		
		public function dispatch_finished_event() : void {
			dispatchEvent(new Event("onModalFinished"));
		}
		
		public function on_click_item(e : MouseEvent) : void {
			var item:BaseItem = e.target.parent as BaseItem;
			this.score += item.value;
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

		public function get score():int
		{
			return _score;
		}

		public function set score(value:int):void
		{
			_score = value;
		}

		
	}
}