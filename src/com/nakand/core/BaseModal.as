package com.nakand.core {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BaseModal extends Sprite {
		
		private var _id : String;
		private var _sound : String;
		private var _type : String;
		
		private var _items : Array;
		
		
		public function BaseModal(){
			super();
		}

		public function show_it() : void {
			for each (var item : BaseItem in items) {
				addChild(item);
				item.addEventListener(MouseEvent.CLICK, on_click);
				item.construct();
			}
		}
		
		public function finish_modal(e : Event) : void {
			
		}
		
		public function dispatch_finished_event() : void {
			dispatchEvent(new Event("onModalFinished"));
		}
		
		public function on_click(e : MouseEvent) : void {
			trace(e.target.parent.label as String);
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