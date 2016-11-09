package com.food.view.common
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Preloader extends Sprite
	{
		
		private var _msk			:Shape;
		public var spinner			:MovieClip;
		
		public function Preloader()
		{
			super();
			var r:uint = 235;
			_msk = new Shape();
			_msk.graphics.beginFill(0xFF0000,.3);
			_msk.graphics.drawEllipse(-r, -r, r*2, r*2 );
			_msk.graphics.endFill();
			
			this.mask = _msk;
			this.addChild(_msk);
			this.addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true );
			
		}
		
		private function added( e:Event ):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, added );
			this.x = stage.stageWidth * .5;
			this.y = stage.stageHeight * .5;
			TweenLite.from( _msk, .7, { scaleX:0, scaleY:0, delay:.3 } );
		}
		
		public function transOut():void
		{
			TweenLite.to( _msk, .7, { scaleX:0, scaleY:0, onComplete:destroy, delay:.5 } );
		}
		
		private function destroy():void
		{
			this.parent.removeChild(this);
			spinner.stop();
		}
		
	}
}