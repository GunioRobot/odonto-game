package
{
	import com.nakand.core.BaseItem;
	import com.nakand.core.BaseModal;
	import com.nakand.core.BaseScene;
	import com.nakand.core.BaseTake;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	[SWF(width=1024, height=600, backgroundColor='#000000', frameRate=30)]
	
	public class OdontoGame extends Sprite
	{
		public function OdontoGame()
		{
			var mainXML:XML;
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest("../script.xml"));
			
			function onComplete(evt:Event) : void
			{

				mainXML = new XML(loader.data)
				var first_scene_node:XML = mainXML..scene[0];
				var first_scene:BaseScene = new BaseScene(first_scene_node);

				addChild(first_scene);
				
				first_scene.playIt();
			}

		}
	}
}