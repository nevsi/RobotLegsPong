package app.model 
{

	/**
	 * 
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public interface Collidable 
	{
		
		function collide(x:Number, y:Number, dx:Number, dy:Number):CollisionResult;
		
	}
}
