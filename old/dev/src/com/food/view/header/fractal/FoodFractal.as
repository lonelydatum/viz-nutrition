package com.food.view.header.fractal
{
	import caurina.transitions.TweenListObj;
	
	import com.food.contoller.events.NutritionEvent;
	import com.food.model.data.Config;
	import com.food.model.data.DataNutrient;
	import com.food.model.data.Singleton;
	import com.greensock.TweenLite;
	
	import flash.events.Event;
	import flash.text.Font;
	
	import org.casalib.transitions.Tween;
	import org.casalib.util.StageReference;

	public class FoodFractal extends EmotionFractal
	{
		private static const GAP	:uint = 10;
		
		public function FoodFractal( )
		{
			super( );
			this.font = new Config.FONT_BOOK();
			this.color = Config.PALLETE_DARK;									
			addEventListener(Event.ADDED_TO_STAGE, added );						
		}
				
		private function added( e:Event ):void{
			removeEventListener( Event.ADDED_TO_STAGE, added );			
		}
		
		public override function nutritionChangedHandler(e:NutritionEvent):void{
			for( var j:uint=0;j<this.numChildren;j++ ){				
				TweenLite.to( this.getChildAt(j), Math.random(), {alpha:0, delay:Math.random()} );
			}
			this.mouseChildren = false;
			removeEventListener(Event.ENTER_FRAME, fill);
		}
				
		private function parsApplyPercentValues():void
		{			
			var total:uint = 0;
			var _vectorNutrients:Vector.<DataNutrient> = Singleton.instance.vectorNutrients;
			for( var i:uint=0;i<_vectorNutrients.length;i++){
				total = total + Number(_vectorNutrients[i].Total);				
			}
			
			for( var j:uint=0;j<_vectorNutrients.length;j++){
				var percent:Number = _vectorNutrients[j].Total/total;
			}
		}
		
		
		
		private function position( ):void{			
		}
		
		public function startFractal():void
		{
			init();
		}
		
		public function destroy():void{			
			destroyEmotionFractal();					
		}
		
	}
}