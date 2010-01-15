package app.view.component 
{
	import flash.display.Sprite;

	public class Bat extends Sprite 
	{
		private const DEFAULT_WIDTH:uint = 20;
		private const DEFAULT_HEIGHT:uint = 100;
		
		private var _color:uint;
		
		private var _width:uint;
		private var _height:uint;
		
		public function Bat(color:uint)
		{
			_color = color;
			_width = DEFAULT_WIDTH;
			_height = DEFAULT_HEIGHT;
			redraw();
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(width:Number):void
		{
			_width = width;
			redraw();
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set height(height:Number):void
		{
			_height = height;
			redraw();
		}
		
		private function redraw():void
		{
			graphics.clear();
			graphics.beginFill(_color);
			graphics.drawRect(0, -_height >> 1, _width, _height);
			graphics.endFill();
		}
	}
}
