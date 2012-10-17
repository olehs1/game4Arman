package  
{
	/**
	 * ...
	 * @author Oleh Smazhnov
	 */
	public class EnemyFactory 
	{
		public function EnemyFactory() {}
		
		public static function newEnemy( type : String, x : Number, y : Number  )
		{
			switch( type )
			{
				case 'enemyGreen':
					return new EnemyGreen( x, y );
				break;
				case 'enemyRed':
					return new EnemyRed( x, y );
				break;
			}
		}
		
	}

}