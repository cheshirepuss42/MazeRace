package  
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Matrix;
	
	
	import flash.text.*;	

	public class ScreenLabel extends Sprite
	{
		private var gameOverLabel:TextField;
		private var format:TextFormat;		
		public function ScreenLabel() 
		{
			
			
			format = new TextFormat();
			format.size = 120;
			format.font = "Impact";
			format.bold = true;
			format.align = TextFormatAlign.CENTER;
			format.color = 0xff0000;
			gameOverLabel = new TextField();			
			gameOverLabel.selectable = false;
			gameOverLabel.multiline = true;
			//gameOverLabel.rotation = -20;
			addChild(gameOverLabel);
			gameOverLabel.filters = [new GlowFilter(0, 0.8, 8, 8, 6, 1, true, false)];
		
		}
		public function set text(str:String):void
		{
			gameOverLabel.text = str;
			gameOverLabel.setTextFormat(format);
			gameOverLabel.autoSize = TextFieldAutoSize.LEFT;
			
			x = (stage.stageWidth / 2) - (width / 2);
			
			y = (stage.stageHeight / 2) - (height / 2);
			
		}
		
	}

}