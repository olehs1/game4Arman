package 
{
	import org.flixel.*;
	
	internal class BonusLive extends FlxSprite implements Bonus 
	{
		[Embed(source = "img/bonus/drugs.png")] private var ImgLive : Class;
		
		private var healthAdd : Number = 25;
		
		public function BonusLive( x : Number, y : Number ) 
		{
			super( x, y);
			loadGraphic(ImgLive, true, false, 16, 16);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function makeBonus():void
		{
			kill();
			
			PlayState.getInstance().getPlayer().health += healthAdd;
			if ( PlayState.getInstance().getPlayer().health > 100 ) {
				PlayState.getInstance().getPlayer().health = 100;
			}
		}
	}
	
}