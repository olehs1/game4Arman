package 
{
	import org.flixel.*;
	import flash.events.MouseEvent;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	/**
	 * ...
	 * @author
	 */
	public class Player extends FlxSprite 
	{
		// images
		[Embed(source = "img/player/dudeLeftRight.png")] private var ImgPlayer : Class;
		[Embed(source = "img/bullet/bullet_green_small.png")] private var ImgBullet : Class;
		
		// sounds
		//[Embed(source="sounds/weapon/gun/GUN_FIRE-GoodSoundForYou-820112263.mp3")] protected var SndGunShoot:Class;
		
		
		private var _livesCount : Number = 3;
		private var _lives : FlxGroup;
		private static var _defaultX : Number;
		private static var _defaultY : Number;
		
		public var speed : Number = 100;
		
		private var _barHealth : FlxBar;
		private var _playState : PlayState = PlayState.getInstance();
		
		private var _weaponText : FlxText = new FlxText(10, 10, 200, 'weapon: ');
		private var _ammoText : FlxText = new FlxText(200, 10, 200, 'ammo: ');
		private var _healthText : FlxText = new FlxText(300, 10, 200, 'health: ');
		private var _experienceText : FlxText = new FlxText(450, 10, 200, 'experience: ');
		
		private var _enemyBlood : FlxGroup = new FlxGroup();
		/*
		 * 
		 * */ 
		public var isTouchingEnemy : Boolean = false;
		public static var isTouchEnemyLeft : Boolean = false;
		
		private var _currentWeapon : Number;
		
		public function Player( x : Number, y : Number ):void
		{
			super( x, y);
			
			health = 100;
			
			FlxG.score = 0;
			
			_playState.add(_enemyBlood);
			
			var messageBox1 : MessageBox = new MessageBox(this, "What the?!...", 2000, 500);
			var messageBox2 : MessageBox = new MessageBox(this, "Get the gun!\n Quick!", 2000, 2500);
			
			
			loadGraphic(ImgPlayer, true, false, 18, 36);
			
			addAnimation('left', [0]);
			addAnimation('right', [1]);
			
			_addBarHealth();
			
			_addPlayerText();
			play('left');
		}
		
		public function bullet2level( bullet : FlxSprite, level : FlxTilemap ):void
		{
			bullet.kill();
		}
		
		public function emitter2levelCollide( emitter : FlxParticle, level : FlxTilemap ):void
		{
			emitter.velocity.x = 0;
			emitter.velocity.y = 0;
			emitter.lifespan = 0;
		}
		
		/*
		 * 
		 * */
		override public function update():void
		{
			//FlxG.log( 'CURRENT_WEAPON ' + PlayState.getInstance().playerWeapon.CURRENT_WEAPON );
			
			_updatePlayerText();
			
			_movingListener();
			
			_shootingListener();
			
			_playerCollisions();
			
			PlayState.getInstance().playerWeapon.changeWeaponListener();
			
			super.update();
		}
		
		/*
		 * 
		 * */
		private  function _addBarHealth():void
		{
			_barHealth = new FlxBar(0, 0, FlxBar.FILL_LEFT_TO_RIGHT, width, 5, this, "health");
			_barHealth.trackParent( 0, -6);
			_barHealth.killOnEmpty = true;
			
			_playState.add( _barHealth );
		}
		
		private function _addPlayerText():void
		{
			_weaponText.setFormat(null, 12,0x000000);
			_ammoText.setFormat(null, 12,0x000000);
			_healthText.setFormat(null, 12,0x000000);
			_experienceText.setFormat(null, 12,0x000000);
			
			PlayState.getInstance().add( _weaponText );
			PlayState.getInstance().add( _ammoText );
			PlayState.getInstance().add( _healthText );
			PlayState.getInstance().add( _experienceText );
			
		}
		
		private function _updatePlayerText():void
		{
			_healthText.text = 'health: ' + health + "%";
			_ammoText.text = 'ammo: ' + PlayState.getInstance().playerWeapon.getCurrentWeaponAmmo();
			_weaponText.text = 'weapon: ' + PlayState.getInstance().playerWeapon.getCurrentWeaponName();
			_experienceText.text = 'experience: ' + FlxG.score;
		}
		
		/*
		 * 
		 * */
		private function _playerCollisions():void
		{

			FlxG.collide( _playState.playerWeapon.gun.group , _playState.getCurrentLevelTilemap(), bullet2level );
			FlxG.collide( _playState.playerWeapon.mp5.group , _playState.getCurrentLevelTilemap(), bullet2level );
			
			FlxG.collide( _playState.playerWeapon.gun.group, _playState.getEnemies(), PlayState.getInstance().playerWeapon.bullet2enemyCollision );
			FlxG.collide( _playState.playerWeapon.mp5.group, _playState.getEnemies(), PlayState.getInstance().playerWeapon.bullet2enemyCollision );
			
			FlxG.collide( _enemyBlood, _playState.getCurrentLevelTilemap(), emitter2levelCollide );
		}
		
		/*
		 * 	Player moving listener
		 * */
		private function _movingListener():void
		{
			velocity.x = 0;
			velocity.y = 0;
			
			if ( ( FlxG.keys.pressed("S") || FlxG.keys.pressed("DOWN") ) && !isTouching(FlxObject.DOWN)  ) {
				velocity.y += speed;
			}
			if ( ( FlxG.keys.pressed("W") || FlxG.keys.pressed("UP") ) && !isTouching(FlxObject.UP)) {
				velocity.y -= speed;
			}
			if ( ( FlxG.keys.pressed("A") || FlxG.keys.pressed("LEFT") ) && !isTouching(FlxObject.LEFT) ) {
				play('left');
				velocity.x -= speed;
			}
			if ( ( FlxG.keys.pressed("D") || FlxG.keys.pressed("RIGHT") ) && !isTouching(FlxObject.RIGHT) ) {
				play('right');
				velocity.x += speed;
			}
			
			if ( x < 0  ) {
				x = 0;
			}
			if ( y < 0 ) {
				y = 0;
			}
			if ( x + width > FlxG.stage.width ) {
				x = FlxG.stage.width - width ;
			}
			// 92 - wtf?!
			if ( y + height > FlxG.stage.height - 92 ) {
				y = FlxG.stage.height - height - 92 ;
			}
		}
		
		/*
		 * 	Shooting listener
		 * */
		private function _shootingListener():void
		{
			if (FlxG.mouse.pressed() && PlayState.getInstance().playerWeapon.PLAYER_HAVE_SOME_WEAPON )
			{
				PlayState.getInstance().playerWeapon.shoot();
			}
		}
	}
	
}
