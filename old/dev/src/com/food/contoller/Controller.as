package com.food.contoller
{
	import com.adobe.serialization.json.JSON;
	import com.food.contoller.events.NutritionEvent;
	import com.food.contoller.events.ServiceEvent;
	import com.food.model.data.DataNutrient;
	import com.food.model.data.Singleton;
	import com.food.model.services.Services;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class Controller
	{
		
		private var _controllerService			:ControllerService;
		private var _controllerView				:ControllerView;
		private var _controllerNav				:ControllerNav;
		
		private var _loaderInc					:uint = 0;
		
		public function Controller( base:Sprite  )
		{
			_controllerView = new ControllerView( base );
			_controllerView.addEventListener( NutritionEvent.CHANGE_NUTRIENT, changeNutrientHandler, false, 0, true );
			
			_controllerService = new ControllerService( );						
			_controllerService.addEventListener( ServiceEvent.QUERY_BY_NT_TOTAL, queryByNutritionTotalHandler, false, 0, true );
			_controllerService.addEventListener( ServiceEvent.QUERY_BY_NT_FOOD, queryByFoodGroupHandler, false, 0, true );
			_controllerService.getNutritionTotal(  );
			
			_controllerNav = new ControllerNav();			
			_controllerNav.addNavItems( _controllerView.statusBar.currentNutrient );
			_controllerNav.addNavItems( _controllerView.statusBar.toggleView );
			_controllerNav.header = _controllerView.header;
		}
		
		private function queryByNutritionTotalHandler( e:ServiceEvent ):void
		{								
			
			_controllerView.instructions();
			//_controllerService.getGroupsWithNutritionTotal(  );	
		}
		
		private function queryByFoodGroupHandler( e:ServiceEvent ):void
		{				
			//_controllerView._vectorNutrients = e.vectorNutrients;
			_controllerView._vectorNutrients = Singleton.instance.vectorNutrients;
			_controllerView.updateStatus( );			
			_controllerNav.updateStatusHighlight(2);
			_controllerView.createVisualization( e.vectorGroups, e.vectorFoods );
			createNavController();					
		}
		
		private function createNavController():void{			
			_controllerNav.createNewPage( 2 );
		}
		
		private function changeNutrientHandler( e:NutritionEvent ):void
		{
			_controllerNav.updateStatusHighlight(2);
			Singleton.instance.selectedNutrient = e.dataNutrient;
			//_controllerNav.loadPageById( 0 );
			_controllerView.reset( );
			_controllerService.reset();
			_controllerService.init();
			_controllerService.getGroupsWithNutritionTotal( );
		}		
	}
}