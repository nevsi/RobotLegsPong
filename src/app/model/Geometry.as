package app.model 
{
	import flash.geom.Rectangle;

	public interface Geometry 
	{
		function addCollidable(collidable:Collidable):void;
		
		function removeCollidable(collidable:Collidable):void;
		
		function setup():void;
		
		function iterate():void;
		
		function get area():Rectangle;
		
		function get x():Number;
		
		function get y():Number;
		
		function get dx():Number;
		
		function get dy():Number;
		
		function get radius():uint;
		
		function get angle():Number;
		
		function collide(x:Number, y:Number, angle:Number):void;
		
	}
}
