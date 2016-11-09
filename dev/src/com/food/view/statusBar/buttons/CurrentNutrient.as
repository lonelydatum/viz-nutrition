package com.food.view.statusBar.buttons
{
	import com.food.contoller.events.NavEvent;
	import com.food.model.data.Config;
	import com.food.model.data.Style;
	import com.food.view.common.TextFieldFood;
	import com.food.view.header.PageBasics;
	import com.food.view.statusBar.BgHighlight;
	import com.food.view.statusBar.NutrientInfo;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.casalib.util.StageReference;
	
	public class CurrentNutrient extends NavItem
	{
		
		private var _nutrientName			:String;
		public var txt						:TextFieldFood;
		private var bg						:BgHighlight;
		
		
		public function CurrentNutrient( )
		{
			super( PageBasics.PAGE_REPORT );
			
			bg = new BgHighlight();
			bg.height += 1;
			
			this.addChildAt(bg,0);
			
			var format:TextFormat = Style.header();
			txt = new TextFieldFood();
			txt.setFormat( format );	
			txt.y = 12;
			
			
			this.addChild( txt );
			
			this.buttonMode = true;		
		}
		
		public function setLabel( value:String ):void{
			var sw:uint = StageReference.getStage().stageWidth;
			txt.width = (sw * .5) - Config.PADDING_LEFT-10;
			_nutrientName = value;
			var msg:String = "SUMMARY REPORT OF: "+_nutrientName; 
			txt.text = msg;
			
			
			if( txt.maxScrollH>0 ){
				var i:uint = msg.length;
				while( txt.maxScrollH>0 ){
					var sub:String = msg.substr(0,i);				
					txt.text = sub;
					i--;
				}				
				txt.text = msg.substr(0,i-2) + "...";
			}			
			
			position();		
		}
		
		
		public function position():void
		{			
			var sw:uint = StageReference.getStage().stageWidth;
			txt.width = (sw * .5) - Config.PADDING_LEFT-10;
			
			txt.x = Config.PADDING_LEFT;			
			bg.width = sw * .5;
			this.x = 0;
		}
		
		public override function isSelected():void{			
			bg.alpha = 1;	
			txt.textColor = 0x222222;
			this.removeEventListener( MouseEvent.CLICK, onClickHandler );			
			this.buttonMode = false;
			//bg.x = bg.width
			//TweenLite.to( bg, 1, { x:0 } );
		}
		
		public override function isNotSelected():void
		{
			bg.alpha = 0;
			txt.textColor = 0xFFFFFF;
			this.addEventListener( MouseEvent.CLICK, onClickHandler );
			this.mouseEnabled = true;
			this.buttonMode = true;
			var sw:uint = StageReference.getStage().stageWidth;
			//TweenLite.to( bg, 1, { x: bg.width } );
		}
		
		public function get nutrientName():String{
			return _nutrientName;
		}
		
	}
}