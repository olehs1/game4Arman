package  
{
	import flash.errors.IOError;
	import flash.net.*
	import org.flixel.*;
	import flash.events.*;
	
	public class ScoreSubmit 
	{
		//private var _scoreUrl : String = "http://localhost/flashServer/";
		private var _scoreUrl : String = "http://smazhnovbussines.com/flashServer";
		
		
		public function ScoreSubmit() 
		{
			
		}
		
		public function send( name : String, score : Number ):void
		{
			
			var requestVars:URLVariables = new URLVariables();
			requestVars.name = name; // Dummy data to be sent to php
			requestVars.score = score;

			var request:URLRequest = new URLRequest();
			request.url = _scoreUrl;
			request.method = URLRequestMethod.POST;
			request.data = requestVars;

			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, sendCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, sendLoaderIOErrorHendler);
			try { 
				loader.load(request); 
			} catch (error:Error) { 
				FlxG.log( error );
			}
		}
		
		public function sendCompleteHandler(event:Event):void
		{
			FlxG.log( event );
			FlxG.log( event.target.data );
			PlayState.getInstance().setSuccessMessage();
		}
		
		public function sendLoaderIOErrorHendler( error : IOErrorEvent ):void
		{
			FlxG.log( error );
			PlayState.getInstance().setErrorMessage();
		}
		
		public function getScore():void
		{
			var requestVars:URLVariables = new URLVariables();
			requestVars.toDo = 'getScore'; 

			var request:URLRequest = new URLRequest();
			request.url = _scoreUrl;
			request.method = URLRequestMethod.POST;
			request.data = requestVars;

			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHendler);
			try {
				FlxG.log('cool');
				loader.load(request); 
			} catch (error:Error) { 
				FlxG.log( error );
			}
		}
		
		public function loaderCompleteHandler(event:Event):void
		{
			FlxG.log( event.target.data );
			PlayState.getInstance().drawScoreTable( event.target.data );
			//FlxG.log( event.target.data );
			
			//MenuState.drawScore( event.target.data );
			
			/*
			var variables:URLVariables = new URLVariables(event.target.data);
			var msg = variables.msg;
			if(msg=="true"){
				FlxG.log("Done!");
			} else{
				FlxG.log("Error: "+msg);
			}*/
		}
		
		public function loaderIOErrorHendler( error : IOErrorEvent ) :void
		{
			FlxG.log( error );
		}
		
	}

}