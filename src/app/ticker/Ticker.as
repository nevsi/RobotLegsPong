package app.ticker 
{

	public interface Ticker 
	{
		
		function start():void;
		
		function stop():void;
		
		function add(fn:Function):void;
		
		function remove(fn:Function):void;
		
	}
}
