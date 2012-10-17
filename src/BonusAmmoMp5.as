package 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	
	internal class BonusAmmoMp5 extends FlxSprite implements Bonus
	{		
		[Embed(source = "img/bonus/ammoMp5.png")] private var ImgAmmoMp5 : Class;
		
		private var ammoAdd : Number = 30;
		
		public function BonusAmmoMp5( x : Number, y : Number )
		{
			super( x, y);
			loadGraphic(ImgAmmoMp5, true, false, 16, 16);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function makeBonus():void
		{
			kill();
			
			PlayState.getInstance().playerWeapon.increaseAmmo( 2, ammoAdd );
			
			FlxG.log( 'doThis BonusBullet mp5' );
		}
	}
	
}