package  
{
	import flash.display.Sprite;
	import flash.text.*;
	
	public class ProgressBar extends Sprite
	{
		private var text:TextField = new TextField();
		private var barText:TextField = new TextField();
		private var format:TextFormat = new TextFormat();
		private var barFormat:TextFormat = new TextFormat();
		private var title:String;
		private var w:int;
		private var h:int;
		private var innerWidth:int;
		private var innerHeight:int;
		private var col1:uint;
		private var col2:uint;
		private var percentage:Number=0;
		private var padding:Number = 3;
		private var bar:Sprite = new Sprite();
		public function ProgressBar(_w:int,_h:int,_bgCol:uint,_barCol:uint,_title:String="") 
		{
			title = _title;
			w = _w;
			h = _h;
			col1 = _bgCol;
			col2 = _barCol;
			innerWidth = w - (padding * 2);
			innerHeight = h - (padding * 2);
			this.graphics.lineStyle(1, 0);
			this.graphics.beginFill(col1);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
			if (title != "")
			{
				addChild(text);
				text.text = title;				
				format.size = (innerHeight) /2.5;
				format.font = "Times New Roman";
				text.setTextFormat(format);
				text.autoSize = TextFieldAutoSize.LEFT;
				text.x = padding + (innerWidth / 2) - (text.textWidth / 2);
				text.y = padding;// + ((w - (padding * 2)) / 2) - (text.textheight / 2);
			}
			addChild(bar);
			setPercentage(0)

			bar.addChild(barText);			
		}
		
		public function setPercentage(_percentage:Number,_barText:String="",barTextBackground:Boolean=false):void
		{
			var barHeight:int = (title == "")?innerHeight:innerHeight / 2.5;			
			bar.x = padding;
			bar.y = h - (barHeight + padding);
			percentage = _percentage;
			bar.graphics.clear();
			bar.graphics.lineStyle(1, 0);
			bar.graphics.drawRect(0, 0, innerWidth, barHeight);
			bar.graphics.beginFill(col2);
			bar.graphics.drawRect(0, 0, innerWidth * percentage, barHeight);
			bar.graphics.endFill();	
			if (_barText != "")
			{				
				barText.text = _barText;
				barFormat.size = barHeight *0.5;
				barFormat.font = "Times New Roman";
				barText.setTextFormat(barFormat);
				barText.autoSize = TextFieldAutoSize.LEFT;
				barText.x = (bar.width / 2) - (barText.width / 2);
				barText.y = (bar.height / 2) - (barText.height / 2);
				if (barTextBackground)
				{
					bar.graphics.lineStyle(0, 0);
					bar.graphics.beginFill(0xffffff, 0.7);
					bar.graphics.drawRect(barText.x, barText.y, barText.width, barText.height);
					bar.graphics.endFill();					
				}
			}			
		}		
	}

}