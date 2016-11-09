package com.food.view.header.nutrientReport
{
	import com.food.model.data.Config;
	import com.food.model.data.DataFoods;
	import com.food.model.data.DataGroups;
	import com.food.model.data.Singleton;
	import com.food.model.data.Style;
	import com.food.view.header.PageBasics;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.casalib.math.geom.Ellipse;
	import org.casalib.util.DrawUtil;
	import org.casalib.util.StageReference;
	
	public class PageNutrientReport extends PageBasics
	{
		
		private var _pieChart			:PieChart;
		
		public function PageNutrientReport( )
		{
			super( PAGE_REPORT );
			
			colorBG = Config.PALLETE_LIGHT;
			
			this.addEventListener(Event.ADDED_TO_STAGE, added,false,0,true);
		}
		
		private function added( e:Event ):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, added);
			this.stage.addEventListener(Event.RESIZE,position,false,0,true);
		}
		
		public override function init():void{
			createBG();
			createNutrientInfo();
			drawPieChart( getTopFoods() );
		}
		
		private function getTopGroups():Array
		{		
			var vGroups:Vector.<DataGroups> = Singleton.instance.vectorGroups;
			
			var sum:uint = 0;
			for( var i:uint=0;i<vGroups.length;i++){	
				sum += vGroups[i].sumOfNutrition;				
			}
			
			var mostPopular:Array = new Array();
			var sumPercent:Number = 0;
			for( var j:uint=0;j<Config.COLOR_TOP.length;j++ ){
				var percent:Number = vGroups[j].sumOfNutrition / sum;
				sumPercent += percent;
				var label:String = vGroups[j].FD_GRP_NME;						
				mostPopular.push( { percent:percent, label:label } );
			}
			
			mostPopular.push( { percent:(1-sumPercent), label:"Others" } );
			return mostPopular;
		}
		
		private function getTopFoods():Vector.<DataFoods>
		{
			var vFoods:Vector.<DataFoods> = Singleton.instance.vectorFoods;
			var vMostMPopular:Vector.<DataFoods> = new Vector.<DataFoods>;
			var sum:uint = 0;
			for( var i:uint=0;i<8;i++){	
				sum += vFoods[i].NT_VALUE;				
			}
			
			var mostPopular:Array = new Array();
			var sumPercent:Number = 0;
			for( var j:uint=0;j<8;j++ ){
				var percent:Number = vFoods[j].NT_VALUE / sum;
				sumPercent += percent;
				var label:String = vFoods[j].A_FD_NME;	
				vFoods[j].percent = percent;
				vMostMPopular.push( vFoods[j] );
				//mostPopular.push( { percent:percent, label:label, groupID:vFoods[j].FD_GRP_ID } );
			}
			
			
			return vMostMPopular;
		}
		
		private function createNutrientInfo():void
		{
			var formatHeader:TextFormat = Style.header();
			var header:TextField = new TextField();
			header.embedFonts = true;
			header.y = 40;
			header.x = Config.PADDING_LEFT;
			
			
			
			
			
			header.width = allowableSpace;
			header.textColor = Config.PALLETE_DARK;
			header.autoSize = TextFieldAutoSize.LEFT;
			header.defaultTextFormat = formatHeader;
			header.text = Singleton.instance.selectedNutrient.NT_NME;
			header.alpha = 0;
			TweenLite.to( header, .5, { alpha:1 } );
			this.addChild( header );
			
			var formatBody:TextFormat = Style.body();
			var body:TextField = new TextField();
			body.embedFonts = true;
			body.y = header.y + header.height + 10;
			
			var halfWidth:uint = StageReference.getStage().stageWidth * .5;
			var allowableSpace:uint = halfWidth - Config.PADDING_LEFT - PieChart.RADIUS - Config.PADDING_LEFT;
			
			
			
			body.height = Config.HEADER_HEIGHT - body.y - (Config.PADDING_LEFT*.5);
			body.width = 535;
			body.textColor = Config.PALLETE_DARK;
			body.x = Config.PADDING_LEFT;
			//body.autoSize = TextFieldAutoSize.LEFT;
			body.multiline = true;
			body.wordWrap = true;
			body.defaultTextFormat = formatBody;
			var bodyMessage:String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consequat tempus risus nec lacinia. Integer vestibulum quam a justo bibendum elementum. Nam adipiscing auctor imperdiet. Aenean bibendum, dui ut euismod cursus, eros risus adipiscing lectus, sit amet euismod leo tellus in urna. Duis sit amet felis et mi facilisis accumsan non ac felis. Proin at ante lorem, quis adipiscing ante. In sodales lobortis elit vitae scelerisque."; 
			bodyMessage += "\n\n " + Singleton.instance.selectedNutrient.DRI;
			var description:String = Singleton.instance.selectedNutrient.description;
			body.text = ( description.length<2 ) ? "Sorry but there is no description for this nutrient ("+Singleton.instance.selectedNutrient.NT_NME+")" : Singleton.instance.selectedNutrient.description;
			body.alpha = 0;
			TweenLite.to( body, .5, { alpha:1, delay:.5 } );
			this.addChild( body );
						
		}
		
		public override function destroy( ):void{			
			while( this.numChildren > 0 ){
				this.removeChildAt( 0 );
			}
			//TweenLite.killDelayedCallsTo( header );
			//TweenLite.killDelayedCallsTo( body );
			this.parent.removeChild( this );
		}
		
		private function drawPieChart( mostPopular:Vector.<DataFoods> ):void
		{							
			_pieChart = new PieChart( mostPopular );			
			this.addChild( _pieChart );
			
			_pieChart.transIn();
			position();
		}
		
		private function position( e:Event=null ):void
		{
			_pieChart.x = StageReference.getStage().stageWidth * .5;
		}
		
		
	}
}