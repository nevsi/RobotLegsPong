package app.model 
{
	import app.model.BatGeometry;

	public class BatGeometryModel implements BatGeometry 
	{
		private const TWOPI:Number = Math.PI * 2;
		
		private var _left:Number;		private var _right:Number;		private var _top:Number;		private var _bottom:Number;
		
		[Inject]
		public var geometry:Geometry;
		
		[PostConstruct]
		public function init():void
		{
			geometry.addCollidable(this);
		}
		
		public function set left(value:Number):void { _left = value; }		public function get left():Number { return _left; }
		
		public function set right(value:Number):void { _right = value; }		public function get right():Number { return _right; }
		
		public function set top(value:Number):void { _top = value; }		public function get top():Number { return _top; }

		public function set bottom(value:Number):void { _bottom = value; }
		public function get bottom():Number { return _bottom; }
		
		public function collide(x:Number, y:Number, dx:Number, dy:Number):CollisionResult
		{
			var result:CollisionResult = new CollisionResult(false);
			
			var lambda:Number;
			var proportion:Number = 1;
			var nx:Number;
			var ny:Number;
			var angle:Number = Math.atan2(dy, dx);
			
			if (dx > 0 && x < _left)
			{
				lambda = (_left - x) / dx;
				if (lambda < proportion)
				{
					nx = x + dx * lambda;
					ny = y + dy * lambda;
					angle = Math.PI - angle;					
					if (ny >= _top && ny < _bottom)
						proportion = lambda;
				}
			}
			else if (dx < 0 && x > _right)
			{
				lambda = (_right - x) / dx;
				if (lambda < proportion)
				{
					nx = x + dx * lambda;
					ny = y + dy * lambda;
					angle = Math.PI - angle;
					
					if (ny >= _top && ny < _bottom)
						proportion = lambda;
				}
			}
			
			if (dy > 0 && y < _top)
			{
				lambda = (_top - y) / dy;
				if (lambda < proportion)
				{
					nx = x + dx * lambda;
					ny = y + dy * lambda;
					angle = -angle;
					
					if (nx >= _left && nx < _right)
						proportion = lambda;
				}
			}
			else if (dy < 0 && y > _bottom)
			{
				lambda = (_bottom - y) / dy;
				if (lambda < proportion)
				{
					nx = x + dx * lambda;
					ny = y + dy * lambda;
					angle = -angle;
					
					if (nx >= _left && nx < _right)
						proportion = lambda;
				}
			}
			
			if (result.isCollision = proportion < 1)
			{
				result.x = nx;
				result.y = ny;
				result.resultantAngularVelocity = angle < 0 ? angle + TWOPI : angle % TWOPI;
			}
			
			return result;
		}
		
	}
}
