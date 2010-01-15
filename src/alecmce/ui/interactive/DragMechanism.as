package alecmce.ui.interactive 
{
	import org.osflash.signals.Signal;

	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * Allows items to be dragged
	 * 
	 * (c) 2009 alecmce.com
	 *
	 * @author Alec McEachran
	 */
	public class DragMechanism 
	{
		private var _startDrag:Signal;
		private var _dragging:Signal;
		private var _endDrag:Signal;
		
		private var _draggables:Array;
		private var _bounds:Array;
		
		private var _offsetX:Number;
		
		private var _offsetY:Number;
		
		private var _dragee:InteractiveObject;
		private var _bounded:Rectangle;
		
		public function DragMechanism()
		{
			_startDrag = new Signal(InteractiveObject);
			_dragging = new Signal();
			_endDrag = new Signal(InteractiveObject);
			
			_draggables = [];
			_bounds = [];
		}
		
		public function apply(target:InteractiveObject, bounds:Rectangle = null):void
		{
			if (_draggables.indexOf(target) != -1)
				return;
			
			_draggables.push(target);
			_bounds.push(bounds);
			addEventListeners(target);
		}
		
		public function clear(target:InteractiveObject):void
		{
			var i:int = _draggables.indexOf(target);
			_draggables.splice(i, 1);
			_bounds.splice(i, 1);
			
			removeEventListeners(target);
			
			if (_dragee == target)
				_dragee = null;
		}
		
		public function clearAll():void
		{
			var i:int = _draggables.length;
			while (--i > -1)
			{
				var target:InteractiveObject = _draggables[i];
				clear(target);
			}
			
			_draggables.length = 0;
			_bounds.length = 0;
		}

		private function addEventListeners(target:InteractiveObject):void
		{
			if (target.stage)
			{
				target.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
				target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			}
			else
			{
				target.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}		}
		
		private function removeEventListeners(target:InteractiveObject):void
		{
			target.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);			target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			if (target.stage)
				target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onAddedToStage(event:Event):void
		{
			var target:InteractiveObject = InteractiveObject(event.currentTarget);			
			target.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			target.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);			
			target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		private function onRemovedFromStage(event:Event):void
		{
			var target:InteractiveObject = InteractiveObject(event.currentTarget);
			
			target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			target.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		protected function onMouseDown(event:MouseEvent):void
		{
			var target:InteractiveObject = InteractiveObject(event.currentTarget);
			
			var i:int = _draggables.indexOf(target);
			_bounded = _bounds[i];
			
			_dragee = target;
			_dragee.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);			_dragee.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			
			_offsetX = event.stageX - target.x;			_offsetY = event.stageY - target.y;
			
			_startDrag.dispatch(_dragee);
		}

		protected function onMouseUp(event:MouseEvent):void
		{
			var old:InteractiveObject = _dragee;
			
			_dragee.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);			_dragee.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_dragee = null;
			
			_bounded = null;
			
			_endDrag.dispatch(old);
		}

		protected function onMouseMove(event:MouseEvent):void
		{
			var x:Number = event.stageX + _offsetX;
			var y:Number = event.stageY + _offsetY;
			
			if (_bounded)
			{
				if (x > _bounded.right)
					x = _bounded.right;
				else if (x < _bounded.left)
					x = _bounded.left;
				
				if (y < _bounded.top)
					y = _bounded.top;
				else if (y > _bounded.bottom)
					y = _bounded.bottom;
			}
			
			_dragee.x = x;			_dragee.y = y;
			
			event.updateAfterEvent();
			_dragging.dispatch();
		}
		
		public function get startDrag():Signal
		{
			return _startDrag;
		}
		
		public function get dragging():Signal
		{
			return _dragging;
		}
		
		public function get endDrag():Signal
		{
			return _endDrag;
		}
	}
}
