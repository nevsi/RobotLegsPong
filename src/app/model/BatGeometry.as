package app.model 
{

	public interface BatGeometry extends Collidable
	{
		
		function set left(value:Number):void;
		function get left():Number;		
		function set right(value:Number):void;
		function get right():Number;
		
		function set top(value:Number):void;		function get top():Number;
		
		function set bottom(value:Number):void;		function get bottom():Number;		
		
	}
}
