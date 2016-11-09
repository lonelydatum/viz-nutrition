package com.food.view.common
{
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class TextFieldFood extends TextField
	{
		public function TextFieldFood()
		{
			autoSize = TextFieldAutoSize.LEFT;
			this.mouseEnabled = false;
			this.multiline = false;
			this.antiAliasType = AntiAliasType.ADVANCED;
		}
		
		public function setFormat( format:TextFormat ):void
		{
			embedFonts = true;
			defaultTextFormat = format;
		}
		
		
		
	}
}