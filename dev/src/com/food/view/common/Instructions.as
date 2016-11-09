package com.food.view.common
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Instructions extends Sprite
	{
		public function Instructions()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true );
		}
		
		private function added( e:Event ):void
		{
			TweenLite.from( this, .8, { alpha:0, delay:5, y:this.y+50, ease:Quad.easeOut } )
		}
		
		public function transOut():void
		{
			TweenLite.to( this, .3, { alpha:0, onComplete:transOutDone, y:this.y-35, ease:Quad.easeIn } )
		}
		
		private function transOutDone( ):void
		{
			try{
				this.parent.removeChild( this );
			}catch(e:Error){
				trace(e.message);
			}
		}
	}
}