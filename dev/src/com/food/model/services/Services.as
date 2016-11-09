﻿package com.food.model.services{		import com.adobe.serialization.json.JSON;	import com.food.contoller.Controller;	import com.food.contoller.events.ServiceEvent;	import com.food.model.data.DataFoods;	import com.food.model.data.DataGroups;	import com.food.model.data.DataNutrient;		import flash.events.Event;	import flash.events.EventDispatcher;	import flash.external.ExternalInterface;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.net.URLRequestMethod;	import flash.net.URLVariables;				public class Services extends EventDispatcher	{				private var _basePath			:String = "http://lonelydatum.com/projects/food/";							public function Services()		{		}				public function getNutritionTotal():void{						var urlLoader:URLLoader = new URLLoader();			urlLoader.addEventListener( Event.COMPLETE, function(){				var str:String = urlLoader.data.toString();								var serviceEvent:ServiceEvent = new ServiceEvent( ServiceEvent.QUERY_BY_NT_TOTAL );				var arr:Array = JSON.decode( str );				var vector:Vector.<DataNutrient> = new Vector.<DataNutrient>;								var sum:uint = 0;				for( var sumInc:uint=0;sumInc<arr.length;sumInc++ ){										sum = sum + Number(arr[sumInc].Total);				}												var inc:uint = 0;				for( var i:uint=0;i<arr.length;i++ ){										if( arr[i].Total > 10 ){												var dataNutrient:DataNutrient = new DataNutrient();						dataNutrient.NT_ID = arr[i].NT_ID;						dataNutrient.NT_NME = arr[i].NT_NME;						dataNutrient.Total = arr[i].Total;						dataNutrient.percent = arr[i].Total/sum;						dataNutrient.UNIT = arr[i].UNIT;						dataNutrient.DRI = uint(arr[i].DRI);						dataNutrient.description = arr[i].description;												vector[inc] = dataNutrient;						inc++;					}																}								var b:Number = 0;				for( var a:uint=0;a<vector.length;a++){					b += vector[a].percent;					//trace( "getNutritionTotal = "+vector[a].NT_NME, sum, vector[a].percent );				}												serviceEvent.vectorNutrients = vector;				dispatchEvent( serviceEvent );				} );						var URL:String = _basePath+"services/mysql/getNutritionTotal.php";			var req:URLRequest = new URLRequest( URL );			urlLoader.load( req );					}						public function getGroupsWithNutritionTotal( nutrientID:uint ):void		{							var urlLoader:URLLoader = new URLLoader();			urlLoader.addEventListener( Event.COMPLETE, function(){				var str:String = urlLoader.data.toString();				var serviceEvent:ServiceEvent = new ServiceEvent( ServiceEvent.QUERY_BY_GROUPS );				var arr:Array = JSON.decode( str );											var vector:Vector.<DataGroups> = new Vector.<DataGroups>(arr.length, true);				for( var i:uint=0;i<arr.length;i++ ){					var dataGroups:DataGroups = new DataGroups();										dataGroups.FD_GRP_ID = arr[i].FD_GRP_ID;											dataGroups.FD_GRP_NME = arr[i].FD_GRP_NME;					dataGroups.sumOfNutrition = arr[i].sumOfNutrition;					vector[i] = dataGroups;									}				serviceEvent.vectorGroups = vector;				dispatchEvent( serviceEvent );							} );						var urlVariables:URLVariables = new URLVariables();			urlVariables.NT_ID = nutrientID;						var URL:String = _basePath+"services/mysql/getGroupsWithNutritionTotal.php";			var req:URLRequest = new URLRequest( URL );			req.method = URLRequestMethod.POST;			req.data = urlVariables;			urlLoader.load( req );					}				public function getAllFoodsByNutrient( nutrientID:uint ):void		{						var urlLoader:URLLoader = new URLLoader();			urlLoader.addEventListener( Event.COMPLETE, function(){				var str:String = urlLoader.data.toString();				var serviceEvent:ServiceEvent = new ServiceEvent( ServiceEvent.QUERY_BY_NT_FOOD );				var arr:Array = JSON.decode( str );								var vector:Vector.<DataFoods> = new Vector.<DataFoods>(arr.length, true);				for( var i:uint=0;i<arr.length;i++ ){					var dataFoods:DataFoods = new DataFoods();					dataFoods.A_FD_NME = arr[i].A_FD_NME;					dataFoods.FD_GRP_ID = arr[i].FD_GRP_ID;					dataFoods.FD_ID = arr[i].FD_ID;						dataFoods.NT_VALUE = arr[i].NT_VALUE;										vector[i] = dataFoods;									}								serviceEvent.vectorFoods = vector;									dispatchEvent( serviceEvent );				} );						var urlVariables:URLVariables = new URLVariables();			urlVariables.NT_ID = nutrientID;			var URL:String = _basePath+"services/mysql/getAllFoodsByNutrient.php";			var req:URLRequest = new URLRequest( URL );			req.method = URLRequestMethod.POST;			req.data = urlVariables;			urlLoader.load( req );					}						public function reset():void		{			trace( "i will reset" );		}			}}