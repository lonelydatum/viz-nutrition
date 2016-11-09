package com.food.view.header.list
{
	import com.food.contoller.events.NavLetterEvent;
	import com.food.contoller.events.NutritionEvent;
	import com.food.model.data.Config;
	import com.food.model.data.DataNutrient;
	import com.food.model.data.Singleton;
	import com.food.view.header.PageBasics;
	import com.greensock.TweenLite;
	
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import org.casalib.util.StageReference;
	
	public class PageList extends PageBasics
	{
		
		private var _allNutrientsData			:Vector.<DataNutrient>;
		private var _listHolder					:Sprite;
		
		private var _maxRows					:uint = 10;
		private var _maxCols					:uint = 0;
		private var _msk						:Shape;
		private var _nav						:ListNav;
		private var _colInc						:uint = 0;
		private var _colIndex					:Number = 0;
		
		
		private static const PADDING_VERT		:uint = 25;
		private static const PADDING_SIDE		:uint = 30;
		
		
		
		
		public function PageList( )
		{
			super( PageBasics.PAGE_LIST );			
			colorBG = Config.PALLETE_LIGHT;
			
			_nav = new ListNav();
			_nav.addEventListener(NavLetterEvent.LETTER_SELECTED, onLetterSelectedHandler, false, 0, true );
			_nav.addEventListener(NavLetterEvent.PREV, function(){
				if( _colIndex>0 ) moveToColumn( _colIndex-1 );
				
			});
			_nav.addEventListener(NavLetterEvent.NEXT, function(){
				if( _colIndex<_colInc ) moveToColumn( _colIndex+1 );
			})
			_nav.y = Config.HEADER_HEIGHT - 25;
			_nav.x = (StageReference.getStage().stageWidth * .5) - ( _nav.width * .5 );
			this.addChild( _nav );
		}
		
		public override function init():void
		{
			_allNutrientsData = Singleton.instance.vectorNutrients;			
			createBG();
			createHolder();
			createMask();			
			createList();				
		} 
		
		private function createHolder():void
		{
			_listHolder = new Sprite();
			_listHolder.x = PADDING_SIDE;
			_listHolder.y = PADDING_VERT;
			this.addChild( _listHolder );
		}
		
		private function createList():void
		{
			var yPos:uint = 0;
			var xPos:uint = 0;
			
			for( var i:uint=0;i<_allNutrientsData.length;i++){
				var tf:ListTextField = new ListTextField( _allNutrientsData[i] );
				tf.addEventListener( NutritionEvent.CHANGE_NUTRIENT, onChangeNutrientHandler,false, 0, true );
				tf.y = yPos;
				tf.x = xPos;
				
				_listHolder.addChild( tf );
								
				if( i!=0 && i%_maxRows==(_maxRows-1) ){
					yPos = 0;
					xPos += 400;	
					_colInc++;
				}else{
					yPos = tf.y + tf.height + 2;
				}
			}
			
		}
		
		private function onChangeNutrientHandler( e:NutritionEvent ):void
		{
			for( var i:uint=0;i<_allNutrientsData.length;i++){
				var tf:ListTextField = new ListTextField( _allNutrientsData[i] );				
				tf.removeEventListener( NutritionEvent.CHANGE_NUTRIENT, onChangeNutrientHandler );
			}
			
			for( var j:uint=0;j<this.numChildren;j++ ){				
				TweenLite.to( this.getChildAt(j), Math.random(), {alpha:0, delay:Math.random()} );
			}
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		private function createMask():void
		{
			_msk = new Shape();
			drawViewableArea();
			this.addChild( _msk );
			_listHolder.mask = _msk;	
		}
		
		private function drawViewableArea():void
		{
			var viewableAre:uint = StageReference.getStage().stageWidth-( PADDING_SIDE*2 );			
			_msk.graphics.clear();
			_msk.graphics.beginFill( 0xFF0000, .5 );
			_msk.graphics.drawRect( PADDING_SIDE, PADDING_VERT, viewableAre, Config.HEADER_HEIGHT );
		}
		
		private function onLetterSelectedHandler( e:NavLetterEvent ):void{
			
			var xPos:uint;
			for( var i:uint=0;i<_listHolder.numChildren;i++ ){
				var item:ListTextField = _listHolder.getChildAt(i) as ListTextField;
				if( item.firstCharacterIs() == e.letter ){
					xPos = item.x;
					break;
				}				
			}
					
			moveToColumn( xPos/400 );
		}
		
		private function moveToColumn( moveToColIndex:uint ):void
		{
			var xPos:Number = ( moveToColIndex - _colIndex ) * 400;
			TweenLite.to( _listHolder, .5, { x:-(moveToColIndex*400)+PADDING_SIDE } );
			_colIndex = moveToColIndex;
		}
		
		private function createColumn():void
		{
			
		}
	}
}