package com.food.model.data
{
	import flash.text.Font;
	import flash.text.TextFormat;

	public class Style
	{
		public function Style()
		{
			
		}
		
		public static function header():TextFormat{
			var font:Font = new Config.FONT_BOLD();
			var format:TextFormat = new TextFormat();
			format.font = font.fontName;
			format.size = 17;
			
			return format;
		}
		
		public static function body():TextFormat{
			var font:Font = new Config.FONT_BODY();
			var format:TextFormat = new TextFormat();
			format.leading = 9;
			format.font = font.fontName;
			format.size = 12;
			
			return format;
		}
	}
}