package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Oleh Smazhnov
	 */
	public class LevelIcon extends FlxSprite
	{
		[Embed(source = "img/iconLevel/iconLevelTile.png")] private var ImgPlayer : Class;
		
		private var _levelNumber : Number;
		private var playStateInstance : PlayState = PlayState.getInstance();
		
		public function LevelIcon( levelNumber : Number , x : Number, y : Number) :void
		{
			_levelNumber = levelNumber;
			//FlxG.log( 'level icon ' + _levelNumber + ' is set' );
			
			
			super(x, y);
			loadGraphic(ImgPlayer, true, false, 64, 64);
			
			addAnimation('level', [_levelNumber - 1], 30, true );
			play('level');
			
			
		}
		
		override public function update():void
		{
			super.update();
			levelUpdateAnimationOnClick();
		}
		
		public function hover(x:Number, y:Number, width:int, height:int):Boolean {
			var mx:int = FlxG.mouse.screenX;
			var my:int = FlxG.mouse.screenY;
			return ( (mx > x) && (mx < x + width) ) && ( (my > y) && (my < y + height) );
		}
		
		/*
		 *  on hover
		 * */
		public function lavelUpdateAnimationOnHover():void
		{
			if (hover(x, y, width, height)) 
			{
				FlxG.log('hover');
				// change animation
			}
		}
		
		/*
		 * on click
		 * */
		public function levelUpdateAnimationOnClick():void
		{
			if ( FlxG.mouse.justReleased() && hover(x, y, width, height) ) {
				FlxG.log('mouse down on level ' + _levelNumber);
				playStateInstance.setCurrentLevelNumber( _levelNumber );
				playStateInstance.goToNextLevel();
			}
		}
		
	}

}