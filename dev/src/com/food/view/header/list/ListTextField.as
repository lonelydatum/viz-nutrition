package com.food.view.header.list
{
	import com.food.contoller.events.NutritionEvent;
	import com.food.model.data.Config;
	import com.food.model.data.DataNutrient;
	import com.food.model.data.GoogleAnalytics;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ListTextField extends Sprite
	{
		
		private var _tf					:TextField;
		private var _nutrientName		:String;
		
		private var _dataNutrient		:DataNutrient;
		
		
		public function ListTextField( dataNutrient:DataNutrient )
		{
			
			_dataNutrient = dataNutrient;
			
			_tf = new TextField();
			_tf.width = 350;
			_tf.multiline = false;
			_tf.embedFonts = true;
			_tf.autoSize = TextFieldAutoSize.LEFT;
			var format:TextFormat = new TextFormat();
			
			var font:Font = new Config.FONT_MEDIUM();
			format.font = font.fontName;
			format.size = 12;
			
			_tf.mouseEnabled = false;
			_tf.defaultTextFormat = format;
			_tf.textColor = Config.PALLETE_DARK;
			
			_tf.text = _dataNutrient.NT_NME.substr(0,60);
			this.addChild( _tf );
			
			this.buttonMode = true;
			this.addEventListener( MouseEvent.CLICK, onClicked );
			this.addEventListener( MouseEvent.ROLL_OVER, rOver );
			this.addEventListener( MouseEvent.ROLL_OUT, rOut );
		}
		
		private function onClicked( e:MouseEvent ):void
		{
			GoogleAnalytics.track( "NutrientSelection/AZ/"+_dataNutrient.NT_NME );
			dispatchEvent( new NutritionEvent( NutritionEvent.CHANGE_NUTRIENT, _dataNutrient, true ) );
		}
		
		private function rOver( e:MouseEvent ):void{
			var snd:Sound = new SoundRollOver();
			snd.play();
			this.graphics.beginFill(Config.PALLETE_HIGHLIGHT);
			this.graphics.drawRect(0, 0, width, height);
			this.graphics.endFill();
		}
		
		private function rOut( e:MouseEvent ):void{
			this.graphics.clear();
		}
		
		public function firstCharacterIs():String{
			return _tf.text.charAt(0);
		}
		
	}
}