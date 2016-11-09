package com.food.contoller.events
{
	import com.food.model.data.DataFoods;
	import com.food.model.data.DataGroups;
	import com.food.model.data.DataNutrient;
	
	import flash.events.Event;
	
	public class ServiceEvent extends Event
	{
		
		public static const QUERY_BY_GROUPS			:String = "queryByGroups";
		public static const QUERY_BY_NT_FOOD		:String = "queryByNT_FD";
		public static const QUERY_BY_NT_TOTAL		:String = "queryByNTTotal";
		public static const QUERY_BY_NT_FOOD_DONE	:String = "queryByNT_FD_done";
		
		
		public var vectorNutrients				:Vector.<DataNutrient>;
		public var vectorGroups					:Vector.<DataGroups>;
		public var vectorFoods					:Vector.<DataFoods>;
		
		public var groupID						:uint;
		public var groupName					:String;
		
		public function ServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);		
			
		}
	}
}