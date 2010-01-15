package app.view.mediator 
{
	import app.model.Geometry;
	import app.ticker.Ticker;
	import app.view.component.Ball;

	import org.robotlegs.mvcs.Mediator;

	public class BallMediator extends Mediator 
	{
		[Inject]
		public var view:Ball;
		
		[Inject]
		public var model:Geometry;

		[Inject]
		public var ticker:Ticker;

		override public function onRegister():void
		{
			view.redraw(model.radius);
			ticker.add(update);
		}
		
		private function update():void
		{
			view.x = model.x;			view.y = model.y;
		}
		
		
	}
}
