package com.food.contoller.events
{
	import flash.events.Event;
	
	public class HoverTipEvent extends Event
	{
		
		public static const HOVER			:String="hover";
		public static const HOVER_OUT		:String="hoverOut";
		public var foodName					:String;
		public var amount					:Number;
		public var stageX					:uint;
		public var stageY					:uint;
		
		public function HoverTipEvent(type:String, foodName:String, amount:Number, stageX:uint, stageY:uint, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.foodName = foodName;
			this.amount = amount;
			this.stageX = stageX;
			this.stageY = stageY;
		}
	}
}