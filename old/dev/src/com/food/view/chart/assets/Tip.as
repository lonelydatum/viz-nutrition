package com.food.view.chart.assets
{
	import com.food.model.data.Config;
	import com.food.model.data.Singleton;
	import com.food.model.data.Style;
	import com.food.view.common.TextFieldFood;
	
	import flash.display.Graphics;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.casalib.util.NumberUtil;
	import org.casalib.util.StageReference;
	import org.casalib.util.StringUtil;
	
	public class Tip extends Sprite
	{
		
		private var _foodName			:Sprite;
		private var _nutrientAmount		:Sprite;
		private var _nutrientName		:Sprite;
		
		private var _driAmount			:uint;
		private var _amount				:uint;
		private var unit				:String;
		
		
		private static const H				:uint = 20;
		private static const TXT_PADDING	:uint = 2;
		
		public function Tip()
		{		
			hide();
		}
		
		
		public function show( foodName:String, amount:Number, selectedNutrient:String, rect:Rectangle ):void{
			
			_amount = amount;
			_foodName = createLabel( foodName );			
			unit = Singleton.getInstance().selectedNutrient.UNIT;
			_nutrientAmount = createLabel( " has "+NumberUtil.roundDecimalToPlace(amount,1)+unit+" of " );
			_nutrientName = createLabel( StringUtil.toTitleCase(selectedNutrient,false) + " per 100 grams" );
			
			_nutrientAmount.x = _foodName.x + _foodName.width + 1;
			_nutrientName.x = _nutrientAmount.x + _nutrientAmount.width + 1;
			
			this.addChild( _foodName );
			this.addChild( _nutrientAmount );
			this.addChild( _nutrientName );
			
			if( rect.x > StageReference.getStage().stageWidth*.5  ){				
				var offset:Number = this.width;
				this.x = rect.x + rect.width - this.width;
			}else{
				this.x = rect.x;
			}
			
		
			this.y = rect.y-this.height-3;			
			this.visible = true;
			_driAmount = Singleton.instance.selectedNutrient.DRI;
			if( _driAmount > 0 ) showDRI();
		}
		
		private function showDRI():void
		{
			var widthAmount:uint = ( _amount/_driAmount ) * width;
			var recoWidth:uint;
			var realWidth:uint;
			
			if( widthAmount < width ){
				recoWidth = width;
				realWidth = widthAmount;
			}else{
				recoWidth = ( _driAmount/_amount ) * width;
				realWidth = width;
			}
			
			
			var recoHeight:uint = 6;
			
			var colorLong:Number = 0x21b4c1;
			var colorShort:Number = 0x66CCFF;
			var format:TextFormat = Style.body();
			
			var driHolder:Sprite = new Sprite();
			driHolder.graphics.beginFill(colorLong,1);
			driHolder.graphics.drawRect(0,0,recoWidth, recoHeight );
			driHolder.y = -recoHeight;
			this.addChild(driHolder);
			
			
			var txt:TextFieldFood = new TextFieldFood();
			txt.defaultTextFormat = format;
					
			txt.text = "recomended "+_driAmount + unit;
			txt.textColor = colorLong;
			txt.x = ( recoWidth >= realWidth ) ? width - txt.width : 0;
			txt.y = -recoHeight - txt.height+6;			
			this.addChild( txt );
			
			
			
			
			var foodHolder:Sprite = new Sprite();
			foodHolder.graphics.beginFill(colorShort,1);
			foodHolder.graphics.drawRect(0,0,realWidth, recoHeight);
			foodHolder.y = -recoHeight;
			this.addChild(foodHolder);
			
			
			
			var txtAmount:TextFieldFood = new TextFieldFood();
			txtAmount.defaultTextFormat = format;
						
			txtAmount.text = _amount+unit;
			txtAmount.textColor = colorShort;
			txtAmount.x = ( recoWidth < realWidth ) ? width - txtAmount.width : 0;
			txtAmount.y = -recoHeight - txtAmount.height+6;			
			this.addChild( txtAmount );
			
			if( recoWidth < realWidth ){
				this.setChildIndex(foodHolder,0);
			}
			
		}
		
		public function hide():void
		{
			this.visible = false;
			reset();	
		}
		
	
		private function createLabel( label:String ):Sprite
		{
			var format:TextFormat = new TextFormat();
			var font:Font = new Config.FONT_BODY();
			
			format.size = 11;
			format.font = font.fontName;
			
			var txt:TextField = new TextField();
			txt.embedFonts = true;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.x = TXT_PADDING;
			txt.y = TXT_PADDING; 
			txt.defaultTextFormat = format;
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.text = label;
			
			txt.textColor = 0xFFFFFF;
			
			var holder:Sprite = new Sprite();
						
			createBG( holder.graphics, 0x000000, txt.width+(TXT_PADDING*2) );			
			holder.addChild( txt );			
			return holder;			
		}
		
				
		private function createBG( g:Graphics, col:Number, w:Number ):void
		{
			g.beginFill( col );
			g.drawRect( 0, 0, w, 20 );
			g.endFill();
		}
		
		public function transIn():void{ }
		
		public function reset():void
		{
			while( this.numChildren > 0 ){
				this.removeChildAt( 0 );
			}
		}
	}
}