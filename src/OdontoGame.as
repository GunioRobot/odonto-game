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
		private var mainXML:XML;
		
		public function OdontoGame()
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest("../script.xml"));
			
			function onComplete(evt:Event) : void
			{

				mainXML = new XML(loader.data)
				var first_scene_id:String = mainXML.attribute("first");
				var first_scene:BaseScene = new BaseScene(mainXML.scene.(@id==first_scene_id)[0]);
				first_scene.addEventListener(BaseScene.ON_COMPLETE, on_complete_scene);

				addChild(first_scene);
				
				first_scene.playIt();
			}
			
		}
		
		public function on_complete_scene(e:Event) : void {
				var current_scene:BaseScene = e.target as BaseScene;
				var next_scene_id:String = current_scene.next_scene();
				var scene_xml:XML = mainXML.scene.(@id==next_scene_id)[0];
				trace("-------------- NEXT SCENE XML ---------------");
				trace(scene_xml);
				var next_scene:BaseScene = new BaseScene(scene_xml);
				next_scene.addEventListener(BaseScene.ON_COMPLETE, on_complete_scene);
				
				trace("carregando a cena " + next_scene_id);
				
				removeChild(current_scene);
				addChild(next_scene);
				
				next_scene.playIt()
				
		}
	}
}