package  
{
	import org.flixel.*;
	import flash.events.*;
	/**
	 * ...
	 * @author Oleg Smagnov
	 */
	public class MenuState extends FlxState
	{
		private var scoreSubmit : ScoreSubmit;
		private var _scoreFromServer : Array;
		
		override public function MenuState( state : String = '' , score : Number = 0 ):void
		{	
			FlxG.framerate = 60;
			FlxG.flashFramerate = 60;
			FlxG.mouse.show();
			FlxG.bgColor = 0xFFABCC7D;
			
			scoreSubmit = new ScoreSubmit();
			
			switch( state ) {
				case 'score':
					var txt : FlxText = new FlxText(100, 230, 300, "Your score is " + score );
					txt.setFormat(null, 16, 0xfff, "center");
					add(txt);
					
					var submitScoreButton: FlxButton = new FlxButton(200, 300, 'Submit score', newGameButtonClick);
					submitScoreButton.scale.x = 2;
					submitScoreButton.scale.y = 2;
					add( submitScoreButton );
					
					var tryAgainButton: FlxButton = new FlxButton(200, 350, 'Try again', tryAgainButtonClick);
					tryAgainButton.scale.x = 2;
					tryAgainButton.scale.y = 2;
					add( tryAgainButton );
					
					var menuButton: FlxButton = new FlxButton(200, 400, 'Menu', menuButtonClick);
					menuButton.scale.x = 2;
					menuButton.scale.y = 2;
					add( menuButton );
					
				break;
				default:
					var newGameButton: FlxButton = new FlxButton(200, 300, 'Start', newGameButtonClick);
					newGameButton.scale.x = 2;
					newGameButton.scale.y = 2;
					add( newGameButton );
					
					var scoresButton: FlxButton = new FlxButton(200, 350, 'Scores', scoresButtonClick);
					scoresButton.scale.x = 2;
					scoresButton.scale.y = 2;
					add( scoresButton );
					
					var moreButton: FlxButton = new FlxButton(200, 400, 'More', moreButtonClick);
					moreButton.scale.x = 2;
					moreButton.scale.y = 2;
					//add( moreButton );
				break;
			}
			
			
			
			super.create();
		}
		override public function update():void
		{
			super.update();
			
		}
		
		/*
		 * 	Show score
		 * */
		public function scoresButtonClick():void
		{
			scoreSubmit.getScore();
		}
		
		public static function drawScore( score : Event ):void
		{
			FlxG.log( score );
			/*
			if ( score.length > 0 ) {
				FlxG.log( score );
			} else {
				FlxG.log( 'NO SCORES' );	
			}
			*/
			//scoreSubmit.send("Nick", 323);
		}
		
		public function moreButtonClick():void
		{
			
		}
		
		public function tryAgainButtonClick():void
		{
			FlxG.switchState( new PlayState() );
		}
		
		public function menuButtonClick():void
		{
			FlxG.switchState( new MenuState() );
		}
		
		public function newGameButtonClick():void
		{
			FlxG.switchState( new PlayState() );
		}
		
		public function drawScore( score : Number ):void
		{
			var txt : FlxText = new FlxText(100, 230, 300, "Your score is " + score );
			txt.setFormat(null, 16, 0xfff, "center");
			add(txt);
		}
		
	}

}