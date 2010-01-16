package  
{
	import app.PongContext;

	import flash.display.Sprite;

	[SWF (width="800", height="600", backgroundColor="#FFFFFF")]
	public class Pong extends Sprite 
	{
		private var context:PongContext;
		
		public function Pong()
		{
			context = new PongContext(this);
		}
	}
}
