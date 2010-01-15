package app.model 
{
	import org.osflash.signals.Signal;

	public class ScoreModel implements Score
	{
		
		private var _currentLeftScore:uint;
		
		private var _currentRightScore:uint;
		
		private var _changed:Signal;
		
		public function ScoreModel()
		{
			_currentLeftScore = 0;
			_currentRightScore = 0;
			_changed = new Signal();
		}
		
		public function incrementLeftScore():void
		{
			_currentLeftScore++;
			_changed.dispatch();
		}
		
		public function get currentLeftScore():uint
		{
			return _currentLeftScore;
		}
		
		public function incrementRightScore():void
		{
			_currentRightScore++;
			_changed.dispatch();
		}
		
		public function get currentRightScore():uint
		{
			return _currentRightScore;
		}
		
		public function get changed():Signal
		{
			return _changed;
		}
	}
}
