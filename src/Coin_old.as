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
		
		public function Coin( x : Number, y : Number, speed : Number = -200 ) 
		{
			super( x, y );
			loadGraphic(ImgCoin, true, false, 30, 30);
			
			/*
			 * 	Make 5 for example start animation
			 * */
			var randomizer : Number = RandomNumberHelper.randomIntRange(0, 4);
			switch( randomizer ) {
				case 0:
					addAnimation('rotate', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 30, true);	
				break;
				case 1:
					addAnimation('rotate', [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2], 30, true);
				break;
				case 2:
					addAnimation('rotate', [8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7 ], 30, true);
				break;
				case 3:
					addAnimation('rotate', [13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], 30, true);
				break;
				case 4:
					addAnimation('rotate', [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4], 30, true);
				break;
			}
			
			scale.x = 1.5;
			scale.y = 1.5;
			
			//velocity.y = speed;
			
			play('rotate');
		}
		
		override public function update():void
		{
			if ( y > FlxG.stage.height ) {
				x = Math.random() * FlxG.stage.width;
				y = 0 - height;
			}
			super.update();
		}
		
	}

}