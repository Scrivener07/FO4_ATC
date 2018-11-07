package
{
	import Components.TextureLoader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import Shared.AS3.Debug;
	import Shared.AS3.Utility;

	public class MapMenu extends MovieClip
	{
		public static const MenuName:String = "ATC_MapMenu";

		public var Texture:TextureLoader;
		public static const TextureMountID:String = "ATC_WorldMap";

		private const WorldMap_DLC0:String = "Interface\\Pip-Boy\\WorldMap_d.dds";

		private var Drawing:Shape;
		private var Points:Vector.<Point>


		// MapMenu
		//---------------------------------------------

		public function MapMenu()
		{
			Debug.WriteLine("[ATC]", "[MapMenu]", "(ctor)", "Constructor Code");
			Texture.MenuName = MenuName;
			Texture.ImageMountID = TextureMountID;
			Points = new Vector.<Point>();
			this.addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
			Texture.addEventListener(TextureLoader.CODEOBJECT_READY, this.OnCodeObjectReady);
			Texture.addEventListener(TextureLoader.LOAD_COMPLETE, this.OnLoadComplete);
			Texture.addEventListener(TextureLoader.LOAD_ERROR, this.OnLoadError);
		}


		private function OnAddedToStage(e:Event):void
		{
			Debug.WriteLine("[ATC]", "[MapMenu]", "(OnAddedToStage)");
			Drawing = new Shape();
			Drawing.graphics.lineStyle(1, 0xFF0000, 1);
			addChild(Drawing);
		}


		// Texture
		//---------------------------------------------

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


		// Methods
		//---------------------------------------------

		public function SetData(argument:Object, ... rest):void
		{
			Points = new Vector.<Point>();
			if (argument != null)
			{
				AddPoint(ToPoint(argument));
				if (rest != null)
				{
					for (var i:uint = 0; i < rest.length; i++)
					{
						AddPoint(ToPoint(rest[i]));
					}
				}
				Debug.WriteLine("[ATC]", "[MapMenu]", "(SetData)", "Count:"+Points.length);
			}
			else
			{
				Debug.WriteLine("[ATC]", "[MapMenu]", "(SetData)", "Argument was null!");
			}
		}


		private function AddPoint(value:Point):Boolean
		{
			if(Points.length == 0)
			{
				Drawing.graphics.moveTo(value.x, value.y);
				Points.push(value);
				return true;
			}
			else if(Points.length > 0)
			{
				Drawing.graphics.lineTo(value.x, value.y);
				Points.push(value);
				return true;
			}
			else
			{
				Debug.WriteLine("[ATC]", "[MapMenu]", "(AddPoint)", "Something went wrong.");
				return false;
			}
		}


		private function ToPoint(value:Object):Point
		{
			Debug.TraceObject(value);
			var xValue:Number = Number(value["__struct__"]["__data__"]["X"]);
			var yValue:Number = Number(value["__struct__"]["__data__"]["Y"]);
			return new Point(xValue, yValue);
		}


	}
}
