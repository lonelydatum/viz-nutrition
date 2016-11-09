package com.food.view.header.fractal
{
	import com.food.contoller.events.NutritionEvent;
	import com.food.model.data.Config;
	import com.food.model.data.DataNutrient;
	import com.food.model.data.GoogleAnalytics;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.media.Sound;
	
	public class NutritionWord extends Sprite
	{
		public var dataNutrient		:DataNutrient;
		
		
		public function NutritionWord()
		{
			this.buttonMode = true;
			
			this.addEventListener( MouseEvent.CLICK, onClicked, false, 0, true );
			this.addEventListener( MouseEvent.ROLL_OVER, rOver, false, 0, true );
			this.addEventListener( MouseEvent.ROLL_OUT, rOut, false, 0, true );	
			
		}
		
		private function onClicked( e:MouseEvent ):void
		{			
			GoogleAnalytics.track( "NutrientSelection/Fractals/"+dataNutrient.NT_NME );
			dispatchEvent( new NutritionEvent( NutritionEvent.CHANGE_NUTRIENT, dataNutrient, true ) );
		}
		
		private function rOver( e:MouseEvent ):void
		{
			var snd:Sound = new SoundRollOver();
			snd.play();
			var ct:ColorTransform = this.transform.colorTransform;
			ct.color = 0x376973;
			this.transform.colorTransform = ct;
		}
		
		private function rOut( e:MouseEvent ):void
		{
			this.transform.colorTransform = new ColorTransform();
		}
		
		
	}
}