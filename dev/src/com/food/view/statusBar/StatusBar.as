package com.food.view.statusBar
{
	import com.food.contoller.events.NavEvent;
	import com.food.model.data.Config;
	import com.food.model.data.Singleton;
	import com.food.view.statusBar.buttons.CurrentNutrient;
	import com.food.view.statusBar.buttons.NavItem;
	import com.food.view.statusBar.buttons.ToggleNutrientView;
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.greensock.easing.EaseLookup;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class StatusBar extends Sprite
	{
		
		
		public var currentNutrient		:CurrentNutrient;
		public var toggleView			:ToggleNutrientView;		
		
		private var _info				:NutrientInfo;
		public var bg					:Sprite;
		
		
		public function StatusBar()
		{			
			this.y = -this.height;
			this.addEventListener( Event.ADDED_TO_STAGE, added, false, 0, false );	
			this.filters = [ new DropShadowFilter( 5, 90, 0x111111, .3, 11, 11 ) ];
		}
		
		private function added( e:Event ):void
		{
			this.removeEventListener( Event.ADDED_TO_STAGE, added );
			postition();
			stage.addEventListener(Event.RESIZE, function():void{
				postition();
			})
		}
								
		private function postition():void
		{			
			bg.width = stage.stageWidth;
			currentNutrient.position();
			toggleView.position();
		}
		
		public function updateNutrition( ):void
		{	
			TweenLite.to( this, 2, { y:0, ease:Circ.easeOut } );
			currentNutrient.setLabel( Singleton.instance.selectedNutrient.NT_NME );			
		}
		
		public function transIn():void{
			TweenLite.to( this, 1, { y:0, ease:Circ.easeOut } );
			toggleView.isSelected();
			toggleView.updateRadioButtons(0);
		}
		
	}
}