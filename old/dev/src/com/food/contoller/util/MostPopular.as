package com.food.contoller.util
{
	import com.food.model.data.DataGroups;
	import com.food.model.data.Singleton;

	public class MostPopular
	{
		public function MostPopular()
		{
		}
		
		public static function getMostPopular( amount:uint ):void
		{
			var vGroups:Vector.<DataGroups> = Singleton.instance.vectorGroups;
			for( var i:uint=0;i<vGroups.length;i++){									
				var vector:Vector.<DataFoods> = new Vector.<DataFoods>;
				
				
				var inc:uint = 0;
				for( var i:uint=0;i<_vectorFoods.length;i++ ){
					if( _vectorFoods[i].FD_GRP_ID==FD_GRP_ID ){
						vector[inc] = _vectorFoods[i];
						inc++;
					}
				}	
			}
		}
		
		
	
		
	}
}