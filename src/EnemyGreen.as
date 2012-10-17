package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import util.RandomNumberHelper;
	/**
	 * ...
	 * @author Oleg Smagnov
	 */
	public class EnemyGreen extends FlxSprite implements Enemy
	{
		[Embed(source = "img/enemy/enemyGreen.png")] private var ImgEnemy : Class;
		//[Embed(source = "img/enemy/redSquare.png")] private var ImgEnemy : Class;
		[Embed(source = "img/enemy/enemyBlood.png")] private var ImgEnemyBlood : Class;
		[Embed(source = "img/enemy/enemyBloodSmall.png")] private var ImgEnemyBloodSmall : Class;
		
		private var _speedX : Number;
		private var _speedY : Number;
		private var _type : String;
		private var _player : FlxSprite = PlayState.getInstance().getPlayer();
		private var _currentLevelTilemap : FlxTilemap = PlayState.getInstance().getCurrentLevelTilemap();
		private var _playerPath;
		private var _barHealth : FlxBar;
		private var _hurtPlayerTimer : FlxDelay;
		private var _scoreValue : Number = 10;
		
		/* 
		 * 	public
		 * */
		public var isTouchingPlayer : Boolean = false;
		public var isPlayerShootingMe : Boolean = false;
		public var damage : Number = 0.5;
		/*
		 * 	type can be:d
		 *	- upDown
		 *  - leftRight
		 * 
		 * */
		public function EnemyGreen(x : Number, y : Number, speedX : Number = 0, speedY : Number = 0, type : String = 'upDown' ) 
		{
			super( x, y);
			
			loadGraphic(ImgEnemy, true, false, 20, 42);
			/*
			addAnimation('goingRight', [5, 5, 13, 13, 9, 9], 30, true);
			addAnimation('goingLeft', [7, 7, 15, 15, 11, 11], 30, true);
			addAnimation('goingStop', [4, 4, 12, 12, 8, 8], 30, true);
			*/
			
			addAnimation('goingRight', [5, 5], 30, true);
			addAnimation('goingLeft', [7, 7], 30, true);
			addAnimation('goingStop', [4, 4], 30, true);
			
			play('goingRight');
			
			
			
			_speedX = speedX;
			_speedY = speedY;
			_type = type;
			
			health = 100;
			
			_barHealth = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, width - 2, 5, this, "health");
			_barHealth.trackParent(1, -6);
			_barHealth.killOnEmpty = true;
			
			PlayState.getInstance().add( _barHealth );
			FlxVelocity.moveTowardsObject(this, _player, 60);	
			//playerFollow();
		}
		
		override public function update():void
		{
			//FlxG.log( FlxVelocity.angleBetween( this, _player ) );
			
			//FlxG.log( velocity.x );
			
			if ( velocity.x > 0 ) {
				play('goingRight');
			} else if( velocity.x == 0 ){
				play('goingStop');
			} else {
				play('goingLeft');
			}
			
			if ( FlxCollision.pixelPerfectCheck( this, _player ) ) {
				_player.hurt(damage);
				FlxG.camera.shake(0.003,0.02);
				velocity.x = 0;
				velocity.y = 0;
			} else {
				FlxVelocity.moveTowardsObject(this, _player, 60);	
			}
			
			super.update();
		}
		
		override public function kill():void 
		{
			if ( RandomNumberHelper.randomIntRange(1, 2) == 1 ) {
				BonusRandomMaker.drawRandomBonus(x, y);
			}
			
			super.kill();
			FlxG.score += _scoreValue;
			_drawBlood();
		}
		
		public function onLevelCollide():void
		{
		}
		
		public function playerFollow():void
		{
			var pathStart:FlxPoint = new FlxPoint(x + width / 2, y +height / 2);
			var pathEnd:FlxPoint = new FlxPoint(_player.x + _player.width / 2, _player.y + _player.height / 2);
			
			// create & follow path
			_playerPath = _currentLevelTilemap.findPath(pathStart, pathEnd);
			
			
			followPath(_playerPath, 200);	
			
		}
		
		
		
		private var _enemyBlood : FlxSprite;
		
		/*
		 * 
		 * */
		private function _drawBlood():void
		{
			_enemyBlood = new FlxSprite(x, y);
			_enemyBlood.loadGraphic(ImgEnemyBlood, true, false, 25, 25);
			_enemyBlood.addAnimation('blood',[RandomNumberHelper.randomIntRange( 0, 3 )]);
			PlayState.getInstance().getEnemyBloods().add(_enemyBlood);
			_enemyBlood.play('blood');
		}
		
		public function drawBloodSmall():void
		{
			_enemyBlood = new FlxSprite(x, y);
			_enemyBlood.loadGraphic(ImgEnemyBloodSmall, true, false, 25, 25);
			_enemyBlood.addAnimation('blood',[RandomNumberHelper.randomIntRange( 0, 3 )]);
			PlayState.getInstance().getEnemyBloods().add(_enemyBlood);
			_enemyBlood.play('blood');
		}
	}

}