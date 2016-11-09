package com.food.view.header.nutrientReport
{
	import com.food.model.data.DataFoods;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Wedge extends Sprite
	{
		
		private var _id				:uint;
		private var _dataFood		:DataFoods;
		
		public function Wedge( id:uint, datafood:DataFoods )
		{
			_id = id;
			_dataFood = datafood;
			this.buttonMode = true;
		}
		
		public function get id():uint{
			return _id;
		}
		
		public function get datafood():DataFoods{
			return _dataFood;
		}
		
	}
}