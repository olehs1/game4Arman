package  
{
	import org.flixel.*;

	public class Live extends FlxSprite
	{
		[Embed(source = "img/player/animation001.png")]
		
		private var ImgLive : Class;
		
		public function Live( x: Number, y : Number ):void 
		{
			super( x, y);
			scale.x = 0.3;
			scale.y = 0.3;
			
			loadGraphic(ImgLive, true, false, 120, 120);
			width = 26;
			height = 26;
			offset.x = 45;
			offset.y = 45;
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}