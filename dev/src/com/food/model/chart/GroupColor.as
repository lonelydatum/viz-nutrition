package com.food.model.chart
{
	public class GroupColor
	{
		
		//private var _palletteZebra			:Array = [0x01A2A6, 0x01A2A6];
		private var _palletteZebra			:Array = [0x000000,0x000000];
		
		private var _type					:uint;
		private var _inc					:uint = 0;
		public static const ZEBRA			:uint = 0;
		
		public function GroupColor( t:uint )
		{
			_type = t;
			
		}
		
		public function getNextColor( ):Number{
			var nextColor:Number;
			switch( _type ){
				case ZEBRA:
					nextColor = getNextZebra();
				break;
			}
			
			return nextColor;
		}
		
		private function getNextZebra():Number{
			var pointer = _inc % 2;			
			_inc++;
			var colorReturn:Number = _palletteZebra[ pointer ];
			
			return colorReturn;
		}
		
	}
}