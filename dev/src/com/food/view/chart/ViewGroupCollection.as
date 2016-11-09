package com.food.view.chart
{
	
	
	import com.food.contoller.events.HoverTipEvent;
	import com.food.model.chart.GroupColor;
	import com.food.model.data.ColorFoodGroups;
	import com.food.model.data.Config;
	import com.food.model.data.DataFoods;
	import com.food.model.data.DataGroups;
	import com.food.model.data.FoodGroups;
	import com.food.model.data.Singleton;
	import com.food.view.chart.assets.Tip;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	
	import org.casalib.util.StageReference;


	public class ViewGroupCollection extends Sprite
	{
		
		private var _groups				:Array;		
		private var _foodGroupedData	:Array;	
		private var _vectorFoods		:Vector.<DataFoods>;
		private var _vectorGroups		:Vector.<DataGroups>;
		
		private var _tip				:Tip;		
		
		
		//public var percentNutrition		:Number;
		private var _highestAmount		:Number;
		private var _ratio				:Number;
		private var _selectedNutrient	:String;
		
		
		public function ViewGroupCollection()
		{			
			this.x = 10;
			_groups = new Array();			
			
			_tip = new Tip();
			this.addChild( _tip );
			
			this.addEventListener(Event.ADDED_TO_STAGE, function(){
				stage.addEventListener( Event.RESIZE, function(){
					position();
				} );
			})			
		}
		
		public function createVisualization( vectorGroups:Vector.<DataGroups>, vectorFoods:Vector.<DataFoods>, selectedNutrient:String ):void{
			_vectorGroups = vectorGroups;
			_vectorFoods = vectorFoods;
			_selectedNutrient = selectedNutrient;
			
			calculateLongestWidth();
			Singleton.instance.colorFoodGroups = new Vector.<ColorFoodGroups>
			for( var i:uint=0;i<_vectorGroups.length;i++){									
				var v:Vector.<DataFoods> = getFoodGroupById( _vectorGroups[i].FD_GRP_ID );
				createSingleGroup( _vectorGroups[i], v );	
				Singleton.instance.colorFoodGroups.push( new ColorFoodGroups( _groups[i].groupColor, _vectorGroups[i].FD_GRP_ID ) );
			}
		}
		
		private function getFoodGroupById( FD_GRP_ID:uint ):Vector.<DataFoods>{
			var vector:Vector.<DataFoods> = new Vector.<DataFoods>;
						
			var inc:uint = 0;
			for( var i:uint=0;i<_vectorFoods.length;i++ ){
				if( _vectorFoods[i].FD_GRP_ID==FD_GRP_ID ){
					vector[inc] = _vectorFoods[i];
					inc++;
				}
			}			
			return vector;
		}
		
		
		private function calculateLongestWidth( ):void
		{			
			_highestAmount = 0;
			for( var i:uint=0;i<_vectorFoods.length;i++){
				var highestWithinTheGroup:Number = _vectorFoods[i].NT_VALUE;
				
				if( highestWithinTheGroup > _highestAmount ){
					_highestAmount = highestWithinTheGroup;
				}
			}
					
			var sw:Number = StageReference.getStage().stageWidth;
			var rect:Rectangle = new Rectangle( 0, 0, sw-ViewGroup.LABEL_WIDTH, 1000);
			var desiredMaxWidth:Number = rect.width * .3;
						
			if( Singleton.instance.selectedNutrient.NT_ID!=255 ){
				_ratio = desiredMaxWidth / _highestAmount;	
			}else{
				_ratio = 1;
			}
			//trace( Singleton.instance.selectedNutrient.NT_ID, desiredMaxWidth, _highestAmount, _ratio );
		}
		
		private function createSingleGroup( vectorGroup:DataGroups, vectorFoodGroup:Vector.<DataFoods> ):void{			
			var group:ViewGroup = new ViewGroup( vectorGroup );
			group.addEventListener( HoverTipEvent.HOVER_OUT, function( e:HoverTipEvent ){
				_tip.hide();
			})			
			group.addEventListener( HoverTipEvent.HOVER, function( e:HoverTipEvent ):void{
				
				//var rect:Rectangle = new Rectangle( e.target.x, e.target.y + e.currentTarget.y, (e.target as Sprite).getRect(e.target as Sprite).width, (e.target as Sprite).getRect(e.target as Sprite).height );
				var rect:Rectangle = new Rectangle( e.stageX, e.stageY-y, (e.target as Sprite).getRect(e.target as Sprite).width, (e.target as Sprite).getRect(e.target as Sprite).height );
				
				showTip( e.foodName, e.amount, rect );				
			});
			
			group.ratio = _ratio;			
			group.groupColor = ( _groups.length < Config.COLOR_TOP.length ) ? Config.COLOR_TOP[ _groups.length ] : 0x545454;
			//var colorFoodGroup:ColorFoodGroups = new ColorFoodGroups( group.groupColor, vectorGroup.FD_GRP_ID );
			
			group.start( vectorFoodGroup );
			this.addChild( group );
			_groups.push( group );
			
			
			_groups.sortOn( "_totalNT", Array.NUMERIC | Array.DESCENDING );			
			position();
		}
		
		private function position():void
		{
			calculateLongestWidth();
			var yPos:Number = 0;
			for( var i:uint=0;i<_groups.length;i++){
				_groups[i].y = yPos;
				yPos = _groups[i].y + _groups[i].height+10;
			}
						
			ExternalInterface.call( "updateHeight", ( height + y ) + 100 );
		}
		
	
		private function showTip( foodName:String, amount:Number, rect:Rectangle ):void
		{
			
			this.setChildIndex( _tip, this.numChildren-1 );			
			_tip.show( foodName, amount, _selectedNutrient, rect );
		}
		
		public function reset():void
		{			
			for( var i:uint=0;i<_groups.length;i++){
				this.removeChild( _groups[i] );
				_groups[i].reset();		
			}					
			_groups = new Array();			
		}
	}
}