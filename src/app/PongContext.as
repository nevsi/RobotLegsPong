package app 
{
	import alecmce.ui.interactive.DragMechanism;

	import app.model.BatGeometry;
	import app.model.BatGeometryModel;
	import app.model.Geometry;
	import app.model.GeometryModel;
	import app.model.Score;
	import app.model.ScoreModel;
	import app.ticker.EnterFrameTicker;
	import app.ticker.Ticker;
	import app.view.component.Background;
	import app.view.component.Ball;
	import app.view.component.Bat;
	import app.view.component.ScoreBoard;
	import app.view.mediator.BackgroundMediator;
	import app.view.mediator.BallMediator;
	import app.view.mediator.BatMediator;
	import app.view.mediator.ScoreBoardMediator;

	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	public class PongContext extends Context 
	{
		private const LEFT_COLOR:uint = 0x1E90FF;
		private const RIGHT_COLOR:uint = 0x00FF00;
		
		public function PongContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true)
		{
			super(contextView, autoStartup);
		}

		override public function startup():void
		{
			injector.mapSingletonOf(Ticker, EnterFrameTicker);
			injector.mapSingletonOf(Score, ScoreModel);
			injector.mapSingletonOf(Geometry, GeometryModel);
			injector.mapSingleton(DragMechanism);
			
			injector.mapClass(BatGeometry, BatGeometryModel);
						mediatorMap.mapView(Background, BackgroundMediator);
			mediatorMap.mapView(ScoreBoard, ScoreBoardMediator);			mediatorMap.mapView(Ball, BallMediator);			mediatorMap.mapView(Bat, BatMediator);
			
			var background:Background = new Background();
			contextView.addChild(background);
			
			var scoreboard:ScoreBoard = new ScoreBoard(LEFT_COLOR, RIGHT_COLOR);
			contextView.addChild(scoreboard);
			
			var leftBat:Bat = new Bat(LEFT_COLOR);
			leftBat.x = 100;
			leftBat.y = 300;
			contextView.addChild(leftBat);			
			var rightBat:Bat = new Bat(RIGHT_COLOR);
			rightBat.x = 670;
			rightBat.y = 300;
			contextView.addChild(rightBat);	
			
			var ball:Ball = new Ball();
			contextView.addChild(ball);
		}

	}
}
