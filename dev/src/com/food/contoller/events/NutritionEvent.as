package com.food.contoller.events
{
	import com.food.model.data.DataNutrient;
	
	import flash.events.Event;
	
	public class NutritionEvent extends Event
	{
		
		public static const CHANGE_NUTRIENT				:String = "changeNutrient";
		public var id									:uint;
		public var dataNutrient							:DataNutrient;
		
		public var percent								:Number;
		
		
		public function NutritionEvent(type:String, dataNutrient:DataNutrient, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);			
			this.dataNutrient = dataNutrient;
		}
	}
}