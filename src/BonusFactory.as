package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Oleg Smagnov
	 */
	public class BonusFactory 
	{
		
		public function BonusFactory() {}

		public static function newBonus( type : String, x : Number, y : Number )
		{
			switch( type )
			{
				case 'live':
					return new BonusLive( x, y );
				break;
				case 'ammoGun':
					return new BonusAmmoGun( x, y );
				break;
				case 'ammoMp5':
					return new BonusAmmoMp5( x, y );
				break;
			}
		}
	}

}