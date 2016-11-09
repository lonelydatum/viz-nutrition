package com.food.view.statusBar.buttons
{
	import com.food.contoller.events.NavEvent;
	import com.food.model.data.GoogleAnalytics;
	import com.food.view.header.PageBasics;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class NavItem extends Sprite
	{
		
		protected var _navType				:uint;
		
		
		public function NavItem( type:uint )
		{
			_navType = type; 
			this.addEventListener( MouseEvent.CLICK, onClickHandler, false, 0, true );
		}
		
		
		public function onClickHandler( e:MouseEvent ):void{	
			if( _navType==2 ) GoogleAnalytics.track( "/Nav/Report" );
			dispatchSelectedItem();
		}
		
		public function dispatchSelectedItem():void{
			dispatchEvent( new NavEvent( NavEvent.NAV_SELECTED, navType ) );
		}
		
		public function get navType():uint{
			return _navType;
		}
		
		public function isSelected():void{			
			super.getChildByName("bg").alpha = 1;			
		}
		
		public function isNotSelected():void
		{
			super.getChildByName("bg").alpha = 0;			
		}
	}
}