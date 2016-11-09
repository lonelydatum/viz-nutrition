package com.food.view.header.fractal
{
	import com.food.model.data.Config;
	import com.food.model.data.DataNutrient;
	import com.food.view.header.PageBasics;
	
	import org.casalib.util.StageReference;
	
	public class PageFractal extends PageBasics
	{
		
		private var _fractal			:FoodFractal;
		
		public function PageFractal( )
		{
			super( PAGE_FRACTAL );
			colorBG = Config.PALLETE_LIGHT;
			
			
			_fractal = new FoodFractal( );
			this.addChild( _fractal );
		}
		
		public override function init():void{
			createBG();
			_fractal.startFractal();
		} 
		
		public override function destroy():void{			
			_fractal.destroy();
			this.removeChild( _fractal );
			this.parent.removeChild( this );			
			_fractal = null;
		}
	}
}