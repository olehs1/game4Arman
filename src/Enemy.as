package  
{
	import mx.core.FlexSprite;
	import org.flixel.*;
	
	public interface Enemy
	{
		function hurt( Demage : Number):void
		function playerFollow():void
		function drawBloodSmall():void
	}

}