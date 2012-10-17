package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	//You should only need these
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextField;  
  
	
	
	public class InputState extends FlxState
	{
		public var initialsInput:FlxInputText;
		public var initialsInputC:MyInput;
		public var initialsInputD:FlxText;
		
		public var ip2:Input2;
		
		public var passField:TextField;
		
		public var inputNum:uint = 10;
		
		override public function create():void
		{
			
			
			super.create();
			
		//	FlxG.bgColor = 0xffFFFFFF;
		
			//** The actual flash object***///
			passField = new TextField();
			passField.x = 200;			 
			passField.y = 50;
			passField.width = 80;
			passField.height = 20;			 
			passField.border = true;
			passField.borderColor = 0xFFFFFF;
			passField.textColor = 0xffFFFFFF;
			passField.multiline = false;	
			passField.type = TextFieldType.INPUT;			
			passField.maxChars = 10;
			FlxG.stage.addChild(passField);		
			//** End Flash Object **//
			
			/*
			initialsInput  = new FlxInputText(322, 264, 32, 16, "0", 0xffffff, null);
			initialsInput.setMaxLength(2);
			initialsInput.filterMode = 2;
			inputNum = parseInt(initialsInput.text);*/
			//add(initialsInput);
			
			//initialsInputD = new FlxText(75, 282, 32, "h");		
			//add(initialsInputD);
			
				//	If the FlxScreenGrab Plugin isn't already in use, we add it here
			if (FlxG.getPlugin(FlxScreenGrab) == null)
			{
				FlxG.addPlugin(new FlxScreenGrab);
			}
			
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			//	Define our hotkey (string value taken from FlxG.keys) the parameters simply say "save it right away" and "hide the mouse first"
			FlxScreenGrab.defineHotKey("F1", true, true);
			
			
			var t:FlxText;
			t = new FlxText(0,FlxG.height/2-10,FlxG.width,"Input Board Size here:");
			t.size = 16;
			t.alignment = "center";
			add(t);
			
			
			
			
			
			
			FlxG.mouse.show();
			
			
			
			
			var p:TextField;
			ip2 = new Input2(p);
			ip2.x = 320;
			ip2.y = 480;
			
			FlxG.stage.addChild(ip2);
			
				
		}

		override public function update():void
		{
			super.update();

			
			if (FlxG.keys.justPressed("ENTER"))
			{/*
			inputNum = parseInt(initialsInput.getText());
			Registry.inputNum = inputNum;
			trace(inputNum);*/
			}
			
			if(FlxG.keys.justPressed("SPACE"))
			{
				//inputNum = parseInt(initialsInput.text.toString());
				FlxG.mouse.hide();
				//initialsInput.kill();
				//initialsInput.destroy();
				
				//use removeChild to kill the object from the state.
				//Then give it a null boolean to remove it from memory.
				FlxG.switchState(new Minesweeper());
				FlxG.stage.removeChild(passField);
				passField = null;
				
			}
		}
	}
}