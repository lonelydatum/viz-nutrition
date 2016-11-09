package com.food.view.chart
{
	import com.food.model.data.Config;
	import com.food.model.data.DataFoods;
	import com.food.model.data.DataGroups;
	import com.food.model.data.Singleton;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.casalib.util.StageReference;
	

	public class ViewGroup extends Sprite
	{
		
		private var _foods			:Vector.<ViewFood>;
		private var _groupColor		:Number;
		public var ratio			:Number;
		
		//private var _groupName		:String;
		private var xPos			:Number=180;
		private var yPos			:Number = 0;
		private var _rec			:Rectangle;
		private var _bg				:Shape;
		private var _foodHolder		:Sprite;
		
		
		private var _groupLabel		:ViewGroupLabel;
		private var _xInc			:uint = 0;
		private var _dataGroups		:DataGroups;
		
		public static const LABEL_WIDTH	:uint = 180;
		public static const Y_GAP	:uint = 1;
		public static const X_GAP	:uint = 1;
		
		public var _totalNT			:Number;
		private var _msk			:Shape;
		
		
		
		public function ViewGroup( dataGroups:DataGroups )
		{			
			_dataGroups= dataGroups;
			this.addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true );
			
			_foodHolder = new Sprite();
			
			this.addChild(_foodHolder);
				
			this.addEventListener( MouseEvent.ROLL_OVER, function(){
				TweenMax.to( _bg, .5, { tint:Config.PALLETE_LIGHT } );
			} )
				
			this.addEventListener( MouseEvent.ROLL_OUT, function(){
				TweenMax.to( _bg, .5, { removeTint:true } );
			} )
				
			setRect();			
			
		
		}
		
		
		
		private function added( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, added );
			stage.addEventListener( Event.RESIZE, resizeHandler, false, 0, true );
			//trace( "this.parent.getChildIndex(this) = "+Singleton.getInstance().vectorGroups.length, width, height, numChildren);
			
			_msk = new Shape();
			this.addChild(_msk);
			
			_msk.graphics.beginFill(0xFF00FF,.3);
			_msk.graphics.drawRect(0,0,width,height);
			_msk.graphics.endFill();
			_msk.x = -width;
			
			this.mask = _msk;
			var time:uint = 3;
			var childIndex:uint = this.parent.getChildIndex(this);
			var percent:Number = childIndex/Singleton.getInstance().vectorGroups.length;			
			TweenLite.to( _msk, 1.2, { x:0, delay:3+(time*(percent)), ease:Circ.easeOut } );
				
		}
		
		private function resizeHandler( e:Event ):void
		{			
			setRect();
			xPos = _rec.x;
			yPos = 0;
			_groupLabel.x = 10;
			for( var i:uint=0;i<_foods.length;i++){
				position( _foods[i] );
			}						
		}
		
		//////////////////////////////////////////////////////////
		// Creates all the foods
		//////////////////////////////////////////////////////////
		public function start( vectorFoods:Vector.<DataFoods> ):void
		{
			createBG();	
			createChart( vectorFoods );					
			createLabel();
			
			
		}
		
		//////////////////////////////////////////////////////////
		// Creator
		//////////////////////////////////////////////////////////
		private function createBG():void
		{			
			_bg = new Shape();								
			if( !this.contains(_bg) ) this.addChildAt( _bg, 0 );
		}
			
		private function createChart( vectorFoods:Vector.<DataFoods> ):void
		{
			_foods = new Vector.<ViewFood>( vectorFoods.length,true );
			_totalNT = 0;
			
			for( var i:uint=0;i<vectorFoods.length;i++){		
				var food:ViewFood = new ViewFood( );
				_foods[i] = food;
				food.cacheAsBitmap = true;
				food.id = vectorFoods[i].FD_ID;
				food.foodName = vectorFoods[i].A_FD_NME;
				food.color = _groupColor;
				
				food.ntAmount = vectorFoods[i].NT_VALUE;
				food.ratio = ratio;
				_totalNT += food.ntAmount;
				
				_foodHolder.addChild( food );
				position( food );	
				food.render();
			}
			
			_totalNT = Math.round( _totalNT );	
		}
		
		private function createLabel(  ):void
		{
			_groupLabel = new ViewGroupLabel( _dataGroups );
			//_groupLabel.x = 10;
			_groupLabel.y = (this.height - _groupLabel.height) * .5;			
			this.addChild( _groupLabel );
		}
		
		
		
		//////////////////////////////////////////////////////////
		// Allows for stage resizing
		//////////////////////////////////////////////////////////
		public function setRect( ):void{
			var sw:uint = StageReference.getStage( ).stageWidth;
			_rec = new Rectangle( LABEL_WIDTH, 0, sw-20, 300 );
			xPos = _rec.x;
		}
		
		//////////////////////////////////////////////////////////
		// positions a single food item
		//////////////////////////////////////////////////////////		
		private function position( food:ViewFood ):void
		{	
			food.x = xPos;
			food.y = yPos;
			food.xInc = _xInc;
			
			var spaceRemainingForNextItem:Number = _rec.width - ( xPos + food.w );
			if( spaceRemainingForNextItem > food.w ){
				xPos = food.x + food.w + X_GAP;				
				_xInc++;	
			}else{				
				yPos += food.h + Y_GAP; 				
				xPos = _rec.x;
				_xInc = 0;				
			}
			
			_bg.graphics.clear();
			var h:uint = Math.max( this.height, 110 );
			_bg.graphics.beginFill( 0xf5f5f5 );
			_bg.graphics.drawRect( 0,0,_rec.width, h );
			_bg.graphics.endFill();		
			
			_foodHolder.y = ( this.height - _foodHolder.height ) * .5;
		}
		
		public function get foods():Vector.<ViewFood>{
			return _foods;
		}
		
		public function get totalNT():Number{
			return _totalNT;
		}
		
		public function set groupColor( value:Number ):void{ _groupColor = value; }
		public function get groupColor( ):Number{ return _groupColor; }
		
		public function reset():void
		{
			
			for( var i:uint=0;i<_foods.length;i++){
				_foods[i].reset();
				_foodHolder.removeChild( _foods[i] );
				_foods[i] = null;
			}			
			_foods = null;
		}
	}
}