package com.food.view.statusBar.buttons
{
	import com.food.contoller.events.NavToggleEvent;
	import com.food.model.data.Config;
	import com.food.model.data.GoogleAnalytics;
	import com.food.model.data.Style;
	import com.food.view.common.TextFieldFood;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ToggleButtonItem extends Sprite
	{
		
		
		private var _label				:TextFieldFood;
		private var _radio				:Sprite;
		private var _circleBG			:Shape;
		private var _circleSelected		:Shape;
		private var _circleRover		:Shape;
		private var _toggleValue		:uint;
		
		private static const RADIUS_BG			:uint = 12;
		private static const RADIUS_SELECTED	:uint = 9;
		public static const SELECTED_RADIO		:String = "selectedRadio";
		
		
		
		public function ToggleButtonItem( toggleValue:uint, labelMsg:String )
		{
			_toggleValue = toggleValue;
			
			_label = new TextFieldFood();
			
			var font:Font = new Config.FONT_BODY();
			var format:TextFormat = new TextFormat();			
			format.font = font.fontName;
			format.size = 16;
			_label.setFormat( format );
			
			_label.text = labelMsg;
			_label.y = 2;
			
			this.addChild( _label );
			
			_radio = new Sprite();
			
			_radio.x = _label.x + _label.width+5 + RADIUS_BG-3;
			_radio.y = RADIUS_BG;
			this.addChild(_radio);
			
			_circleBG = new Shape();
			_circleBG.filters = [ new DropShadowFilter( 5, 90, 0x000000,.35,6,6, 1,1,true) ];
			_circleBG.graphics.beginFill(0xFFFFFF);
			_circleBG.graphics.drawEllipse(-RADIUS_BG,-RADIUS_BG,RADIUS_BG*2,RADIUS_BG*2);
			_circleBG.graphics.endFill();
			_radio.addChild(_circleBG);
			
			
			
			
			
			_circleRover = new Shape();
			_circleRover.alpha = 0;
			_circleRover.graphics.beginFill(0xe8a130);			
			_circleRover.graphics.drawEllipse( -RADIUS_SELECTED, -RADIUS_SELECTED, RADIUS_SELECTED*2, RADIUS_SELECTED*2 );
			_circleRover.graphics.endFill();
			_radio.addChild(_circleRover);
			
			
			_circleSelected = new Shape();
			_circleSelected.graphics.beginFill(0x222222);
			_circleSelected.graphics.drawEllipse( -RADIUS_SELECTED, -RADIUS_SELECTED, RADIUS_SELECTED*2, RADIUS_SELECTED*2 );
			_circleSelected.graphics.endFill();
			_radio.addChild(_circleSelected);
			
			
			isNOTSelected();
			
			
		}
		
		private function onSelectedHandler( e:MouseEvent ):void
		{
			GoogleAnalytics.track( "Nav/Toggleview/"+_label.text );
			dispatchEvent( new NavToggleEvent(NavToggleEvent.TOGGLE, _toggleValue ) );			
		}
		
		private function rOver( e:MouseEvent ):void
		{
			TweenLite.to( _circleRover, .2, { alpha:1 } )
			//_circleRover.alpha = 1;			
		}
		
		private function rOut( e:MouseEvent ):void
		{
			_circleRover.alpha = 0;
		}
		
		public function isSelected():void
		{
			_circleSelected.alpha = 1;
			_radio.removeEventListener(MouseEvent.CLICK, onSelectedHandler );
			_radio.removeEventListener(MouseEvent.ROLL_OVER, rOver );
			_radio.removeEventListener(MouseEvent.ROLL_OUT, rOut );
			_radio.buttonMode = false;
			_circleRover.alpha = 0;
		}
		
		public function isNOTSelected():void
		{			
			_circleSelected.alpha = .3;
			_circleRover.alpha = 0;
			_radio.addEventListener(MouseEvent.CLICK, onSelectedHandler, false, 0, true);
			_radio.addEventListener(MouseEvent.ROLL_OVER, rOver, false, 0, true);
			_radio.addEventListener(MouseEvent.ROLL_OUT, rOut, false, 0, true);
			_radio.buttonMode = true;
		}
		
		public function get label():TextField
		{
			return _label;	
		}
	}
}