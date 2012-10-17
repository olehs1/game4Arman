package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Oleh Smazhnov
	 */
	public class MenuItem extends FlxSprite
	{
		[Embed(source = "img/menu/menuTile.png")] private var ImgMenu : Class;
		
		private var _menuType : Number;
		private var playStateInstance : PlayState = PlayState.getInstance();
		
		public function MenuItem( menuType : Number , x : Number, y : Number)
		{
			_menuType = menuType;
			//FlxG.log( 'menu item ' + _menuType + ' is set' );
			
			
			super(x, y);
			loadGraphic(ImgMenu, true, false, 192, 32);
			
			addAnimation('menu', [_menuType], 30, true );
			play('menu');
		}
		
		override public function update():void
		{
			//menuUpdateAnimationOnHover();
			menuUpdateAnimationOnClick();
			super.update();
		}
		
		public function hover(x:Number, y:Number, width:int, height:int):Boolean {
			var mx:int = FlxG.mouse.screenX;
			var my:int = FlxG.mouse.screenY;
			return ( (mx > x) && (mx < x + width) ) && ( (my > y) && (my < y + height) );
		}
		
		/*
		 *  on hover
		 * */
		public function menuUpdateAnimationOnHover():void
		{
			if (hover(x, y, width, height)) 
			{
				//FlxG.log('hover');
					// change animation
			}
		}
		
		/*
		 * on click
		 * */
		public function menuUpdateAnimationOnClick():void
		{
			if ( FlxG.mouse.justReleased() && hover(x, y, width, height) ) {
				
				FlxG.log('mouse down on menu ' + _menuType);
				doMenuFunction( _menuType );
			}
		}
		
		/*
		 * 0 - new game
		 * 1 - select level
		 * 2 - more games
		 * 
		 * */
		public function doMenuFunction( menuType : Number ):void
		{
			switch( menuType ) {
				case 0:
					playStateInstance.setCurrentLevelNumber(1);
					playStateInstance.goToNextLevel();
				break;
				case 1:
					playStateInstance.setCurrentLevelNumber( playStateInstance.getSelectLevelNumber() );
					playStateInstance.goToNextLevel();
				break;
				case 2:
					FlxG.log('MORE GAMES MAN');
				break;
				default:
				break;
			}
		}
	}

}