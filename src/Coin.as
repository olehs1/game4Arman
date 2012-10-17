package  
{
	import org.flixel.*;
	import util.RandomNumberHelper;
	/**
	 * ...
	 * @author ...
	 */
	public class Coin extends FlxSprite
	{
		[Embed(source = "img/coin/120px-Coin_sprites.png")]
		
		private var ImgCoin : Class;
		private var _speed : Number;
		
		public function Coin( x : Number, y : Number, speed : Number = -200 ) 
		{
			super( x, y );
			
			_speed = speed;
			
			loadGraphic(ImgCoin, true, false, 32, 32);
		}
		
		override public function update():void
		{
			velocity.y = _speed;
			
			if ( y > FlxG.stage.height ) {
				kill();
			}
			super.update();
		}
		
	}

}