package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Oleg Smagnov
	 */
	public class Effects 
	{
		
		public function Effects() 
		{
			
		}

		public static function alienExplosion( x : Number, y : Number):void
		{
			var emitter : FlxEmitter = new FlxEmitter(x, y); //x and y of the emitter
			emitter.gravity = 1;
			emitter.maxRotation = 0;
			var particles : int = 50;

			for(var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(4, 6, 0xFF597137);
				particle.exists = false;
				emitter.add(particle);
			}
			emitter.height = 40;
			emitter.width = 40;
			
			emitter.start(true, 1);
			PlayState.getInstance().add(emitter);
			
		}
	}

}