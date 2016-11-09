package com.food.model.data
{
	public class Singleton
	{
		public static var instance:Singleton;
		
		public var vectorNutrients			:Vector.<DataNutrient>
		public var vectorGroups				:Vector.<DataGroups>
		public var vectorFoods				:Vector.<DataFoods>
		
		public var selectedNutrient			:DataNutrient;
		
		public var colorFoodGroups			:Vector.<ColorFoodGroups>;
		
		public static function getInstance():Singleton
		{
			if( instance == null ) instance = new Singleton( new SingletonEnforcer() );
			return instance;
		}
		
		public function Singleton( pvt:SingletonEnforcer )
		{
			// init class
		}
	}
}

internal class SingletonEnforcer{}