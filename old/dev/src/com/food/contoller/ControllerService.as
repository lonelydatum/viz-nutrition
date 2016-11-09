package com.food.contoller
{
	import com.food.contoller.events.ServiceEvent;
	import com.food.model.data.DataFoods;
	import com.food.model.data.DataGroups;
	import com.food.model.data.DataNutrient;
	import com.food.model.data.FoodGroups;
	import com.food.model.data.Singleton;
	import com.food.model.services.Services;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.casalib.util.ArrayUtil;

	public class ControllerService extends EventDispatcher
	{
		
		private var _services			:Services;
		
		private var _vectorNutrients	:Vector.<DataNutrient>;
		private var _vectorGroups		:Vector.<DataGroups>;		
		private var _vectorFoods		:Vector.<DataFoods>;
		
		//private var _nutritionID		:uint;
		private var _dataNutrient		:DataNutrient;
		
		public function ControllerService()
		{
			init();
		}
		
		public function init():void
		{			
			_services = new Services();		
			_services.addEventListener( ServiceEvent.QUERY_BY_NT_TOTAL, queryNutrientTotalHandler, false, 0, true );
			_services.addEventListener( ServiceEvent.QUERY_BY_GROUPS, queryGroupsHandler, false, 0, true );
			_services.addEventListener( ServiceEvent.QUERY_BY_NT_FOOD, queryByNTFoodHandler, false, 0, true );				
		}		
		
		
		/////////////////////////////////////////////
		// ServiceEvent
		/////////////////////////////////////////////
		private function queryNutrientTotalHandler( e:ServiceEvent ):void
		{					
			var serviceEvent:ServiceEvent = new ServiceEvent( ServiceEvent.QUERY_BY_NT_TOTAL );	
			_vectorNutrients = e.vectorNutrients;
			Singleton.getInstance().vectorNutrients = e.vectorNutrients;
			serviceEvent.vectorNutrients = _vectorNutrients;	
			//var rand:uint = Math.floor( Math.random() * e.vectorNutrients.length );			
			//_nutritionID = _vectorNutrients[rand].NT_ID;
			//Singleton.instance.selectedNutrient = _vectorNutrients[rand];
			dispatchEvent( serviceEvent );
		}
		
		
		private function queryGroupsHandler( e:ServiceEvent ):void
		{
			_vectorGroups = e.vectorGroups;
			Singleton.getInstance().vectorGroups = e.vectorGroups;
			_services.getAllFoodsByNutrient( Singleton.instance.selectedNutrient.NT_ID );				
		}
		
		private function queryByNTFoodHandler( e:ServiceEvent ):void{			
			_vectorFoods = e.vectorFoods;	
			Singleton.getInstance().vectorFoods = e.vectorFoods;
			var serviceEvent:ServiceEvent = new ServiceEvent( e.type );					
			serviceEvent.vectorFoods = _vectorFoods;
			serviceEvent.vectorGroups = _vectorGroups;			
			dispatchEvent( serviceEvent );
		}
		
		
		/////////////////////////////////////////////
		// PUBLIC 
		/////////////////////////////////////////////		
		public function getNutritionTotal( ):void
		{
			_services.getNutritionTotal( );		
		}
		
		public function getGroupsWithNutritionTotal( ):void	
		{	
			_services.getGroupsWithNutritionTotal( Singleton.instance.selectedNutrient.NT_ID );
		}
		
		private function getAllFoodsByNutrient( ):void	
		{			
			_services.getAllFoodsByNutrient( Singleton.instance.selectedNutrient.NT_ID );
		}
				
		//public function set nutrientID( id:uint ):void 	{ _nutritionID = id; }
		
		//public function get nutrientID( ):uint { return _nutritionID; }
		
		
		
		public function get dataNutrient( ):DataNutrient { return _dataNutrient; }
	
		public function reset():void
		{
			try{
				_services.reset();
				_services.removeEventListener( ServiceEvent.QUERY_BY_NT_FOOD, queryByNTFoodHandler );
				_services.removeEventListener( ServiceEvent.QUERY_BY_GROUPS, queryGroupsHandler );
				_services.removeEventListener( ServiceEvent.QUERY_BY_NT_TOTAL, queryNutrientTotalHandler );
			}catch( e:Error ){
				trace( "_services is now NULL: "+e.message );
			}
			_services = null;
		}
	}
}