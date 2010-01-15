package app.ticker 
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class EnterFrameTicker implements Ticker
	{
		private var fns:Array;
		
		private var count:int;
		
		private var stage:DisplayObjectContainer;
		
		public function EnterFrameTicker(root:DisplayObjectContainer)
		{
			this.stage = root;
			fns = [];
			count = 0;
			
			start();
		}
		
		public function start():void
		{
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function stop():void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function add(fn:Function):void
		{
			if (fns.indexOf(fn) == -1)
				fns[count++] = fn;
		}
		
		public function remove(fn:Function):void
		{
			var i:uint = fns.indexOf(fn);
			if (i != -1)
			{
				fns.splice(i, 1);
				--count;
			}	
		}
		
		private function onEnterFrame(event:Event):void
		{
			var i:int = count;
			while (--i > -1)
			{
				var fn:Function = fns[i];
				fn();
			}
		}
		
	}
}
