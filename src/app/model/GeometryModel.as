package app.model 
{
	import app.ticker.Ticker;

	import org.osflash.signals.Signal;

	import flash.geom.Rectangle;

	public class GeometryModel implements Geometry
	{
		
		private const DEFAULT_SPEED:uint = 6;
		private const DEFAULT_RADIUS:uint = 10;
		private const WIDTH:uint = 800;
		private const HEIGHT:uint = 600;
		private const PADDING:uint = 50; 
		
		[Inject]
		public var score:Score;
		
		[Inject]
		public var ticker:Ticker;
		
		private var _collidables:Array;
		private var _count:uint;
		
		private var _ballAtLeftEdge:Signal;
		
		private var _ballAtRightEdge:Signal;
		
		private var _area:Rectangle;
		
		private var _inner:Rectangle;
		
		private var _x:Number;
		
		private var _y:Number;
		
		private var _radius:uint;
		
		private var _speed:uint;
		
		private var _angle:Number;
		
		private var _dx:Number;
		
		private var _dy:Number;

		public function GeometryModel()
		{
			_collidables = [];
			_count = 0;
			_ballAtLeftEdge = new Signal();			_ballAtRightEdge = new Signal();
			
			setup();
		}
		
		[PostConstruct]
		public function init():void
		{
			ticker.add(iterate);
		}
		
		public function addCollidable(collidable:Collidable):void
		{
			if (_collidables.indexOf(collidable) == -1)
			{
				_collidables.push(collidable);
				_count++;
			}
		}
		
		public function removeCollidable(collidable:Collidable):void
		{
			var i:int = _collidables.indexOf(collidable);
			if (i != -1)
			{
				_collidables.splice(i, 1);
				_count--;
			}
		}
		
		public function setup():void
		{
			_area = new Rectangle(PADDING, PADDING, WIDTH - (2 * PADDING), HEIGHT - (2 * PADDING));
			_radius = DEFAULT_RADIUS;
			_inner = new Rectangle(_area.left + _radius, _area.top + _radius, _area.width - 2 * _radius, _area.height - 2 * _radius);
			_x = WIDTH >> 1;
			_y = HEIGHT >> 1;
			_speed = DEFAULT_SPEED;
			_angle = Math.random() * Math.PI * 2;
			
			updateVelocityVector();
		}
				
		public function get x():Number
		{
			return _x;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function get dx():Number
		{
			return _dx;
		}
		
		public function get dy():Number
		{
			return _dy;
		}
		
		public function iterate():void
		{
			var i:int = _count;
			while (i--)
			{
				var collidable:Collidable = _collidables[i];
				var result:CollisionResult = collidable.collide(_x, _y, _dx, _dy);
				
				if (result.isCollision)
				{
					_x = result.x;
					_y = result.y;
					angle = result.resultantAngularVelocity;
				}
			}

			_x += _dx;
			_y += _dy;
			
			if (_dy < 0 && _y < _inner.top)
			{
				_y = 2 * _inner.top - _y;
				_dy *= -1;
			}
			else if (_y > _inner.bottom)
			{
				_y = 2 * _inner.bottom - _y;
				_dy *= -1;
			}
			
			if (_dx < 0 && _x < _inner.left)
			{
				_x = 2 * _inner.left - _x;
				_dx *= -1;
				score.incrementRightScore();
			}
			else if (_x > _inner.right)
			{
				_x = 2 * _inner.right - _x;
				_dx *= -1;
				score.incrementLeftScore();
			}
		}
		
		public function get ballAtLeftEdge():Signal
		{
			return _ballAtLeftEdge;
		}
		
		public function get ballAtRightEdge():Signal
		{
			return _ballAtRightEdge;
		}
		
		public function get speed():uint
		{
			return _speed;
		}
		
		public function set speed(speed:uint):void
		{
			_speed = speed;
			updateVelocityVector();
		}
		
		public function get angle():Number
		{
			return _angle;
		}
		
		public function set angle(angle:Number):void
		{
			_angle = angle;
			updateVelocityVector();
		}
		
		private function updateVelocityVector():void
		{
			_dx = _speed * Math.cos(_angle);
			_dy = _speed * Math.sin(_angle);
		}
		
		public function get radius():uint
		{
			return _radius;
		}
		
		public function set radius(radius:uint):void
		{
			_radius = radius;
		}
		
		public function get area():Rectangle
		{
			return _area;
		}
		
		public function collide(x:Number, y:Number, angle:Number):void
		{
			_x = x;
			_y = y;
			_angle = angle;
			updateVelocityVector();
		}
		
	}
}
