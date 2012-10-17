package 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	
	internal class BonusAmmoGun extends FlxSprite implements Bonus
	{		
		[Embed(source = "img/bonus/ammoGun.png")] private var ImgAmmoGun : Class;
		
		private var ammoAdd : Number = 10;
		
		public function BonusAmmoGun( x : Number, y : Number )
		{
			super( x, y);
			loadGraphic(ImgAmmoGun, true, false, 12, 13);
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function makeBonus():void
		{
			kill();
			
			PlayState.getInstance().playerWeapon.increaseAmmo( 1, ammoAdd );
			
			FlxG.log( 'doThis BonusBullet gun' );
		}
	}
	
}