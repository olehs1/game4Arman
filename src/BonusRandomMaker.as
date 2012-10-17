package  
{
	import org.flixel.*;
	import util.*;
	
	public class BonusRandomMaker 
	{
		private static var randomBonusType : Number;
		
		/*
		private static var bonusType : Array = [
			'bullet',
			'bomb'
		];*/
		
		public static function drawRandomBonus( x : Number, y : Number ):void
		{
			//randomBonusType = 1;
			randomBonusType = RandomNumberHelper.randomIntRange(1, 3);
			
			switch( randomBonusType ) {
				case 1 :
					var bonusAmmoGun : BonusAmmoGun = new BonusAmmoGun( x, y );
					PlayState.getInstance().getBonuses().add( bonusAmmoGun );			
				break;
				case 2 :
					var bonusAmmoMp5 : BonusAmmoMp5 = new BonusAmmoMp5( x, y );
					PlayState.getInstance().getBonuses().add( bonusAmmoMp5 );			
				break;
				case 3 :
					var bonusLive : BonusLive = new BonusLive( x, y );
					PlayState.getInstance().getBonuses().add( bonusLive );			
				break;
				default : 
				
				break;
			}
		}
	}

}