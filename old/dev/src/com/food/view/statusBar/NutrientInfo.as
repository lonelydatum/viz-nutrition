package com.food.view.statusBar
{
	import com.food.model.data.Config;
	import com.food.view.common.CloseButton;
	import com.greensock.*;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class NutrientInfo extends Sprite
	{
		
		private var _bgSquare				:Shape;
		private var _bgRight				:Shape;
		private var _bgLeft					:Shape;
		private var _w						:uint;
		private var _msg					:String;
		private var _close					:CloseButton;
		
		private var _txt					:TextField;
		private var _padding				:uint = 20;
		
		public static const ON_CLOSE		:String = "onClose";			
		
		public function NutrientInfo( msg:String, w:uint=450 )
		{
			_msg = msg;
			
			_w = w + ( _padding*2 );
			this.addEventListener( Event.ADDED_TO_STAGE, added, false, 0, true );
			
		}
		
		public function init():void{
			_bgSquare = new Shape();
			_bgSquare.graphics.beginFill( 0x23231f );
			_bgSquare.graphics.drawRect( 0, 0 , _w, 150 );
			_bgSquare.graphics.endFill();
			_bgSquare.x = -( _w * .5 );
			this.addChild( _bgSquare );
			
			
			var font:Font = new Config.FONT_MEDIUM();
			var format:TextFormat = new TextFormat();
			format.size = 15;			
			format.font = font.fontName;
						
			_txt = new TextField();			
			_txt.defaultTextFormat = format;
			_txt.embedFonts = true;
			_txt.wordWrap = true;
			_txt.textColor = 0xFFFFFF;
			_txt.multiline = true;
			_txt.width = _w - _padding;
			_txt.y = 8;
			_txt.x = ( -_w*.5 ) + ( _padding )
			_txt.text = _msg;
			this.addChild( _txt );
			
			_close = new CloseButton();
			_close.addEventListener( MouseEvent.CLICK, onClickHandler, false, 0, true );
			_close.x = -(_close.width * .5);
			_close.y = _txt.height + _txt.y + 10;
			this.addChild( _close );
			
			transIn();
		}
		
		private function added( e:Event ):void
		{
			this.removeEventListener( Event.ADDED_TO_STAGE, added );
			this.stage.addEventListener( Event.RESIZE, onResizedHandler, false, 0, true );
			position();
		}
		
		private function onResizedHandler( e:Event ):void{
			position();
		}
		
		private function position():void{
			this.x = stage.stageWidth * .5;			
		}
		
		private function onClickHandler( e:MouseEvent ):void
		{
			_close.removeEventListener( MouseEvent.CLICK, onClickHandler );
			transOut();
		}
		
		private function transIn():void
		{
			TweenLite.from( this, .6, { y:-this.height, ease:Quad.easeOut } )
		}
		
		private function transOut():void{
			TweenLite.to( this, .3, { y:-this.height, ease:Quad.easeIn, onComplete:function(){
				dispatchEvent( new Event( ON_CLOSE ) );
			} } )
		}
		
		public function destroy( ):void{
			while( this.numChildren > 0 ){
				this.removeChildAt( 0 );
			}
		}
	}
}