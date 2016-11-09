package com.food.view.chart
{
	import com.food.contoller.events.HoverTipEvent;
	import com.food.model.data.Config;
	import com.food.model.data.GoogleAnalytics;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.media.Sound;
	
	import org.casalib.time.EnterFrame;
	import org.casalib.util.StageReference;


	public class ViewFood extends Sprite
	{
		private var _color			:uint;		
		private var _ratio			:Number;
		
		private var _percent		:uint;		
		private var _ntAmount		:uint;
		
		public var foodName			:String;
		public var groupID			:uint;
		private var _id				:uint;
		
		
		
		private var _xInc			:uint;
		private static const  _h	:uint = 7;
		private var _w				:uint;
		
		
		public function ViewFood( )
		{
			this.buttonMode = false;
			this.addEventListener( MouseEvent.ROLL_OVER, rOver );
			this.addEventListener( MouseEvent.ROLL_OUT, rOut );
			
			this.addEventListener( MouseEvent.CLICK, function(){
				GoogleAnalytics.track( "FoodItem/Clicked/"+foodName );	
			} );
		}
		
		private function rOver( e:MouseEvent ):void{
			var snd:Sound = new SoundRollOver();
			snd.play();
			TweenMax.to(this, 2.5, {tint:0x000000, yoyo:true, repeat:-1});			
			dispatchEvent( new HoverTipEvent(HoverTipEvent.HOVER, foodName,  ntAmount, e.stageX-e.localX - 9, e.stageY-e.localY, true, true ) );
		}
		
		private function rOut( e:MouseEvent ):void{
			this.transform.colorTransform = new ColorTransform();
			TweenLite.killTweensOf( this );
			
			dispatchEvent( new HoverTipEvent(HoverTipEvent.HOVER_OUT, foodName, ntAmount, e.stageX, e.stageY, true, true ) );
		}
		
		public function render():void
		{			
			this.graphics.clear();
			this.graphics.beginFill( _color );
			var sw:Number = StageReference.getStage().stageWidth;
			
			this.graphics.drawRect( 0, 0, _w, _h );			
			this.graphics.endFill();	
		}
		
		public function reset():void
		{
			this.removeEventListener( MouseEvent.ROLL_OVER, rOver );
			this.removeEventListener( MouseEvent.ROLL_OUT, rOut );
			this.alpha = Math.random();
		}
		
		public function set xInc( value:uint ):void
		{
			_xInc = value;
			var posArray:uint = _xInc % Config.COLOR_PALLETE.length;			
			//color = Config.COLOR_PALLETE[ posArray ];
		}
		
		public function set ratio( value:Number ):void{
			_ratio = value;
			_w = _ratio * _ntAmount;
		}
		
		public function set color( value:uint ):void{ _color = value; }
		public function set percent( value:uint ):void{ _percent = value; }
		public function set id( value:uint ):void{ _id = value; }
		public function set ntAmount( value:uint ):void{ _ntAmount = value; }
		
		public function get w( ):uint{ return _w; }
		public function get ntAmount( ):uint{ return _ntAmount; }
		public function get h( ):uint{ return _h; }
		
	}
}