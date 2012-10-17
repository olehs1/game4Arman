package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Oleh Smazhnov
	 */
	public class Finish extends FlxSprite
	{
		[Embed(source = "img/level/finish.png")] private var ImgFinish : Class;
		
		public function Finish( x : Number, y : Number ) 
		{
			super( x, y);
			loadGraphic(ImgFinish, true, false, 32, 32);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}

}