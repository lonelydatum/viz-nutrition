package com.food.view.chart
{
	
	
	import com.food.model.data.Config;
	import com.food.model.data.DataGroups;
	import com.food.view.common.TextFieldFood;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.casalib.util.RatioUtil;
	
	public class ViewGroupLabel extends Sprite
	{
		
		private var _icon				:Sprite;
		
		private var _tf					:TextFieldFood;
		private var _dataGroups			:DataGroups;
		
		
		public function ViewGroupLabel( dataGroups:DataGroups )
		{
			_dataGroups = dataGroups;
			init();
		}
		
		private function init( ):void
		{
			
			_tf = new TextFieldFood();	
			
			
			var fmt:TextFormat = new TextFormat();
			fmt.align = TextFormatAlign.CENTER;
			var font:Font = new Config.FONT_BOOK();
			fmt.font = font.fontName;			
			fmt.size = 13;
			_tf.setFormat( fmt );
			
			_tf.x = -5;
			
			
			_tf.width = 180;
			
			
			_tf.wordWrap = true;
			_tf.multiline = true;
			_tf.text = _dataGroups.FD_GRP_NME;				
			this.addChild( _tf );			
			createIcon();
		}
		
		private function createIcon():void
		{
			_icon = new Sprite();
			_icon.y = _tf.y + _tf.height;
			_icon.graphics.beginFill( 0xFF0000, 0 );
			_icon.graphics.drawRect( 0, 0, 120, 75 );
			_icon.graphics.endFill();
			this.addChild( _icon );
			
			var loader:Loader = new Loader();
			
			loader.x = (_tf.width - _icon.width) * .5;
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(){
				Bitmap(loader.contentLoaderInfo.content).smoothing = true;
				_icon.addChild( loader );
				var rectIcon:Rectangle = loader.getBounds(loader);
				//var rectNew:Rectangle = RatioUtil.scaleWidth( rectIcon, 55 );
				
				//loader.width = rectNew.width;
				//loader.height = rectNew.height;
				loader.alpha  = .75;
				//_icon.graphics.beginFill(Math.random()*0xFFFFFF,.5);
				//_icon.graphics.drawRect(0,0,width,height);
				//_icon.graphics.endFill();
				
			
				
			})
			
			var req:URLRequest = new URLRequest( "assets/images/icons/icon_"+_dataGroups.FD_GRP_ID+".png" );			
			
			loader.load( req );
					
		}
		
	}
}