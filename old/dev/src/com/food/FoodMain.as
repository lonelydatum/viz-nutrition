package com.food
{
	import com.food.contoller.Controller;
	import com.food.model.data.GoogleAnalytics;
	import com.food.view.statusBar.NutrientInfo;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	
	import net.hires.debug.Stats;
	
	import org.casalib.math.geom.Ellipse;
	import org.casalib.util.DrawUtil;
	import org.casalib.util.RatioUtil;
	import org.casalib.util.StageReference;
	
	public class FoodMain extends Sprite
	{
		
		private var _controller			:Controller;
		
		public function FoodMain()
		{
			
			StageReference.setStage( this.stage );
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			GoogleAnalytics.track( "/" );
			
			init();			
		}
		
		private function init():void{
			var base:Sprite = this.addChild( new Sprite() ) as Sprite;
			_controller = new Controller( base );			
		}
		
		private function createStats():void
		{
			var stats:Stats = new Stats();
			stats.x = stage.stageWidth - 70;
			this.addChild( stats );
		}
			
	}
}