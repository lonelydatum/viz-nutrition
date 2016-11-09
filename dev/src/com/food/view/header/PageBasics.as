package com.food.view.header
{
	import com.food.model.data.Config;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.casalib.util.StageReference;
	
	public class PageBasics extends Sprite
	{
		
		public static const PAGE_FRACTAL			:uint = 0;
		public static const PAGE_LIST				:uint = 1;
		public static const PAGE_REPORT				:uint = 2;
		public static const PAGE_LIGHTBOX			:uint = 3;
		
		
		private var _pageType						:uint;
		private var _colorBG						:Number = 0xFF0000;
		
		public function PageBasics( pType:uint )
		{
			_pageType = pType;
			this.addEventListener(Event.ADDED_TO_STAGE, function():void{
				stage.addEventListener(Event.RESIZE,createBG,false, 0,true);
			})
		}
		
		public function init():void{
			createBG();
			TweenLite.from( this, 1, { alpha:0 } );
		}
		
		public function createBG( e:Event=null ):void
		{
			this.graphics.clear();
			this.graphics.beginFill( colorBG );			
			this.graphics.drawRect( 0, 0, StageReference.getStage().stageWidth, Config.HEADER_HEIGHT );
			this.graphics.endFill();			
		}
		
		
		public function get pageType( ):uint{
			return _pageType;
		}
		
		public function set colorBG( value:Number ):void{
			_colorBG = value;
		}
		
		public function get colorBG( ):Number{
			return _colorBG;
		}
		
		public function transOut():void{
			TweenLite.to( this, 1, { alpha:0, onComplete:destroy } );
		}
		
		public function destroy( ):void{
			this.parent.removeChild( this );
		}
	}
}