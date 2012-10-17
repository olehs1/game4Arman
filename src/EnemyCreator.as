package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import util.RandomNumberHelper;
	
	/**
	 * ...
	 * @author Oleg Smagnov
	 */
	public class EnemyCreator extends FlxSprite
	{
		[Embed(source = "img/level/enemyCreator.png")] private var ImgEnemyCreator : Class;
		
		private var _enemyCreateTime : Number = 2000;
		private var _enemyCreateTimer : FlxDelay;
		
		public function EnemyCreator(x : Number, y : Number) 
		{
			super( x, y);
			loadGraphic(ImgEnemyCreator, true, false, 32, 32);
		}
		
		override public function update():void 
		{
			super.update();
			
			if ( !_enemyCreateTimer ) {
				_enemyCreateTimer = new FlxDelay( _getRandomTime() );
				_enemyCreateTimer.start();
			}
			
			if ( _enemyCreateTimer.hasExpired ) {
				
				createEnemy();
				
				_enemyCreateTimer = new FlxDelay( _getRandomTime() );
				_enemyCreateTimer.start();
			}
		}
		
		private function _getRandomTime():Number
		{
			//return 1000;
			return RandomNumberHelper.randomIntRange( 3000, 6000 );
		}
		
		public function createEnemy():void
		{
			if ( PlayState.getInstance().getPlayer().exists ) {
				//var enemy : Enemy = new Enemy(x, y);
				var enemy : FlxSprite = EnemyFactory.newEnemy('greenEnemy', x, y);
				PlayState.getInstance().getEnemies().add( enemy );	
			}
		}
	}

}