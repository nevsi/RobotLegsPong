package app.model 
{

	public class CollisionResult 
	{
		
		public var isCollision:Boolean;
		
		public var x:Number;
		
		public var y:Number;
		
		public var resultantAngularVelocity:Number;
		
		public function CollisionResult(isCollision:Boolean)
		{
			this.isCollision = isCollision;
		}
	}
}
