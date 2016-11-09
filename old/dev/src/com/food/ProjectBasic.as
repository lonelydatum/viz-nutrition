package com.food
{
	import com.food.FoodMain;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	public class ProjectBasic extends FoodMain
	{
		
		private var timer			:Timer 
		private var lastPoint		:Point;
		private var msk				:Shape = new Shape();
		
		public function ProjectBasic()
		{
			if( stage ){
				added( null );
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE,added);
			}
		}
		
		private function added( e:Event ):void
		{
			var timeOut:String = (stage.loaderInfo.parameters.timeOut) ?  stage.loaderInfo.parameters.timeOut : "true";			
			if( timeOut=="true" ) hasTimeOut();
		}
		
		private function hasTimeOut():void
		{
			var timeLimit:uint = (stage.loaderInfo.parameters.timeLimit) ? stage.loaderInfo.parameters.timeLimit : 2000;
			timer = new Timer( timeLimit );
			this.removeEventListener(Event.ADDED_TO_STAGE,added);
			timer.addEventListener(TimerEvent.TIMER, tickHandler, false,0,true);
			lastPoint = returnPoint();
			
			timer.start();
		}
		
		private function createMask():void{
			var r:uint = 700;
			msk.graphics.beginFill(0xFF0000,.5);
			msk.graphics.drawEllipse( -r,-r,r*2,r*2 );
			msk.graphics.endFill();
			var diffX:Number = ( stage.stageWidth - loaderInfo.width ) * .5;
			var diffY:Number = ( stage.stageHeight - loaderInfo.height ) * .5;
			msk.x = (loaderInfo.width * .5) + diffX;
			msk.y = (loaderInfo.height * .5) + diffY;
			msk.scaleX = 1;
			msk.scaleY = 1;
			this.addChild(msk);
			this.mask = msk;			
		}
		
		private function tickHandler( e:TimerEvent ):void
		{
			checkMouseMovement();
		}
		
		private function checkMouseMovement():void
		{			
			if( returnPoint().x == lastPoint.x && returnPoint().y == lastPoint.y ){				
				//createMask();
				//TweenLite.to( msk, 1, { scaleX:0, scaleY:0, onComplete:destroy } );
				ExternalInterface.call( "confirmBox" );
			}else{
			}
			lastPoint = returnPoint();
		}
		
		private function returnPoint():Point
		{
			return new Point(stage.mouseX, stage.mouseY);
		} 
		
		private function destroy():void
		{
			timer.removeEventListener(TimerEvent.TIMER, tickHandler );
			timer.stop();
			timer = null;
			ExternalInterface.call( "loadProject", "gradshowMenu.swf" );
		}
		
	}
}