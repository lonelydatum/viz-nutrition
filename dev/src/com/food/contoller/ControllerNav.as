package com.food.contoller
{
	import com.food.contoller.events.NavEvent;
	import com.food.contoller.events.NutritionEvent;
	import com.food.view.header.Header;
	import com.food.view.statusBar.buttons.NavItem;

	public class ControllerNav
	{
		
		private var navItems				:Array;
		public var header					:Header;
		
		
		public function ControllerNav()
		{
			navItems = new Array();
		}
		
		public function addNavItems( item:NavItem ):void
		{
			item.addEventListener( NavEvent.NAV_SELECTED, onNavSelectedHandler, false, 0, true );
			navItems.push( item );
		}
		
		private function onNavSelectedHandler( e:NavEvent ):void{
			
			
			createNewPage( e.navType );
			updateStatusHighlight( e.navType );
			
		}
		
		public function updateStatusHighlight( id:uint ):void
		{
			
			var isSelected:NavItem;
			var isNOTSelected:NavItem;

			
			
			switch( id ){
				case 0:
					isSelected = navItems[1];
					isNOTSelected = navItems[0]; 
					break;
				
				case 1:
					isSelected = navItems[1];
					isNOTSelected = navItems[0]; 
					break;
				
				case 2:
					isSelected = navItems[0];
					isNOTSelected = navItems[1]; 
					break;
			}
			
			isSelected.isSelected();
			isNOTSelected.isNotSelected();
		}
					
		public function loadPageById( id:uint ):void
		{						
			//NavItem( navItems[ id ] ).dispatchSelectedItem();
		}
		
		public function createNewPage( id:uint ):void
		{
			//trace( "onNavSelectedHandleronNavSelectedHandleronNavSelectedHandleronNavSelectedHandleronNavSelectedHandler = "+id );
			header.createNewPage( id );
		}
		
		public function start():void{
			
			//NavItem(navItems[0]).dispatchSelectedItem();
		}
	}
}