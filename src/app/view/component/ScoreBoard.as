package app.view.component 
{
	import flash.display.Sprite;
	
	public class ScoreBoard extends Sprite 
	{
		private var _leftItem:ScoreBoardItem;
				private var _rightItem:ScoreBoardItem;
		
		public function ScoreBoard(leftColor:uint, rightColor:uint)
		{
			_leftItem = new ScoreBoardItem(leftColor);
			_leftItem.x = 150;
			_leftItem.y = 230;
			addChild(_leftItem);
						_rightItem = new ScoreBoardItem(rightColor);
			_rightItem.x = 550;
			_rightItem.y = 230;
			addChild(_rightItem);
		}
		
		public function get leftItem():ScoreBoardItem
		{
			return _leftItem;
		}
		
		public function get rightItem():ScoreBoardItem
		{
			return _rightItem;
		}
	}
}
