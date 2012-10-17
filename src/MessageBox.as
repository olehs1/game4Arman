package  
{
	import flash.text.engine.GroupElement;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Oleg Smagnov
	 */
	public class MessageBox extends FlxSprite
	{
		[Embed(source = "img/mssages/messageBox.png")] private static var ImgMessageBox : Class;
		
		private var _object : FlxSprite;
		private var _messageText : FlxText;
		private var _timerToDisplay : FlxDelay;
		private var _timerToDelay : FlxDelay;
		private var _timeToDisplayValue : Number;
		
		private var _timerToDisplayInit : Boolean = false
		
		
		
		public function MessageBox(object : FlxSprite, message : String, timeToDisplay : Number = 1000, timeToDelay : Number = 0) 
		{
			_object = object;
			
			_timeToDisplayValue = timeToDisplay;
			
			super( object.x + object.width, object.y - 50 );
			
			loadGraphic(ImgMessageBox, true, false, 100, 50);
			
			
			_messageText = new FlxText( object.x + object.width + 10, object.y - 50 + 10, 100, message );
			_messageText.color = 0x11111111;
			
			_timerToDelay = new FlxDelay( timeToDelay );
			_timerToDelay.start();
			
			visible = false;
			_messageText.visible = false;
			
			PlayState.getInstance().add( this );
			PlayState.getInstance().add( _messageText );
		}

		override public function update():void 
		{
			super.update();
			
			if ( _timerToDelay.hasExpired && !_timerToDisplayInit ) {
				_timerToDisplay = new FlxDelay( _timeToDisplayValue );
				_timerToDisplay.start();
				_timerToDisplayInit = true;
			
				visible = true;
				_messageText.visible = true;
			}
			
			if ( _timerToDisplayInit ) {
				if ( _timerToDisplay.isRunning ) {
					x = _object.x + _object.width;
					y = _object.y - 50;
					
					_messageText.x = _object.x + _object.width + 10;
					_messageText.y = _object.y - 50 + 10;	
				} else {
					this.kill();
					_messageText.kill();
				}	
			}
		}
		
		//public function 
		
	}

}