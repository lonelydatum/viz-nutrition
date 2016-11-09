package com.food.model.data
{
	
	import com.google.analytics.AnalyticsTracker;
	
	import flash.external.ExternalInterface;
	
	public class GoogleAnalytics
	{
		public function GoogleAnalytics()
		{
		}
		
		public static function track( tag:String ):void
		{			
			ExternalInterface.call("pageTracker._trackPageview", tag );
			//ExternalInterface.call("pageTracker", tag );
		}
	}
}