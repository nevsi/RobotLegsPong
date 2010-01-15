package app.view.component 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class ScoreBoardItem extends Sprite 
	{
		private const SCORE_SIZE:uint = 200;
		private const SCORE_ALPHA:Number = 0.5;
		
		private var tf:TextField;
		
		private var _score:uint;

		public function ScoreBoardItem(color:uint)
		{
			mouseChildren = false;
			
			tf = new TextField();
			tf.selectable = false;
			tf.defaultTextFormat = new TextFormat("_sans", SCORE_SIZE, color, true, false, false, null, null, TextFormatAlign.CENTER);
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.height = 40;
			tf.alpha = SCORE_ALPHA;
			
			score = 0;
			
			addChild(tf);
		}
		
		public function get score():uint
		{
			return _score;
		}
		
		public function set score(value:uint):void
		{
			_score = value;
			tf.text = _score.toString();
		}
		
	}
}
