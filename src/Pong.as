package  
{
	import app.PongContext;

	import flash.display.Sprite;

	public class Pong extends Sprite 
	{
		private var context:PongContext;
		
		public function Pong()
		{
			context = new PongContext(this);
		}
	}
}
