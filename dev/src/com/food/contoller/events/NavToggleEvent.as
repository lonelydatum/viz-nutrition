package com.food.contoller.events
{
	import flash.events.Event;
	
	public class NavToggleEvent extends Event
	{
		
		public static const TOGGLE			:String = "toggle";
		public var toggleValue				:uint;
		
		public function NavToggleEvent(type:String, toggleValue:uint, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.toggleValue = toggleValue;
		}
	}
}