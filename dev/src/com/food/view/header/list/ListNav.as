package com.food.view.header.list
{
	import com.food.contoller.events.NavLetterEvent;
	import com.food.model.data.Config;
	import com.food.model.data.DataNutrient;
	import com.food.model.data.GoogleAnalytics;
	import com.food.model.data.Singleton;
	import com.food.model.data.Style;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ListNav extends Sprite
	{
		private var _letters		:Array;
		private var _prevButton		:Sprite
		private var _nextButton		:Sprite
		
		
		public function ListNav()
		{
			init();
		}
		
		private function init():void{
			var arr:Array = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ];
			
			
			var w:uint = 16;
			var h:uint = 13;
			
			var xPos:uint = w+8;
			var gap:uint = 5;
			
			
			
			for( var i:uint=0;i<arr.length;i++){
				var button:Sprite = createButton( arr[i] );
				button.x = xPos;
				xPos = button.x + button.width + gap;
				this.addChild( button );
			}		
			
			drawTriangles( w, h );
			
			
		}
		
		private function drawTriangles( w:uint, h:uint ):void
		{			
			
			_prevButton = new Sprite();
			_prevButton.graphics.beginFill(0x888888);
			_prevButton.graphics.moveTo(0,h/2);
			_prevButton.graphics.lineTo(0,h/2);
			_prevButton.graphics.lineTo(w,0);
			_prevButton.graphics.lineTo(w,h);
			_prevButton.graphics.endFill();
			
			_prevButton.x = 0;
			_prevButton.y = 3;
			
			_nextButton = new Sprite();
			_nextButton.graphics.beginFill(0x888888);
			_nextButton.graphics.moveTo(0,0);
			_nextButton.graphics.lineTo(0,0);
			_nextButton.graphics.lineTo(w,h/2);
			_nextButton.graphics.lineTo(0,h);
			_nextButton.graphics.endFill();
			_nextButton.x = width + w + 20;
			_nextButton.y = 3;
			
			_prevButton.buttonMode = true;
			_nextButton.buttonMode = true;
			
			_prevButton.addEventListener(MouseEvent.CLICK, function():void{
				GoogleAnalytics.track( "NutrientSelection/AZ/Nav/Previous" );
				dispatchEvent( new NavLetterEvent( NavLetterEvent.PREV ) );
			} );

			_nextButton.addEventListener(MouseEvent.CLICK, function():void{
				GoogleAnalytics.track( "NutrientSelection/AZ/Nav/Next" );
				dispatchEvent( new NavLetterEvent( NavLetterEvent.NEXT ) );
			} );
			
			this.addChild( _prevButton );
			this.addChild( _nextButton );
		}
		
		private function createButton( letter:String ):Sprite{
			var button:Sprite = new Sprite();
			if( checkIfLetterIsValid(letter) ){
				button.buttonMode = true;
				button.addEventListener( MouseEvent.ROLL_OVER, rOver, false, 0, true );
				button.addEventListener( MouseEvent.ROLL_OUT, rOut, false, 0, true );
				button.addEventListener( MouseEvent.CLICK, clicked, false, 0, true );
			}else{
				button.alpha = .3;
			}
			
			
			var format:TextFormat = Style.header();
			format.size = 13;
			
			var txt:TextField = new TextField();
			txt.defaultTextFormat = format;
			txt.embedFonts = true;
			txt.mouseEnabled = false;
			txt.name = "char";
			txt.selectable = false;			
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.text = letter;
			button.addChild( txt );
			return button;
		}
		
		private function checkIfLetterIsValid( letter:String ):Boolean{
			var vectorNutrients:Vector.<DataNutrient> = Singleton.instance.vectorNutrients;
			var isPresent:Boolean = false;
			for( var i:uint=0;i<vectorNutrients.length;i++ ){
				if( vectorNutrients[i].NT_NME.charAt(0)==letter){
					isPresent=true;
					break;
				}
			}
			return isPresent;
		}
		
		private function clicked( e:MouseEvent ):void{
			var targ:Sprite = e.currentTarget as Sprite;
			var letter:String = ( targ.getChildByName("char") as TextField ).text;
			GoogleAnalytics.track( "NutrientSelection/AZ/Nav/Letter/"+letter );
			dispatchEvent( new NavLetterEvent( NavLetterEvent.LETTER_SELECTED, letter ) );
		}
		
		private function rOut( e:MouseEvent ):void{
			var targ:Sprite = e.target as Sprite;
			targ.graphics.clear();
		}
		
		private function rOver( e:MouseEvent ):void{
			var targ:Sprite = e.target as Sprite;
			targ.graphics.clear();
			targ.graphics.beginFill( Config.PALLETE_HIGHLIGHT );
			targ.graphics.drawRect(0,0,targ.width, targ.height);			
		}
	}
}