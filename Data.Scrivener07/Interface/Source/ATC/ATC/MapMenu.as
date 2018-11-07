package
{
	import Components.TextureLoader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import Shared.AS3.Debug;
	import Shared.AS3.Utility;

	public class MapMenu extends MovieClip
	{
		public static const MenuName:String = "ATC_MapMenu";

		public var Texture:TextureLoader;
		public static const TextureMountID:String = "ATC_WorldMap";

		private const WorldMap_DLC0:String = "Interface\\Pip-Boy\\WorldMap_d.dds";


		// MapMenu
		//---------------------------------------------

		public function MapMenu()
		{
			Debug.WriteLine("[ATC]", "[MapMenu]", "(ctor)", "Constructor Code");
			Texture.MenuName = MenuName;
			Texture.ImageMountID = TextureMountID;
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			Texture.addEventListener(TextureLoader.CODEOBJECT_READY, this.OnCodeObjectReady);
			Texture.addEventListener(TextureLoader.LOAD_COMPLETE, this.OnLoadComplete);
			Texture.addEventListener(TextureLoader.LOAD_ERROR, this.OnLoadError);
		}


		private function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("[ATC]", "[MapMenu]", "(OnAddedToStage)");
		}


		private function OnCodeObjectReady(e:Event):void
		{
			Debug.WriteLine("[ATC]", "[MapMenu]", "(OnCodeObjectReady)", "Loading:"+WorldMap_DLC0);
			Texture.Load(WorldMap_DLC0);
		}


		private function OnLoadComplete(e:Event):void
		{
			Debug.WriteLine("[ATC]", "[MapMenu]", "(OnLoadComplete)");
			Utility.ScaleToHeight(Texture, 600);
		}


		private function OnLoadError(e:IOErrorEvent):void
		{
			Debug.WriteLine("[ATC]", "[MapMenu]", "(OnLoadError)", "Error:"+e.toString());
		}


	}
}
