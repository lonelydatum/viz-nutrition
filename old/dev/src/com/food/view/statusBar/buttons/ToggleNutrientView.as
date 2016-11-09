package com.food.view.statusBar.buttons
{
	import com.food.contoller.events.NavEvent;
	import com.food.contoller.events.NavToggleEvent;
	import com.food.model.data.Config;
	import com.food.model.data.Style;
	import com.food.view.common.TextFieldFood;
	import com.food.view.header.PageBasics;
	import com.food.view.statusBar.BgHighlight;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.casalib.util.StageReference;
	
	public class ToggleNutrientView extends NavItem
	{
		
		private var txt				:TextFieldFood;
		private var bg				:BgHighlight;
		
		private var _radioPopular	:ToggleButtonItem;
		private var _radioAZ		:ToggleButtonItem;
		private var _yPos			:uint = 13;
		
		
		public function ToggleNutrientView()
		{
			super( PageBasics.PAGE_LIST );
			bg = new BgHighlight();
			bg.height += 1;
			this.addChildAt(bg,0);
			
			txt = new TextFieldFood( );		
			
			var format:TextFormat = Style.header();			
			format.size = 16;
			txt.setFormat( format );
			txt.text = "VIEW NUTRIENTS:";
			this.addChild(txt);
			
			_radioPopular = new ToggleButtonItem( PageBasics.PAGE_FRACTAL, "by common" );
			_radioAZ = new ToggleButtonItem( PageBasics.PAGE_LIST, "by a-z" );
			_radioPopular.addEventListener(NavToggleEvent.TOGGLE, onToggleHandler );
			_radioAZ.addEventListener(NavToggleEvent.TOGGLE, onToggleHandler );
			
			txt.y = _yPos;
			_radioPopular.y = _yPos;
			_radioAZ.y = _yPos;
			
			
			_radioPopular.x = txt.x + txt.width + 5;
			this.addChild( _radioPopular );
			
			_radioAZ.x = _radioPopular.x + _radioPopular.width + 5;
			this.addChild( _radioAZ );
			
			isNotSelected();
			
			this.removeEventListener( MouseEvent.CLICK, onClickHandler );
		}
		
		private function onToggleHandler( e:NavToggleEvent ):void
		{			
			updateRadioButtons( e.toggleValue );
			
			dispatchEvent( new NavEvent( NavEvent.NAV_SELECTED, e.toggleValue ) );
		}
		
		public override function onClickHandler( e:MouseEvent ):void
		{
			var switchViewTo:uint = ( _navType==PageBasics.PAGE_LIST) ?  PageBasics.PAGE_FRACTAL: PageBasics.PAGE_LIST;
			_navType = switchViewTo;
		}
		
		public override function isSelected():void{		
			
			bg.alpha = 1;
			txt.textColor = 0x222222;
			_radioPopular.label.textColor = 0x222222;
			_radioAZ.label.textColor = 0x222222;	
			
			//bg.x = -bg.width
			//TweenLite.to( bg, 1, { x:0 } );
		}
		
		public override function isNotSelected():void
		{
			bg.alpha = 0;
			txt.textColor = 0xFFFFFF;
			_radioPopular.label.textColor = 0xFFFFFF;
			_radioAZ.label.textColor = 0xFFFFFF;	
			_radioPopular.isNOTSelected();
			_radioAZ.isNOTSelected();
			
			var sw:uint = StageReference.getStage().stageWidth;
			//TweenLite.to( bg, 1, { x:-bg.width } );
			
			
		}
		
		public function updateRadioButtons( toggleValue:uint ):void
		{
			if( toggleValue == PageBasics.PAGE_FRACTAL ){
				_radioPopular.isSelected();
				_radioAZ.isNOTSelected();
			}else if( toggleValue == PageBasics.PAGE_LIST ){
				_radioPopular.isNOTSelected();
				_radioAZ.isSelected();
			}
		}
		
		public function position():void
		{
			var sw:uint = StageReference.getStage().stageWidth; 
			this.x = sw * .5;
			bg.width = sw;
			_radioAZ.x = ( sw * .5 ) - _radioAZ.width - Config.PADDING_RIGHT;
			_radioPopular.x = _radioAZ.x - _radioPopular.width - 10;
			txt.x = _radioPopular.x - txt.width - 5;
		}
		
		
	}
}