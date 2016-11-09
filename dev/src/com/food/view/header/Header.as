package com.food.view.header
{
	import com.food.model.data.Config;
	import com.food.model.data.DataGroups;
	import com.food.model.data.DataNutrient;
	import com.food.view.header.fractal.FoodFractal;
	import com.food.view.header.fractal.PageFractal;
	import com.food.view.header.list.PageList;
	import com.food.view.header.nutrientReport.PageNutrientReport;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.casalib.util.StageReference;
	
	public class Header extends Sprite
	{
		
		private var _total				:Number;
		private var _pageCurr			:PageBasics;
		private var _pagePrev			:PageBasics;
		
		public function Header()
		{
			this.alpha = 0;
			this.addEventListener(Event.ADDED_TO_STAGE, function():void{
				
			});
		}
		
				
		public function createNewPage( pageType:uint ):void{
			TweenLite.to( this, 5, {alpha:1, delay:1} );
			_pagePrev = _pageCurr;
			
			if( _pagePrev ){
				_pagePrev.transOut();				
			}
			
			switch( pageType ){
				case PageBasics.PAGE_FRACTAL:
				_pageCurr = new PageFractal( );
				break;	
				
				case PageBasics.PAGE_LIST:
				_pageCurr = new PageList( );
				break;
				
				case PageBasics.PAGE_REPORT:
				_pageCurr = new PageNutrientReport( );
				break;
			}
			
			
			
			this.addChild( _pageCurr );
			_pageCurr.init();
			
		}
		
		public function removePage():void{
			
		}
		
	 
	}
}