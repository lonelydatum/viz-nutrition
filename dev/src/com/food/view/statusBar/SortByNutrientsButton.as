package com.food.view.statusBar
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class SortByNutrientsButton extends Sprite
	{
		
		public var statusTxt			:TextField;
		public var sortTxt				:TextField;
		public var bg					:Sprite;
		
		public function SortByNutrientsButton()
		{
			statusTxt.autoSize = TextFieldAutoSize.LEFT;
			statusTxt.multiline = false;
		}
		
		public function setCurrentNutrient( value:String ):void
		{
			statusTxt.text = value;
			sortTxt.x = statusTxt.x + statusTxt.width;			
			
		}
	}
}