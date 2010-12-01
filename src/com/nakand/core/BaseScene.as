package com.nakand.core {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class BaseScene extends Sprite {
		
		public static const ON_COMPLETE : String = "onSceneComplete";
		
		private var _id : String;
		private var _sound : String;
		private var _regularScene : String;
		private var _final : Boolean = false;
		
		private var _score : Number = 0;
		
		private var _rules : Dictionary;
		private var _sorted_rule_values : Array;
		
		private var _takes : Array;
		private var _takes_index : Number = 0;
		
		private var loaded_sound:SoundChannel = new SoundChannel();
		
		public function BaseScene(scene_xml:XML) {
			super();
			this.id 			= scene_xml.attribute('id');
			this.sound 			= scene_xml.attribute('sound_path');
			this.regular_scene	= scene_xml.attribute('regular');
			trace("'@final' in scene_xml " + ("@final" in scene_xml));
			if("@final" in scene_xml) {
				this._final = scene_xml.@final;
			}
			
			trace("this._final -> " + this._final);
			
			_rules = new Dictionary();
			_sorted_rule_values = new Array();
			
			for each (var rule:XML in scene_xml.rules.rule) {
				var value:String = rule.@value;
				_rules[value] = rule.@scene;
				_sorted_rule_values.push(value);
			}
			
			for (var r:Object in _rules) {
				trace(r + " = " + _rules[r]);
			}
			
			_sorted_rule_values.sort(sortOnNumber);
			
			trace("_sorted_rule_values -> "+ _sorted_rule_values);
			
			this.takes = new Array();
			for each (var take:XML in scene_xml.take ) {
				trace('loop take');
				var base_take:BaseTake = new BaseTake(take);
				this.takes.push(base_take);
			}
			
			addEventListener(Event.REMOVED_FROM_STAGE, on_removed_from_stage);
			
		}
		
		private function on_removed_from_stage(e:Event):void {
			loaded_sound.stop();
		}
		
		private function sortOnNumber(a:Number, b:Number):Number {
			if(a > b) {
				return 1;
			} else if(a < b) {
				return -1;
			} else  {
				return 0;
			}
		}


		public function playIt() : void {
			//add the sound of this scene
			var background_sound:Sound = new Sound();
			background_sound.load(new URLRequest(sound));
			loaded_sound = background_sound.play();
			var st:SoundTransform = new SoundTransform();
			st.volume = .15;
			loaded_sound.soundTransform = st;

			var current_take : BaseTake = takes[_takes_index];
			play_take(current_take);
		}
		
		public function play_next_take(e : *) : void {
			_takes_index++;
			var take:BaseTake = e.target as BaseTake;
			this._score += take.score;
			removeChild(take);
			if (_takes_index < takes.length ) {
				play_take(takes[_takes_index]);	
			} else {
				dispatch_complete_event();
			}
		}
		
		private function dispatch_complete_event() : void {
			dispatchEvent(new Event(ON_COMPLETE));	
		}
		
		public function play_take(the_take : BaseTake) : void {
			 addChild(the_take);
			 the_take.playIt();
			 the_take.addEventListener('onTakeFinished', play_next_take);
		}
		
		public function next_scene() : String {
			var next_scene_id:String = null;
			
			for each (var rule_value:Number in _sorted_rule_values){
				if(_score <= rule_value) {
					next_scene_id = _rules[rule_value];
					break;
				}
			}
			
			if(next_scene_id == null) {
				next_scene_id = regular_scene;
			}
			
			return next_scene_id;
		}
		
		
		public function get takes():Array
		{
			return _takes;
		}

		public function set takes(value:Array):void
		{
			_takes = value;
		}
		
		public function get regular_scene():String
		{
			return _regularScene;
		}
		
		public function set regular_scene(value:String):void
		{
			_regularScene = value;
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
		
		public function is_final() : Boolean {
			return _final;
		}

	}
}