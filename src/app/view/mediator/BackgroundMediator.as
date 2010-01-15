package app.view.mediator 
{
	import app.model.Geometry;
	import app.view.component.Background;

	import org.robotlegs.mvcs.Mediator;

	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	public class BackgroundMediator extends Mediator
	{
		[Inject]
		public var view:Background;
		
		[Inject]
		public var model:Geometry;

		override public function onRegister():void
		{
			var graphics:Graphics = view.graphics;
			var bounds:Rectangle = model.area;
			
			graphics.lineStyle(2, 0x999999);
			graphics.drawRect(bounds.left, bounds.top, bounds.width, bounds.height);
			
			var center:Number = bounds.left + bounds.width * 0.5;
			graphics.moveTo(center, bounds.top);
			graphics.lineTo(center, bounds.bottom);
			
			var middle:Number = bounds.top + bounds.height * 0.5;
			graphics.drawCircle(center, middle, 50);
		}
	}
}
