package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Oleg Smagnov
	 */
	public class LevelFactory 
	{
		private var _levelTilemap : FlxTilemap;
		
		public function LevelFactory() {}
		
		/*
		 * 
		 * */
		public function newLevel( levelNumber : Number )
		{
			switch ( levelNumber ) 
			{
				case 0:
					var levelBegin : LevelBegin = new LevelBegin();
					return levelBegin;
				case 1:
					var level1 : Level1 = new Level1();
					return level1;
				break;	
				case 2:
					var level2 : Level2 = new Level2();
					return level2;
				break;
				case 3:
					var level3 : Level3 = new Level3();
					return level3;
				break;
				case 4:
					var level4 : Level4 = new Level4();
					return level4;
				break;
				case 5:
					var level5 : Level5 = new Level5();
					return level5;
				break;
				case 6:
					var level6 : Level6 = new Level6();
					return level6;
				break;
				
				case 111:
					var levelMenu : LevelMenu = new LevelMenu();
					return levelMenu;
				break;
				case 333:
					var levelSelect : LevelSelect = new LevelSelect();
					return levelSelect;
				break;
				case 666:
					var levelEnd : LevelEnd = new LevelEnd();
					return levelEnd;
				break;
				default:
					FlxG.log('ERROR: level is undefined');
					FlxG.log( "levelNumber:" );
					FlxG.log( levelNumber );
				break;
			}
		}
		
		/*
		 * 
		 * */
		public function drawLevel( level ):void
		{
			if ( level ) {
				_levelTilemap = new FlxTilemap();
				_levelTilemap.loadMap(level._CSV_Main, level._Img_bgtiles_cfc289d7, 32, 32, NaN, 0, 0, 9);
				PlayState.getInstance().add(_levelTilemap);
				//PlayState.getInstance().setGameIsStarted( false );	
			} else {
				FlxG.log('ERROR: level is NULL');
			}
		}
		
		public function getLevelTilemap():FlxTilemap
		{
			return _levelTilemap;
		}
	}

}