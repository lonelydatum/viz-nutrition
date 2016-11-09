package com.food.view.header.nutrientReport
{
	import com.food.model.data.Config;
	import com.food.model.data.DataFoods;
	import com.food.model.data.Singleton;
	import com.food.model.data.Style;
	import com.food.view.common.TextFieldFood;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	public class LegendItem extends Sprite
	{
		
		private var _color			:Number;
		private var _dot			:Shape;
		private var _label			:TextFieldFood
		
		
		public function LegendItem( dataFoods:DataFoods, color:Number )
		{
			_color = color;
			
			var radius:uint = 8;
			_dot = new Shape();
			_dot.graphics.beginFill( _color );			
			_dot.graphics.drawEllipse( radius, radius-5, radius, radius );
			this.addChild( _dot );
			
			
			
			var formatBody:TextFormat = Style.body();
			_label = new TextFieldFood();
			
			//_label.border = true;
			_label.textColor = Config.PALLETE_DARK;
			_label.x = radius + 10;
			_label.width = 215;
			
			_label.multiline = false;
			_label.wordWrap = false;
			
			_label.defaultTextFormat = formatBody;
			var unit:String = Singleton.instance.selectedNutrient.UNIT;
			_label.text = "["+dataFoods.NT_VALUE +" "+unit+"] "+ dataFoods.A_FD_NME;
			
			this.addChild( _label );
			
		}
		
		public function highlight():void
		{
			this.graphics.beginFill(_color,.3);
			this.graphics.drawRect(20,0,width-2,15);
			this.graphics.endFill();
			//_label.textColor = _color;
				
		}
		
		public function highlightRelease():void
		{
			this.graphics.clear();
			//_label.textColor = Config.PALLETE_DARK;
		}
	}
}