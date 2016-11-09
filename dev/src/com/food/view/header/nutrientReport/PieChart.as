package com.food.view.header.nutrientReport
{
	import com.food.model.data.ColorFoodGroups;
	import com.food.model.data.Config;
	import com.food.model.data.DataFoods;
	import com.food.model.data.Singleton;
	import com.food.model.data.Style;
	import com.greensock.TweenLite;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.casalib.math.geom.Ellipse;
	import org.casalib.util.DrawUtil;
	
	public class PieChart extends Sprite
	{
		
		private var _mostPopular				:Vector.<DataFoods>;
		
		private var _items						:Array;
		private var _msk						:Shape;
		private var _pie						:Sprite;
		private var _nextAngle					:uint;
		
		
		public static const RADIUS 	:uint = 220;
		
		public function PieChart( mostPopular:Vector.<DataFoods> )
		{
			_mostPopular = mostPopular;
			
			_pie = new Sprite();
			
			this.addChild(_pie);
			createPieChart();	
			createLegend();
			
		
		}
		
		public function transIn():void{
			_msk = new Shape();
			
			_msk.graphics.beginFill( 0xFF0000,1 );
			
			
			this.addChild(_msk);
			_pie.mask = _msk;
			
			_nextAngle = 0;
			this.addEventListener(Event.ENTER_FRAME,tickerMask);
			
		}
		
		private function tickerMask( e:Event ):void
		{
			var yPos:uint = ( Config.HEADER_HEIGHT-RADIUS ) * .5;
			if( _nextAngle<=360 ){
				DrawUtil.drawWedge( _msk.graphics, new Ellipse(-RADIUS*.5, yPos, RADIUS,RADIUS), 0, _nextAngle );
			}else{
				this.removeEventListener(Event.ENTER_FRAME,tickerMask);
				_pie.mask = null;					
				this.removeChild(_msk);
				_msk = null;
			}
			_nextAngle += 10;
		}
		
		private function createPieChart():void
		{
			_items = new Array();
			var xPosLegend:uint = ( RADIUS * .5 ) + 30;
			var yPosLegend:uint = 40;
			var formatHeader:TextFormat = Style.header();
			var header:TextField = new TextField();
			header.embedFonts = true;
			header.y = yPosLegend;
			header.x = xPosLegend;
			header.width = 535;
			header.textColor = Config.PALLETE_DARK;
			header.autoSize = TextFieldAutoSize.LEFT;
			header.defaultTextFormat = formatHeader;
			header.text = "TOP 8 FOODS THAT CONTAINS: " + Singleton.instance.selectedNutrient.NT_NME;
			this.addChild( header );
			
			
			
			
			yPosLegend = header.y + header.height + 8;
			var lastAngle:Number = 360;
			//var maxRows:uint = Math.ceil( _mostPopular.length * .5 );
			
			
			for( var i:uint=0;i<_mostPopular.length;i++){
				var arc:Number = Math.round(_mostPopular[i].percent * 360);				
				var wedge:Wedge = new Wedge( i, _mostPopular[i] );
				wedge.addEventListener(MouseEvent.ROLL_OVER, rOver, false, 0,true );
				wedge.addEventListener(MouseEvent.ROLL_OUT, rOut, false, 0,true );
				
				var col:uint = getColorByGroupID( _mostPopular[i].FD_GRP_ID );
				
				
				
				//var col:Number = ( i<Config.COLOR_TOP.length ) ? Config.COLOR_TOP[i] : 0x000000;
				wedge.graphics.beginFill( col );
				var yPos:uint = ( Config.HEADER_HEIGHT-RADIUS ) * .5;
				DrawUtil.drawWedge( wedge.graphics, new Ellipse(-RADIUS*.5, yPos, RADIUS,RADIUS), lastAngle, arc-.5 );
				lastAngle = lastAngle-arc;				
				_pie.addChild( wedge );
				
				var legendItem:LegendItem = createLegendItem( _mostPopular[i], col  );
				legendItem.y = yPosLegend;
				legendItem.x = xPosLegend;
				
				_items[i] = { wedge:wedge, legend:legendItem }; 
				
				yPosLegend = legendItem.y + legendItem.height-5;
				this.addChild( legendItem );
			}

			
			
		}
		
		private function getColorByGroupID( id:uint ):uint
		{
			var v:Vector.<ColorFoodGroups> = Singleton.instance.colorFoodGroups;
			var matchColor:uint = 0;
			for( var i:uint=0;i<v.length;i++ ){
				
				var colorFoodGroup:ColorFoodGroups = v[i];
				
				if( colorFoodGroup.groupdID==id ){
					matchColor = colorFoodGroup.color;
					break;
				}
			}
			return matchColor;
		}
		

	
		private function rOver( e:MouseEvent ):void{
			var id:uint = Wedge(e.target).id;
			_items[id].legend.highlight();
		}
		
		private function rOut( e:MouseEvent ):void{
			var id:uint = Wedge(e.target).id;
			_items[id].legend.highlightRelease();
		}
		
		private function createLegendItem( dataFoods:DataFoods, color:Number ):LegendItem
		{
			var item:LegendItem = new LegendItem( dataFoods, color );			
			return item;				
		}
		
		private function createLegend():void{
			
			
		}
	}
}