package app.model 
{
	import asunit.asserts.assertEquals;
	import asunit.asserts.assertFalse;
	import asunit.asserts.assertTrue;

	public class BatGeometryTest 
	{
		public var model:BatGeometry;
		public var result:CollisionResult;
		
		[Before]
		public function setup():void
		{
			model = new BatGeometryModel();
			
			model.left = 100;
			model.right = 120;
			model.top = 100;
			model.bottom = 200;
		}
		
		[After]
		public function teardown():void
		{
			model = null;
			result = null;
		}
		
		[Test]
		public function ballDoesNotCollide():void
		{
			result = model.collide(0, 0, 50, 50);
			assertFalse(result.isCollision);
		}
		
		[Test]
		public function ballHitsLeftEdge():void
		{
			result = model.collide(50, 150, 100, 0);			assertTrue(result.isCollision);			assertEquals(100, result.x);
			assertEquals(150, result.y);			assertEquals(Math.PI, result.resultantAngularVelocity);
		}
		
		[Test]
		public function ballHitsRightEdge():void
		{
			result = model.collide(170, 150, -100, 0);
			assertTrue(result.isCollision);			assertEquals(120, result.x);
			assertEquals(150, result.y);
			assertEquals(0, result.resultantAngularVelocity);
		}
		
		[Test]
		public function ballHitsTopEdge():void
		{
			result = model.collide(110, 50, 0, 100);
			assertTrue(result.isCollision);			assertEquals(110, result.x);
			assertEquals(100, result.y);
			assertEquals(Math.PI * 1.5, result.resultantAngularVelocity);
		}
		
		[Test]
		public function ballHitsBottomEdge():void
		{
			result = model.collide(110, 250, 0, -100);
			assertTrue(result.isCollision);
			assertEquals(110, result.x);
			assertEquals(200, result.y);
			assertEquals(Math.PI * 0.5, result.resultantAngularVelocity);
		}
		
	}
}
