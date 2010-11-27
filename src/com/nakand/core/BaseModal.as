package com.nakand.core {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BaseModal extends Sprite {
		
		private var _id : String;
		private var _order : String;
		private var _type : String;
		
		public function BaseModal(){
			super();
		}
		
		public function show_it() : void {
			if (type == "foods") {
				
			} else {
				
			}
		}
		
		public function finish_modal(e : Event) : void {
			
		}
		
		public function dispatch_finished_event() : void {
			dispatchEvent(new Event("onModalFinished"));
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function get order():String
		{
			return _order;
		}
		
		public function set order(value:String):void
		{
			_order = value;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
		}
		
	}
}