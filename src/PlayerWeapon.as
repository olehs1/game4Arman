package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	
	/**
	 * ...
	 * @author Oleg Smagnov
	 */
	public class PlayerWeapon 
	{
		[Embed(source = "img/weapon/gun.png")] private var ImgGun : Class;
		[Embed(source = "img/weapon/mp5.png")] private var ImgMp5 : Class;
		[Embed(source = "img/bullet/bullet_green_small.png")] private var ImgBullet : Class;
		
		public var gunSprite : FlxSprite;
		public var mp5Sprite : FlxSprite;
		
		public var gun : FlxWeapon = new FlxWeapon("gun");
		public var mp5 : FlxWeapon = new FlxWeapon("mp5");
		
		private var weaponArray : Array = new Array();		
		private var weaponNameArray : Object = new Object();
		
		private var weapons : Object = new Object();
		
		private var _gunBulletSpeed : Number = 300;
		private var _mp5BulletSpeed : Number = 300;
		
		public var ALL_WEAPONS_TOOK : Boolean = false;
		public var PLAYER_HAVE_SOME_WEAPON : Boolean = false;
		public var CURRENT_WEAPON : Number = 0;
		
		
		/*
		 * 1 - gun
		 * 2 - mp5
		 * 3 - ....
		 * 
		 * ....
		 * 
		 * */
		public function PlayerWeapon() 
		{
			weaponNameArray[0] = "none";
			weaponNameArray[1] = "gun";
			weaponNameArray[2] = "mp5";
			
			
			/*
			 * 	init weapons
			 * */
			weapons = {
				0 : {
					active : true,
					name : 'none',
					ammo : 0
				},
				1 : {
					active : false,
					name : 'gun',
					ammo : 10
				},
				2 : {
					active : false,
					name : 'mp5',
					ammo : 30
				}
			}
			
			/*
			 * 	Create gun
			 * */
			var player : FlxSprite = PlayState.getInstance().getPlayer();
			 
			gun = new FlxWeapon("gun", player, "x", "y");
			gun.makeImageBullet(50, ImgBullet, player.width / 2, player.height / 2);
			gun.setBulletDirection(FlxWeapon.BULLET_UP, 100);
			gun.setFireRate(500);
			gun.setBulletSpeed(_gunBulletSpeed);
			gun.onFireCallback = decreaseGunAmmo;
			PlayState.getInstance().add(gun.group);
			
			/*
			 * 	Create mp5
			 * */
			mp5 = new FlxWeapon("mp5", player, "x", "y");
			mp5.makeImageBullet(50, ImgBullet, player.width / 2, player.height / 2);
			mp5.setBulletDirection(FlxWeapon.BULLET_UP, 100);
			mp5.setFireRate(150);
			mp5.onFireCallback = decreaseMp5Ammo;
			mp5.setBulletSpeed(_gunBulletSpeed);
			PlayState.getInstance().add(mp5.group);
		}
		
		public function decreaseGunAmmo():void
		{
			weapons[1]['ammo']--;
		}
		
		public function decreaseMp5Ammo():void
		{
			weapons[2]['ammo']--;
		}
		
		public function addGun():void
		{
			gunSprite = new FlxSprite(490, 300);
			gunSprite.loadGraphic(ImgGun, true, false, 16, 12);
			PlayState.getInstance().add( gunSprite ); 
		}
		
		public function addMp5():void
		{
			mp5Sprite = new FlxSprite(490, 350);
			mp5Sprite.loadGraphic(ImgMp5, true, false, 30, 17);
			PlayState.getInstance().add( mp5Sprite ); 
		}
		
		/*
		 * 	Check weapons collide with player
		 * */
		public function playerCollideWeaponListener():void
		{
			if ( !ALL_WEAPONS_TOOK ) {
				if ( gunSprite.alive && FlxCollision.pixelPerfectCheck( PlayState.getInstance().getPlayer(), gunSprite ) ) {
					FlxG.log('took gun');
					weaponArray.push(1);
					
					weapons[1]['active'] = true;
					
					CURRENT_WEAPON = 1;
					PLAYER_HAVE_SOME_WEAPON = true;
					gunSprite.kill();
				}
				if ( mp5Sprite.alive && FlxCollision.pixelPerfectCheck( PlayState.getInstance().getPlayer(), mp5Sprite ) ) {
					FlxG.log('took mp5');
					weaponArray.push(2);
					
					weapons[2]['active'] = true;
					
					CURRENT_WEAPON = 2;
					PLAYER_HAVE_SOME_WEAPON = true;
					mp5Sprite.kill();
				}
			}
		}
		
		/*
		 * 	Listen key buttons to change weapon
		 * */
		public function changeWeaponListener():void
		{
			var i : int;
			if ( FlxG.keys.pressed("ONE") ) { // prev
				for ( i = 0 ; i < weaponArray.length ; i++ )
				{
					if ( weaponArray[i] == 1 ) {
						CURRENT_WEAPON = 1;
					}
				}
			}
			if ( FlxG.keys.pressed("TWO") ) { // next
				for ( i = 0 ; i < weaponArray.length ; i++ )
				{
					if ( weaponArray[i] == 2 ) {
						CURRENT_WEAPON = 2;
					}
				}
			}
		}
		
		/*
		 * 	Shoot
		 * */
		public function shoot():void
		{
			switch( CURRENT_WEAPON )
			{
				case 1:
					if ( weapons[1]['ammo'] > 0 ) {
						
						gun.fireAtMouse();
					}
				break;	
				case 2:
					if ( weapons[2]['ammo'] > 0 ) {
						//weapons[2]['ammo']--;
						mp5.fireAtMouse();	
					}
				break;
				default:
				/* do nothing */
				break;
			}
		}
		
		public function getCurrentWeaponAmmo():Number
		{
			return weapons[CURRENT_WEAPON]['ammo'];
		}
		
		public function getCurrentWeaponName():String
		{
			return weaponNameArray[CURRENT_WEAPON];
		}
		
		public function increaseAmmo( type: int, increaseVaue : Number ):void
		{
			weapons[type]['ammo'] += increaseVaue;
		}
		
		/*
		 * 	Bullet 2 enemy collision
		 * */
		public function bullet2enemyCollision( bullet : Bullet, enemy : Enemy ):void
		{
			enemy.drawBloodSmall();
			enemy.hurt(20);
			//enemy.isPlayerShootingMe = true;
			
			var particles:int = 20;
			var emitter:FlxEmitter = new FlxEmitter(bullet.x, bullet.y, particles);
			emitter.setXSpeed(-100,200);
			emitter.setYSpeed(-100,100);
			
			
			bullet.kill();
			
			for(var i:int = 0; i < particles; i++)
			{
				var particle : FlxParticle = new FlxParticle();
				particle.makeGraphic(2, 2, 0xffff0000);
				emitter.add(particle);
			}
			
			PlayState.getInstance().getEnemyBloods().add(emitter);
			emitter.start(true, 0.2);
			//_enemyBlood.add(emitter);
			//emitter.start(true, 0.2);

		}
	}

}