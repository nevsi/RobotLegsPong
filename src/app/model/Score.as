package app.model 
{
	import org.osflash.signals.Signal;
	
	public interface Score 
	{
		
		function get changed():Signal;
		
		function incrementLeftScore():void
		
		function get currentLeftScore():uint
		
		function incrementRightScore():void
		
		function get currentRightScore():uint
		
	}
}
