package
{
	import flash.display.ColorCorrectionSupport;
	import flash.errors.InvalidSWFError;
	import flash.media.Video;
	import flash.text.TextField;
	import org.flixel.*;
	import flash.events.*;
	import org.flixel.system.input.Input;
	import org.flixel.plugin.photonstorm.*;
	import util.RandomNumberHelper;
	import com.adobe.serialization.json.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "img/level/bgtiles.png")] private var ImgMap : Class;
		
		
		private var _player : Player;
		private var _currentLevel;
		private var _levelFactory : LevelFactory = new LevelFactory();
		
		/*
		 * Groups
		 * */
		private var _enemies : FlxGroup;
		private var _coins : FlxGroup;
		private var _finish : FlxGroup;
		private var _levelIcons : FlxGroup;
		private var _menuItems : FlxGroup;
		private var _enemyCreators : FlxGroup;
		private var _enemyBloods : FlxGroup;
		private var _playerBonuses : FlxGroup;
		/*
		 * 
		 * */
		private static var instance : PlayState;
		
		private var COINS_COUNT : Number;
		private var LEVEL_COMPLETE : Boolean = false;
		private var CURRENT_LEVEL_NUMBER : Number = 0;
		private var LEVEL_COUNT : Number = 6;
		private var LEVEL_END : Number = 666;
		private var LEVEL_SELECT : Number = 333;
		private var LEVEL_MENU : Number = 111;
		
		private var PLAYER_LOSE_COUNT : Number = 0;
		/*
		 * 	helper flag
		 * */
		private var GAME_IS_STARTED : Boolean = false;
		
		/*
		 * 	level array
		 * */
		private var levelArray : Array = new Array();
		
		public var playerWeapon : PlayerWeapon;
		
		public static var pl : Boolean = false;
		public static var pr : Boolean = false;
		public static var pu : Boolean = false;
		public static var pd : Boolean = false;
		
		//public static var pd : Boolean = false;
		
		/*
		 * 
		 * */
		override public function create():void
		{
			
			FlxG.bgColor = 0xffaaaaaa;
			
			//FlxCollision.debug;
			
			FlxG.framerate = 60;
			FlxG.flashFramerate = 60;
			FlxG.mobile = false;
			FlxG.mouse.show();
			instance = this;
			
			
			CURRENT_LEVEL_NUMBER = 1;
			
			/*
			 * 	Fill array of levels
			 * to show what level is done
			 * */
			fillLevelArray();
			
			/*
			 * 	Draw level is here
			 * */
			_currentLevel = _levelFactory.newLevel( CURRENT_LEVEL_NUMBER );
			
			//_currentLevel = _levelFactory.newLevel( LEVEL_MENU );
			_levelFactory.drawLevel(_currentLevel);
			
			/*
			 * 	add objects
			 * */
			addObjects();
			
			playerWeapon = new PlayerWeapon();
			playerWeapon.addGun();
			playerWeapon.addMp5();
			
			super.create();
			//FlxG.log( 'CURRENT_LEVEL_NUMBER: ' + CURRENT_LEVEL_NUMBER );
			
			
			//BonusRandomMaker.drawRandomBonus(100, 100);
			/*
			var live : FlxSprite = BonusFactory.newBonus('live', 100, 100);
			_playerBonuses.add(live);
			
			var live1 : FlxSprite = BonusFactory.newBonus('ammoGun', 190, 100);
			_playerBonuses.add(live1);
			
			var live2 : FlxSprite = BonusFactory.newBonus('ammoMp5', 250, 100);
			_playerBonuses.add(live2);
			
			var redEnemy : FlxSprite = EnemyFactory.newEnemy('enemyRed', 200, 200);
			_enemies.add( redEnemy );
			*/
			
		}
		
		/*
		 * 
		 * */
		private var i : Number = 0;
		
		public static var t : Boolean = false;
		
		override public function update():void
		{
			super.update();
			
			if ( FlxG.keys.pressed("R") && !GAME_IS_STARTED ) {
				
				FlxG.resetGame();
				
				GAME_IS_STARTED = true;
			}
			
			if ( FlxG.keys.pressed("P") ) {
				
				//FlxG.p
				
			}
			
			addEndlessEnemies();
			
			/*
			if ( FlxG.keys.pressed("ESCAPE") && !GAME_IS_STARTED ) {
				CURRENT_LEVEL_NUMBER = LEVEL_MENU;
				FlxG.log('HERE');
				goToNextLevel();
				GAME_IS_STARTED = true;
			}
			*/
			if ( CURRENT_LEVEL_NUMBER != 0 &&
				 CURRENT_LEVEL_NUMBER != LEVEL_SELECT &&
				 CURRENT_LEVEL_NUMBER != LEVEL_MENU) 
				 
			{
				FlxG.collide(_player, _levelFactory.getLevelTilemap());
				//FlxG.overlap(_player, _finish, player2finishCollide);
				//FlxG.collide(_player, _coins, player2coinCollide);
				
				//FlxG.collide(_player, _enemies, player2enemyCollide);
				
				//FlxG.overlap(_player, _enemies, player2enemyCollide, FlxObject.separateX);
				//FlxG.overlap(_player, _enemies, player2enemyCollide, FlxObject.separateY);
				
				//FlxG.collide( _player, gun, player2gun );
				
				FlxG.collide(_enemies, _levelFactory.getLevelTilemap(), enemy2levelCollide);	
				
				FlxG.collide( _player, _playerBonuses, player2playerBonusesCollide );
				
				playerWeapon.playerCollideWeaponListener();
			}
			
		}
		
		private var _enemyRandomCreate : Number;
		private var _enemyRandomTypePosition : Number;
		private var _enemyRandomType : Number;
		private var _enemyRandomX : Number;
		private var _enemyRandomY : Number;
		private var _enemy : FlxSprite;
		
		/*  */
		public function addEndlessEnemies():void
		{
			_enemyRandomCreate = RandomNumberHelper.randomIntRange( 1, 80 );
			
			if ( _enemyRandomCreate == 1 ) {
				
				_enemyRandomTypePosition = RandomNumberHelper.randomIntRange( 1, 4 );
				_enemyRandomType = RandomNumberHelper.randomIntRange( 1, 2 );
				
				switch( _enemyRandomTypePosition ) 
				{
					case 1: // top
						_enemyRandomX = Math.random() * FlxG.stage.width;	
						_enemyRandomY = 0;
					break;
					case 2: // right
						_enemyRandomX = FlxG.stage.width;	
						_enemyRandomY = Math.random() * FlxG.stage.height;
					break;
					case 3: // bottom
						_enemyRandomX = Math.random() * FlxG.stage.width;
						_enemyRandomY = FlxG.stage.height;
					break;
					case 4: // left
						_enemyRandomX = 0;
						_enemyRandomY = Math.random() * FlxG.stage.height;
					break;
					default:
						
						break;
				}
				
				//_enemy = new Enemy(_enemyRandomX, _enemyRandomY);
				
				switch( _enemyRandomType )
				{
					case 1:
						_enemy = EnemyFactory.newEnemy( 'enemyGreen', _enemyRandomX, _enemyRandomY );	
					break;	
					case 2:
						_enemy = EnemyFactory.newEnemy( 'enemyRed', _enemyRandomX, _enemyRandomY );	
					break;
					default:
					
					break;
				}
				
				
				_enemies.add(_enemy);
			}
			
		}
		
		/*
		 * 	Add level objects like player, enemies, coins etc.
		 * */
		public function addObjects():void
		{
			/*
			 * 	add level object
			 * */
			if ( CURRENT_LEVEL_NUMBER != 0 &&
				 CURRENT_LEVEL_NUMBER != LEVEL_SELECT &&
				 CURRENT_LEVEL_NUMBER != LEVEL_MENU ) {

				_enemies = new FlxGroup();
				//_coins = new FlxGroup();
				_finish = new FlxGroup();
				_enemyBloods = new FlxGroup();
				_enemyCreators = new FlxGroup();
				_playerBonuses = new FlxGroup();
				
				
				/*
				 * 	add groups
				 * */
				add( _enemyBloods );
				add( _playerBonuses );
				add( _enemies );
				//add( _coins );
				add( _finish );
				add( _enemyCreators );
				
				
				
				addPlayer();
				
				addEnemies();
				//addEnemyCreators();
				//addCoins();
				//addFinish();
			}
			
			/*
			 *  add abject level and menu
			 * */
			if ( CURRENT_LEVEL_NUMBER == LEVEL_SELECT ) {
				_levelIcons = new FlxGroup();
				add( _levelIcons );
				addLevelIcons();
			}
			if ( CURRENT_LEVEL_NUMBER == LEVEL_MENU ) {
				_menuItems = new FlxGroup();
				add( _menuItems );
				addMenuItems();
			}
			
		}
		
		public function killObjects():void
		{
			if ( _player ) {
				_player.kill();	
			} 
			if ( _enemies ) {
				_enemies.kill();	
			} 
			if ( _coins ) {
				_coins.kill();
			}
			if ( _finish ) {
				_finish.kill();
			}
			if ( _levelIcons ) {
				_levelIcons.kill();
			}
			if ( _menuItems ) {
				_menuItems.kill();
			}
		}
		
		
		/*
		 * 	Collisions callbacks
		 * */
		public function enemy2levelCollide( enemy : Enemy, level : FlxTilemap ):void
		{
			//enemy.onLevelCollide();
		}
		
		public function player2playerBonusesCollide( player : Player, bonus : Bonus ):void
		{
			bonus.makeBonus();
		}
		
		public function player2enemyCollide( player : Player, enemy : Enemy ):void
		{
			
		}
		
		public function player2coinCollide( player : Player, coin : Coin ):void
		{
			COINS_COUNT--;
			if ( COINS_COUNT == 0 ) {
				LEVEL_COMPLETE = true;	
			}
			
			coin.kill();
		}
		
		public function player2finishCollide( player : Player, finish : Finish ):void
		{
			if ( LEVEL_COMPLETE ) {
				if ( CURRENT_LEVEL_NUMBER == LEVEL_COUNT ) {
					FlxG.log('END OF THE DAME');	
					goToEndLevel();
				} else {
					FlxG.log('GO TO NEXT LEVEL');	
					CURRENT_LEVEL_NUMBER++;
					goToNextLevel();	
				}
			}
		}
		
		/*
		 *	Return instance  
		 * */
		public static function getInstance():PlayState
		{
			return instance;
		}
		
		/*
		 *	Add objects functions	 	
		 * */
		
		/*
		 * 
		 * */
		public function addPlayer():void
		{
			if ( _currentLevel._Sprites_Player.length > 0 ) {
				_player = new Player( _currentLevel._Sprites_Player[0].x, _currentLevel._Sprites_Player[0].y );
				add(_player);
			}
			
		}
		
		public function getPlayer():FlxSprite
		{
			return _player;
		}
		
		/*
		 * 	
		 * */
		public function addEnemies():void
		{
			var enemies : Array = _currentLevel._Sprites_Enemy;
			var enemyFromArray :Object;
			var enemy : FlxSprite;
			var speedX : Number;
			var speedY : Number;
			var i : Number;
			
			var enemyType : String;
			/**/
			
			
			
			/**/
			
			
			if ( enemies.length > 0 ) {
				switch( CURRENT_LEVEL_NUMBER ){
					case 1:
						_enemiesActionIn123Levels();
					break;
					case 2:
						_enemiesActionIn123Levels();
					break;
					case 3:
						_enemiesActionIn123Levels();
					break;
					case 4:
						speedX = 0;
						for ( i = 0 ; i < enemies.length ; i++ ) {
							enemyFromArray = enemies[i];
							if ( i % 2 == 0 ) {
								speedY = 200;
							} else {
								speedY = -200;
							}
							//enemy = new Enemy(enemyFromArray.x, enemyFromArray.y, speedX, speedY);
							enemy = EnemyFactory.newEnemy('enemyGreen', enemyFromArray.x, enemyFromArray.y);
							_enemies.add(enemy);
						}	
					break;
					case 5:
						
						for ( i = 0 ; i < enemies.length ; i++ ) {
							enemyFromArray = enemies[i];
							speedX = 0;
							speedY = 0;
							
							switch( i ) {
								case 0: // up
									enemyType = 'upDown';	
									speedY = 200;
								break;	
								case 1: // up
									enemyType = 'upDown';	
									speedY = -200;
								break;
								case 2: // up
									enemyType = 'leftRight';	
									speedX = 200;
								break;	
								case 3: // up
									enemyType = 'leftRight';	
									speedX = -200;
								break;
								case 4: // up
									enemyType = 'upDown';	
									speedY = 200;
								break;	
								case 5: // up
									enemyType = 'upDown';	
									speedY = -200;
								break;
								case 6: // up
									enemyType = 'leftRight';	
									speedX = 200;
								break;	
								case 7: // up
									enemyType = 'leftRight';	
									speedX = -200;
								break;
								case 8: // up
									enemyType = 'upDown';	
									speedY = 200;
								break;	
								case 9: // up
									enemyType = 'upDown';	
									speedY = -200;
								break;
								case 10: // up
									enemyType = 'leftRight';	
									speedX = 200;
								break;	
								case 11: // up
									enemyType = 'leftRight';	
									speedX = -200;
								break;
								case 12: // up
									enemyType = 'leftRight';	
									speedX = 200;
								break;	
								case 13: // up
									enemyType = 'leftRight';	
									speedX = -200;
								break;
							}
							
							if ( i % 2 == 0 ) {
								//speed = 200;
							} 
							enemy = EnemyFactory.newEnemy('enemyGreen', enemyFromArray.x, enemyFromArray.y);
							//enemy = new Enemy( enemyFromArray.x, enemyFromArray.y, speedX, speedY, enemyType );
							_enemies.add(enemy);
						}
						
					break;
					case 6:
						
					break;
					case 7:
						
					break;
					case 8:
						
					break;
					case 9:
						
					break;
					case 10:
						
					break;
					default:
					
					break;
				}
				
					
			}
			
		}
		
		public function getEnemies():FlxGroup
		{
			return _enemies;
		}
		
		private function _enemiesActionIn123Levels():void
		{
			var enemies = _currentLevel._Sprites_Enemy;
			var speedX : Number = 0;
			var speedY : Number;
			for ( var i : Number = 0 ; i < enemies.length ; i++ ) {
				var enemyFromArray :Object = enemies[i];
				if ( i == 1 ) {
					speedY = 200;
				} else {
					speedY = -200;
				}
				//var enemy : Enemy = new Enemy(enemyFromArray.x, enemyFromArray.y, 100, 100);
				
				var enemy : FlxSprite = EnemyFactory.newEnemy( 'enemyGreen', enemyFromArray.x, enemyFromArray.y );
				
				_enemies.add(enemy);
			}	
		}
		
		/*
		 * 
		 * */
		public function getEnemyBloods():FlxGroup
		{
			return _enemyBloods;
		}
		
		/*
		 * 
		 * */
		public function addEnemyCreators():void
		{
			var enemyCreators = _currentLevel._Sprites_EnemyCreator;
			for ( var i : Number = 0 ; i < enemyCreators.length ; i++ ) {
				var enemyCreator : EnemyCreator = new EnemyCreator( enemyCreators[i].x, enemyCreators[i].y );
				_enemyCreators.add(enemyCreator);
			}
		}
		
		public function getPlayerBonuses():FlxGroup
		{
			return _playerBonuses;
		}
		
		/*
		 * 
		 * */
		public function addCoins():void
		{
			var coins = _currentLevel._Sprites_Coin;
			if ( coins.length > 0 ) {
				for ( var i : Number = 0 ; i < coins.length ; i++ ) {
					var coinFromArray :Object = _currentLevel._Sprites_Coin[i];
					var coin : Coin = new Coin(coinFromArray.x,coinFromArray.y,0);
					_coins.add(coin);
				}
				COINS_COUNT = _currentLevel._Sprites_Coin.length;
				LEVEL_COMPLETE = false;	
			}			
		}
		
		public function resetCoins():void
		{
			if ( _coins.length > 0 ) {
				for ( var i : Number = 0; i < _coins.length ; i++ ) {
					_coins.members[i].kill();
				}					
			}
			addCoins();
		}
		
		/*
		 * 
		 * */
		public function addFinish():void
		{
			var finishArray : Array = _currentLevel._Sprites_Finish;
			if ( finishArray.length > 0 ) {
				for ( var i : Number = 0 ; i < finishArray.length ; i++ ) {
					var finishFromArray :Object = finishArray[i];
					var finish : Finish = new Finish(finishFromArray.x,finishFromArray.y);
					_finish.add(finish);
				}	
			}
			
		}
		
		/*
		 *	Icons of levels in select level  
		 * */
		public function addLevelIcons():void
		{
			if ( _currentLevel._Sprites_LevelIcon != null ) 
			{
				var levelIcons : Array = _currentLevel._Sprites_LevelIcon;
				if ( levelIcons.length )
				{
					//for ( var i : Number = 0 ; i < levelIcons.length ; i++ ) {
					for ( var i : Number = 0 ; i < LEVEL_COUNT ; i++ ) {
						var levelIconFromArray : Object = levelIcons[i];
						var levelIcon : LevelIcon = new LevelIcon( i+1, levelIconFromArray.x,levelIconFromArray.y);
						_levelIcons.add(levelIcon);
					}
				}	
				
			}
		}
		
		/*
		 * 
		 * */
		
		/*
		 * Functions to work with levels
		 * */
		public function goToNextLevel():void
		{
			killObjects();
			_currentLevel = _levelFactory.newLevel(CURRENT_LEVEL_NUMBER);	
			_levelFactory.drawLevel(_currentLevel);
			addObjects();
			GAME_IS_STARTED = false;
		}
		
		public function goToEndLevel():void
		{
			killObjects();
			_currentLevel = _levelFactory.newLevel(LEVEL_END);	
			_levelFactory.drawLevel(_currentLevel);
		}
		
		public function setCurrentLevelNumber( currentLevelNumber : Number ):void
		{
			CURRENT_LEVEL_NUMBER = currentLevelNumber;
		}
		
		public function getSelectLevelNumber():Number
		{
			return LEVEL_SELECT;
		}
		
		public function setGameIsStarted( value : Boolean ):void
		{
			GAME_IS_STARTED = value;
		}
		
		public function fillLevelArray():void
		{
			for ( var i : Number = 0 ; i < LEVEL_COUNT ; i++ )
			{
				levelArray[i] = false;
			}
			
			FlxG.log( 'levelArray:' );
			FlxG.log( levelArray );
		}
		
		public function getCurrentLevelTilemap():FlxTilemap
		{
			return _levelFactory.getLevelTilemap();
		}
		
		/*
		 * 	Menu fuctional
		 * */
		public function addMenuItems():void
		{
			var menuItems : Array = _currentLevel._Sprites_MenuItems;
				if ( menuItems.length )
				{
					for ( var i : Number = 0 ; i < menuItems.length ; i++ ) {
						var menuItemFromArray : Object = menuItems[i];
						var menuItem : MenuItem = new MenuItem( i, menuItemFromArray.x, menuItemFromArray.y);
						_menuItems.add(menuItem);
					}
				}	
		}
		
		public function getBonuses():FlxGroup
		{
			return _playerBonuses;
		}
	}
}