package app.view.component 
{
	import flash.display.Sprite;

	public class Ball extends Sprite 
	{
		
		public function redraw(radius:uint):void
		{
			graphics.clear();
			graphics.beginFill(0xFF0000);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
	}
	
}
