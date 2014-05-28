package  
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;

	public class Cursor extends Sprite
	{
		private var counter:int = 0;
		private var color:uint;
		private var size:int;
		public function Cursor(_size:int) 
		{
			this.size = _size/6;
			color = 0xffffff;
			this.graphics.beginFill(color);
			this.graphics.drawCircle(0, 0, size);
			this.graphics.endFill();
			this.visible = false;
			this.mouseEnabled = false;
			this.filters = [new GlowFilter(0xff0000)];
		}

		public function pos(x:int, y:int,target:Sprite=null):void
		{
			//trace(x, y);
			counter++;
			if (counter > 0)
			{
				target.graphics.beginFill(color, 0.4);
				target.graphics.drawCircle(x, y, size*0.8);
				target.graphics.endFill();
				counter = 0;
			}
			this.x = x;
			this.y = y;			
		}
		
	}

}