package com.food.contoller.events
{
	import flash.events.Event;
	
	public class NavEvent extends Event
	{
		
		public static const			NAV_SELECTED			:String = "navSelected";		
		public var navType									:uint;
		
		public function NavEvent(type:String, nType:uint, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.navType = nType;
		}
	}
}