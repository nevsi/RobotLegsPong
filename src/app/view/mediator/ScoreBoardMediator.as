package app.view.mediator 
{
	import app.model.Score;
	import app.view.component.ScoreBoard;

	import org.robotlegs.mvcs.Mediator;

	public class ScoreBoardMediator extends Mediator 
	{
		[Inject]
		public var view:ScoreBoard;
		
		[Inject]
		public var score:Score;

		override public function onRegister():void
		{
			score.changed.add(onScoreChanged);
		}
		
		private function onScoreChanged():void
		{
			view.leftItem.score = score.currentLeftScore;			view.rightItem.score = score.currentRightScore;
		}
		
	}
}
