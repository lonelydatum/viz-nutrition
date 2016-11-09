package com.food.contoller
{
	import com.food.contoller.events.HoverTipEvent;
	import com.food.contoller.events.NutritionEvent;
	import com.food.model.data.Config;
	import com.food.model.data.DataFoods;
	import com.food.model.data.DataGroups;
	import com.food.model.data.DataNutrient;
	import com.food.model.data.Singleton;
	import com.food.view.chart.ViewGroupCollection;
	import com.food.view.chart.assets.Tip;
	import com.food.view.common.BackgroundStage;
	import com.food.view.common.Instructions;
	import com.food.view.common.Preloader;
	import com.food.view.header.Header;
	import com.food.view.header.PageBasics;
	import com.food.view.statusBar.StatusBar;
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.getTimer;
	
	import org.casalib.util.StageReference;


	public class ControllerView extends EventDispatcher
	{
		
		private var _base						:Sprite;
		
		private var _statusBar					:StatusBar;
		private var _header						:Header;
		public var _vectorNutrients				:Vector.<DataNutrient>;
		public var _vectorGroups				:Vector.<DataGroups>;
		private var _groupCollection			:ViewGroupCollection;
		
		private var _tip						:Tip;		
		private var _nutritionID				:uint;
		
		private var _preloader					:Preloader;
		private var _instructions				:Instructions;
		private var _spinner					:Sprite;
		
		
		
		public function ControllerView( base:Sprite )
		{			
			_base = base;
			_preloader = new Preloader();			
			_base.addChild( _preloader );
			init();
		}
		
		private function init( ):void
		{						
			_statusBar = new StatusBar();
			_base.addChild( _statusBar );
			
			_header = new Header();
			_header.y = _statusBar.height;
			_header.addEventListener( NutritionEvent.CHANGE_NUTRIENT, nutritionChangedHandler );
			_base.addChildAt( _header, 0 );
			
			_groupCollection = new ViewGroupCollection();
			_groupCollection.y = _statusBar.height + Config.HEADER_HEIGHT + 30;
			_base.addChild( _groupCollection );
		}
		
		private function nutritionChangedHandler( e:NutritionEvent ):void
		{
			
			_spinner = new SpinnerMain();
			_spinner.width = 55;
			_spinner.height = 55;
			_base.addChild( _spinner );
			_spinner.x = _base.mouseX;
			_spinner.y = _base.mouseY;
			_spinner.filters = [ new DropShadowFilter(5,45,0x222222,.5,11,11) ];
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler)
				
			if( _instructions ) _instructions.transOut();
			dispatchEvent( new NutritionEvent( NutritionEvent.CHANGE_NUTRIENT, e.dataNutrient, false ) );			
			e.stopImmediatePropagation();
			updateStatus( );
		}
		
		private function mouseMoveHandler( e:MouseEvent ):void
		{
			e.updateAfterEvent();
			TweenLite.to( _spinner, .3, { x:_base.mouseX, y:_base.mouseY, ease:Quad.easeOut } );
		}
		
		
		public function instructions():void
		{
			_instructions = new Instructions();			
			_instructions.y = 325;
			_instructions.x = (StageReference.getStage().stageWidth - _instructions.width) / 2;
			_base.addChild( _instructions );
			_statusBar.transIn();	
			_preloader.transOut();
			_header.createNewPage( PageBasics.PAGE_FRACTAL );
		}
		
		public function updateStatus( ):void
		{											
			_statusBar.updateNutrition( );	
			destroyPreloader();
		}
			
		public function createVisualization( vectorGroups:Vector.<DataGroups>, vectorFoods:Vector.<DataFoods> ):void
		{				
			StageReference.getStage().removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler)
			if( _spinner ){
				_spinner.filters = [];
				TweenLite.to( _spinner, .3, { scaleX:0, scaleY:0, onComplete:function(){
					_base.removeChild( _spinner );
					_spinner = null;
				} } );

				
			} 
			
			updateStatus( );			
			_groupCollection.createVisualization( vectorGroups, vectorFoods, _statusBar.currentNutrient.nutrientName );
		}
		
		public function reset( ):void
		{				
			_groupCollection.reset();			
		}
		
		
		private function destroyPreloader():void
		{
			if( _preloader ){
				if( _base.contains(_preloader) ) _preloader.transOut();
			}			
			_preloader = null;
		}
		
		/////////////////////////////////////////////////////////////////////
		// GETTERS AND SETTERS
		/////////////////////////////////////////////////////////////////////
		public function get statusBar():StatusBar
		{
			return _statusBar;
		}
		
		public function get header():Header
		{
			return _header;
		}
	}
}