package com.food.view.common
{
	import com.food.model.data.Config;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.events.Event;
	
	public class BackgroundStage extends Shape
	{
		public function BackgroundStage()
		{
			this.addEventListener( Event.ADDED_TO_STAGE, added, false, 0, true );
		}
		
		private function added( e:Event ):void
		{
			this.removeEventListener( Event.ADDED_TO_STAGE, added );
			this.stage.addEventListener( Event.RESIZE, function(){
				createBg();
			});
			
			createBg();
			
			TweenLite.from( this, 3, { alpha:0 } );
		}
		
		private function createBg():void{
			this.graphics.clear();
			this.graphics.beginFill( Config.COLOR_BG );
			this.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			this.graphics.endFill();
		}
	}
}