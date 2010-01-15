package app.view.mediator 
{
	import alecmce.ui.interactive.DragMechanism;

	import app.model.BatGeometry;
	import app.model.Geometry;
	import app.view.component.Bat;

	import org.robotlegs.mvcs.Mediator;

	import flash.display.InteractiveObject;
	import flash.geom.Rectangle;

	public class BatMediator extends Mediator 
	{
		[Inject]
		public var view:Bat;
		
		[Inject]
		public var bat:BatGeometry;
		
		[Inject]
		public var model:Geometry;
		
		[Inject]
		public var drag:DragMechanism;
		
		private var bounds:Rectangle;

		override public function onRegister():void
		{
			var top:uint = model.area.top;
			var bottom:uint = model.area.bottom;
			var rect:Rectangle = new Rectangle(view.x, top, 0, bottom - top);
			
			bounds = view.getRect(view);
			bat.left = view.x + bounds.left;
			bat.right = view.x +  bounds.right;			bat.top = view.y + bounds.top;
			bat.bottom = view.y + bounds.bottom;
			
			drag.apply(view, rect);
			drag.startDrag.add(onDragStart);
		}
		
		private function onDragStart(object:InteractiveObject):void
		{
			if (object == view)
			{
				drag.dragging.add(update);
				drag.endDrag.add(onDragEnd);
			}
		}
		
		public function update():void
		{
			bat.top = view.y + bounds.top;
			bat.bottom = view.y + bounds.bottom;
		}
		
		private function onDragEnd(object:InteractiveObject):void
		{
			drag.dragging.remove(update);
			drag.endDrag.remove(update);
		}
		
	}
}
