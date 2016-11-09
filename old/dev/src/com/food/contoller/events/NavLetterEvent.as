package com.food.contoller.events
{
	import flash.events.Event;
	
	public class NavLetterEvent extends Event
	{
		
		public static const LETTER_SELECTED				:String="letterSelected";
		public static const NEXT						:String="next";
		public static const PREV						:String="prev";
		public var letter								:String;
		
		public function NavLetterEvent(type:String, letter:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.letter = letter;
		}
	}
}