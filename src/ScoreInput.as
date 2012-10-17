package  
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import org.flixel.*;
	//You should only need these
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextField;  
	/**
	 * ...
	 * @author Oleg Smagnov
	 */
	public class ScoreInput
	{
		private var _defaultText : String = "Please input name";
		private var _successText : String = "Score submitted";
		private var _waitText : String = "Please wait..."
		private var _errorText : String = "Error: please try later";
		
		private var _scoreField : TextField = new TextField();
		
		public function ScoreInput()
		{
			_scoreField.scaleX = 1.5;
			_scoreField.scaleY = 1.5;
			
			_scoreField.visible = false;
			
			_scoreField.width = 100;
			_scoreField.height = 20;			 
			
			_scoreField.border = true;
			
			_scoreField.x = 165;
			_scoreField.y = 255;
			
			_scoreField.borderColor = 0xFFFFFF;
			_scoreField.textColor = 0xffFFFFFF;
			_scoreField.multiline = false;	
			_scoreField.type = TextFieldType.INPUT;			
			_scoreField.maxChars = 10;
			_scoreField.name = 'scoreField';
			_scoreField.text = _defaultText;
			_scoreField.addEventListener(MouseEvent.CLICK, onClick);
			_scoreField.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			FlxG.stage.addChild(_scoreField);
			
			var textFormat : TextFormat = new TextFormat();
			textFormat.size = 12;
			textFormat.bold = true;
			
			_scoreField.setTextFormat(textFormat);
		}
		
		public function onClick(e:MouseEvent):void
		{
			if ( _scoreField.text == _defaultText ) {
				_scoreField.text = '';
			}
		}
		
		public function onMouseOut(e:MouseEvent):void 
		{
			if ( _scoreField.text == '' ) {
				_scoreField.text = _defaultText;
			}
		}
		
		public function draw():void // x : Number, y : Number 
		{
			_scoreField.visible = true;
		}
		
		public function kill():void
		{
			_scoreField.visible = false;
		}
		
		public function val( newValue : String = '' ):String
		{
			if ( newValue.length > 0 ) {
				_scoreField.text = newValue;
			}
			return _scoreField.text;
		}
		
		public function validate():Boolean
		{
			if ( _scoreField.text == _defaultText ||  
				 _scoreField.text == _successText ) {
				
				setDefaultMessage();
					 
				return false
			} else {
				return true;
			}
		}
		
		public function setDefaultMessage():void 
		{
			_scoreField.text = _defaultText;	
		}
		
		public function setSuccessMessage():void
		{
			_scoreField.text = _successText;
		}
		
		public function setWaitMessage():void
		{
			_scoreField.text = _waitText;
		}
		
		public function setErrorMessage():void
		{
			_scoreField.text = _errorText;
		}
		
	}

}