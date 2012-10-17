package 
{
	import org.flixel.*;
	//import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	//import flash.ui.Multitouch;
	//import flash.ui.MultitouchInputMode;
	
	[SWF(width="640", height="480")] //Set the size and color of the Flash file
	[Frame(factoryClass="Preloader")]
	/**
	 * ...
	 * @author Oleh Smazhnov
	 */
	public class Main extends FlxGame
	{
		
		public function Main():void 
		{
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			//stage.addEventListener(Event.DEACTIVATE, deactivate);
			//super(480, 800, MenuState, 1); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
			super(640,480,PlayState,1); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
			
			//forceDebugger = true;
			
			// touch or gesture?
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
		}
		
		/*
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}*/
	}
	
}