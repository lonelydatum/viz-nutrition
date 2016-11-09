package com.food.managers
{
	
	import com.adobe.serialization.json.JSON;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import org.casalib.events.ListenerManager;
	import org.casalib.events.LoadEvent;
	import org.casalib.load.DataLoad;
	
	public class LoadManager
	{
		
		protected var _dataLoad			:DataLoad;
		private var urlLoader			:URLLoader;
		
		
		
		public function LoadManager()
		{
			
			//this._dataLoad = new DataLoad("PDO_food.php");
			//this._dataLoad.addEventListener(LoadEvent.COMPLETE, this._onComplete);
			//this._dataLoad.start();
			
			urlLoader = new URLLoader();
			urlLoader.addEventListener( Event.COMPLETE, onCompleteHandler );
			var urlVariables:URLVariables = new URLVariables();
			urlVariables.GP_ID = "2";
			urlVariables.NT_ID = "203";
			var req:URLRequest = new URLRequest( "http://localhost/~Gar/universalstories/project/food/deploy/services/getNutrientsByGroupID.php" );
			req.data = urlVariables;
			urlLoader.load( req );
		}
		
		private function onCompleteHandler( e:Event ):void
		{
			var str:String = urlLoader.data.toString();
			
			
			var arr:Array = JSON.decode( str );
			trace("ddddddddd = "+arr.length);			
			//ExternalInterface.call( "console.log", "gar = "+arr.length );
		}
		
		protected function _onComplete(e:LoadEvent):void {
			ExternalInterface.call( "consol.log", this._dataLoad.data );
		}
	}
}