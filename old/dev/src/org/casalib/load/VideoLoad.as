/*
	CASA Lib for ActionScript 3.0
	Copyright (c) 2009, Aaron Clinger & Contributors of CASA Lib
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:
	
	- Redistributions of source code must retain the above copyright notice,
	  this list of conditions and the following disclaimer.
	
	- Redistributions in binary form must reproduce the above copyright notice,
	  this list of conditions and the following disclaimer in the documentation
	  and/or other materials provided with the distribution.
	
	- Neither the name of the CASA Lib nor the names of its contributors
	  may be used to endorse or promote products derived from this software
	  without specific prior written permission.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
	POSSIBILITY OF SUCH DAMAGE.
*/
package org.casalib.load {
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.utils.getTimer;
	import org.casalib.events.LoadEvent;
	import org.casalib.events.VideoLoadEvent;
	import org.casalib.load.LoadItem;
	import org.casalib.math.Percent;
	import org.casalib.time.EnterFrame;
	import org.casalib.util.LoadUtil;
	import flash.net.NetStream;
	
	[Event(name="cuePoint", type="org.casalib.events.VideoInfoEvent")]
	[Event(name="metaData", type="org.casalib.events.VideoInfoEvent")]
	[Event(name="buffered", type="org.casalib.events.VideoLoadEvent")]
	[Event(name="progress", type="org.casalib.events.VideoLoadEvent")]
	[Event(name="asyncError", type="flash.events.AsyncErrorEvent")]
	[Event(name="netStatus", type="flash.events.NetStatusEvent")]
	[Event(name="securityError", type="flash.events.SecurityErrorEvent")]
	
	/**
		Provides an easy and standardized way to load video files. VideoLoad also includes {@link VideoLoadEvent buffer progress information} in the progress event.
		
		@author Aaron Clinger
		@version 12/01/08
		@example 
			<code>
				package {
					import flash.display.MovieClip;
					import org.casalib.events.VideoLoadEvent;
					import org.casalib.load.VideoLoad;
					
					
					public class MyExample extends MovieClip {
						protected var _videoLoad:VideoLoad;
						
						
						public function MyExample() {
							super();
							
							this._videoLoad = new VideoLoad("test.flv");
							this._videoLoad.pauseStart = true;
							this._videoLoad.addEventListener(VideoLoadEvent.PROGRESS, this._onProgress);
							this._videoLoad.addEventListener(VideoLoadEvent.BUFFERED, this._onBuffered);
							this._videoLoad.start();
							
							this.addChild(this._videoLoad.video);
						}
						
						protected function _onProgress(e:VideoLoadEvent):void {
							trace(e.millisecondsUntilBuffered + " milliseconds until buffered");
							trace(e.buffer.percentage + "% buffered");
							trace(e.progress.percentage + "% loaded");
						}
						
						protected function _onBuffered(e:VideoLoadEvent):void {
							e.target.netStream.resume();
						}
					}
				}
			</code>
	*/
	public class VideoLoad extends LoadItem {
		protected var _buffered:Boolean;
		protected var _connection:NetConnection;
		protected var _duration:Number;
		protected var _framePulse:EnterFrame;
		protected var _pauseStart:Boolean;
		protected var _buffer:Percent;
		protected var _readyToCalculateBuffer:Boolean;
		protected var _millisecondsUntilBuffered:int;
		protected var _video:Video;
		
		
		/**
			Creates a new VideoLoad.
			
			@param request: A {@code String} or an {@code URLRequest} reference to the video you wish to load.
		*/
		public function VideoLoad(request:*) {
			this._connection = new NetConnection();
			this._connection.connect(null);
			
			super(new NetStream(this._connection), request);
			
			this._initListeners(this._loadItem);
			
			this._duration                  = -1;
			this._buffer                    = new Percent();
			this._millisecondsUntilBuffered = -1;
			this._framePulse                = EnterFrame.getInstance();
			
			this._video = new Video();
			this._video.attachNetStream(this._loadItem);
		}
		
		/**
			The duration/length of the video.
			
			@usageNote Setting this value will override the length (provided by the video metadata) that is used to calculate buffer.
		*/
		public function get duration():Number {
			return this._duration;
		}
		
		public function set duration(seconds:Number):void {
			this._duration = seconds;
		}
		
		/**
			Indicates to pause video at start {@code true}, or to let the video automatically play {@code false}; defaults to {@code false}.
		*/
		public function get pauseStart():Boolean {
			return this._pauseStart;
		}
		
		public function set pauseStart(shouldPause:Boolean):void {
			this._pauseStart = shouldPause;
		}
		
		/**
			A Video class with attached NetStream.
		*/
		public function get video():Video {
			return this._video;
		}
		
		/**
			The NetConnection class used by the VideoLoad class.
		*/
		public function get connection():NetConnection {
			return this._connection;
		}
		
		/**
			The NetStream class used by the VideoLoad class.
		*/
		public function get netStream():NetStream {
			return this._loadItem as NetStream;
		}
		
		/**
			The time remaining in milliseconds until the video has completely buffered.
			
			@usageNote {@link VideoLoad} will report {@code -1} milliseconds until two seconds of load time has elapsed.
		*/
		public function get millisecondsUntilBuffered():int {
			return this._millisecondsUntilBuffered;
		}
		
		/**
			The percent the video has buffered.
			
			@usageNote {@link VideoLoad} will report {@code 0} percent until two seconds of load time has elapsed.
		*/
		public function get buffer():Percent {
			return this._buffer.clone();
		}
		
		public function get buffered():Boolean {
			return this._buffered;
		}
		
		/**
			@exclude
		*/
		override public function stop():void {
			this._framePulse.removeEventListener(Event.ENTER_FRAME, this._onFrameFire);
			
			super.stop();
		}
		
		/**
			@usageNote {@code destroy} does not close the internal NetStream object. To completely destroy a VideoLoad you have to close the NetStream object:
			<code>
				this._videoLoad.netStream.close();
				this._videoLoad.destroy();
			</code>
		*/
		override public function destroy():void {
			this._dispatcher.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.dispatchEvent, false);
			this._dispatcher.removeEventListener(NetStatusEvent.NET_STATUS, this._netStatus, false);
			this._connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.dispatchEvent, false);
			
			this._loadItem.client = this._loadItem;
			
			super.destroy();
		}
		
		/**
			@sends AsyncErrorEvent#ASYNC_ERROR - Dispatched when an exception is thrown asynchronously.
			@sends SecurityErrorEvent#SECURITY_ERROR - Dispatched if load is outside the security sandbox.
			@sends VideoInfoEvent#CUE_POINT - Dispatched when a video cue point is reached.
			@sends VideoInfoEvent#META_DATA - Dispatched when video meta data is received.
		*/
		override protected function _initListeners(dispatcher:IEventDispatcher):void {
			this._dispatcher = dispatcher;
			
			this._dispatcher.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.dispatchEvent, false, 0, true);
			this._dispatcher.addEventListener(NetStatusEvent.NET_STATUS, this._netStatus, false, 0, true);
			this._connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.dispatchEvent, false, 0, true);
			
			this._loadItem.client = new VideoLoadNetStreamClient(this);
		}
		
		/**
			@sends VideoLoadEvent#PROGRESS - Dispatched as video is received during the download process.
			@sends VideoLoadEvent#BUFFERED - Dispatched when video is buffered.
		*/
		override protected function _calculateLoadProgress():void {
			var justBuffered:Boolean         = false;
			var currentTime:int              = getTimer();
			this._Bps                        = LoadUtil.calculateBps(this.bytesLoaded, this._startTime, currentTime);
			this._progress.decimalPercentage = this.bytesLoaded / this.bytesTotal;
			
			if (!this.buffered && this.duration > 0) {
				if (this._readyToCalculateBuffer) {
					var videoLength:uint = uint(Math.max((this.duration - 2) * 1000, 0));
					
					this._buffer                    = LoadUtil.calculateBufferPercent(this.bytesLoaded, this.bytesTotal, this._startTime, currentTime, videoLength);
					this._millisecondsUntilBuffered = LoadUtil.calculateMillisecondsUntilBuffered(this.bytesLoaded, this.bytesTotal, this._startTime, currentTime, videoLength);
				} else if (currentTime - this._startTime > 2000)
					this._readyToCalculateBuffer = true;
			}
			
			if (!this.buffered && this.duration > 0)
				if (this.buffer.decimalPercentage == 1 || this._progress.decimalPercentage == 1)
					this._buffered = justBuffered = true;
			
			if (this.buffered) {
				this._buffer                    = new Percent(1);
				this._millisecondsUntilBuffered = 0;
			}
			
			this.dispatchEvent(this._createDefinedVideoLoadEvent(VideoLoadEvent.PROGRESS));
			
			if (justBuffered)
				this.dispatchEvent(this._createDefinedVideoLoadEvent(VideoLoadEvent.BUFFERED));
			
			if (this.bytesLoaded >= this.bytesTotal && this.buffered)
				this._onComplete();
		}
		
		override protected function _complete():void {
			super._complete();
			
			this._framePulse.removeEventListener(Event.ENTER_FRAME, this._onFrameFire);
		}
		
		override protected function _load():void {
			this._loadItem.play(this._request.url);
			
			if (this.pauseStart)
				this._loadItem.pause();
			
			this._buffer                    = new Percent();
			this._millisecondsUntilBuffered = -1;
			this._buffered = this._readyToCalculateBuffer = false;
			
			this._framePulse.addEventListener(Event.ENTER_FRAME, this._onFrameFire, false, 0, true);
		}
		
		protected function _createDefinedVideoLoadEvent(type:String):VideoLoadEvent {
			var vidLoadEvent:VideoLoadEvent        = new VideoLoadEvent(type);
			vidLoadEvent.bytesLoaded               = this.bytesLoaded;
			vidLoadEvent.bytesTotal                = this.bytesTotal;
			vidLoadEvent.progress                  = this.progress;
			vidLoadEvent.Bps                       = this.Bps;
			vidLoadEvent.buffer                    = this.buffer;
			vidLoadEvent.millisecondsUntilBuffered = this.millisecondsUntilBuffered;
			
			return vidLoadEvent;
		}
		
		/**
			@sends NetStatusEvent#NET_STATUS - Dispatched when a NetStream object has reporting its status.
		*/
		protected function _netStatus(e:NetStatusEvent):void {
			if (e.info.level == 'error')
				this._onLoadError(e);
			else
				this.dispatchEvent(e);
		}
		
		protected function _onFrameFire(e:Event):void {
			this._calculateLoadProgress();
		}
	}
}

import org.casalib.events.VideoInfoEvent;
import org.casalib.load.VideoLoad;

class VideoLoadNetStreamClient {
	protected var _videoLoad:VideoLoad;
	
	
	public function VideoLoadNetStreamClient(sender:VideoLoad) {
		this._videoLoad = sender;
	}
	
	public function onCuePoint(infoObject:Object):void {
		var vidInfoEvent:VideoInfoEvent = new VideoInfoEvent(VideoInfoEvent.CUE_POINT);
		vidInfoEvent.infoObject         = infoObject;
		
		this._videoLoad.dispatchEvent(vidInfoEvent);
	}
	
	public function onMetaData(infoObject:Object):void {
		if (this._videoLoad.duration == -1)
			this._videoLoad.duration = infoObject.duration;
		
		var vidInfoEvent:VideoInfoEvent = new VideoInfoEvent(VideoInfoEvent.META_DATA);
		vidInfoEvent.infoObject         = infoObject;
		
		this._videoLoad.dispatchEvent(vidInfoEvent);
	}
}