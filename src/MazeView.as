package  
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	public class MazeView extends Sprite
	{
		private var len:int;
		private var mazeLayer:Sprite = new Sprite();
		private var pathLayer:Sprite = new Sprite();
		private var colorInterval:int = 0;
		
		public function MazeView(wallLength:int) 
		{
			
			len = wallLength;
			addChild(mazeLayer);
			addChild(pathLayer);
			mazeLayer.filters = [new GlowFilter(0xffff00, 0.5, 5, 5, 4, 3)];
			pathLayer.filters = [new GlowFilter(0xffffff,1,10,10,2,1)];
		}
		public function get blockSize():int 
		{
			return len;
		}
		public function showMaze(maze:Vector.<Vector.<MazeCell>>):void
		{		
			mazeLayer.graphics.clear();
			pathLayer.graphics.clear();
			mazeLayer.graphics.lineStyle(3,0x000000);
			for (var i:int = 0; i < maze.length; i++) 
			{				
				for (var j:int = 0; j < maze[0].length; j++) 
				{	
					var nx:int = i * len;
					var ny:int = j * len;	
					for (var k:int = 0; k < maze[i][j].walls.length; k++) 
					{
						if (maze[i][j].walls[k])
							drawWall(i, j, k);
					}
					//if (maze[i][j].walls[0])
					//{
						//mazeLayer.graphics.moveTo(nx + len, ny + len);
						//mazeLayer.graphics.lineTo(nx, ny + len);		
					//}
					//if (maze[i][j].walls[1])
					//{
						//mazeLayer.graphics.moveTo(nx + len, ny);
						//mazeLayer.graphics.lineTo(nx + len, ny + len);
					//}					
					//if (maze[i][j].walls[2])
					//{
						//mazeLayer.graphics.moveTo(nx, ny);
						//mazeLayer.graphics.lineTo(nx + len, ny );
					//}
					//if (maze[i][j].walls[3])
					//{
						//mazeLayer.graphics.moveTo(nx, ny);
						//mazeLayer.graphics.lineTo(nx, ny + len);			
					//}
					if (maze[i][j].blocked)
					{
						mazeLayer.graphics.beginFill(0);
						mazeLayer.graphics.drawRect(nx, ny, len, len);
						mazeLayer.graphics.endFill();
					}
				}
			}	
		}	
		private function drawWall(x:int,y:int,wallIndex:int):void
		{
			var nx :int = x * len;
			var ny :int = y * len;
			var start:Point;
			var end:Point;
			switch( wallIndex)
			{
				case 0:start = new Point(nx,ny); end = new Point(nx+len,ny); break;
				case 1:start = new Point(nx+len,ny); end = new Point(nx+len,ny+len); break;
				case 2:start = new Point(nx+len,ny+len); end = new Point(nx,ny+len); break;
				case 3:start = new Point(nx,ny+len); end = new Point(nx,ny); break;
			}

			mazeLayer.graphics.moveTo(start.x,start.y);
			mazeLayer.graphics.lineTo(end.x, end.y);	
			
						
		}
		public function addPathPoint(p:Point):void
		{
			var col:uint;
			switch(colorInterval)
			{
				case 2:col = 0x0000ff; break;
				case 1:col = 0xffff00; break;
				default:col = 0xff0000; break;
			}
			colorInterval = (colorInterval < 2)?colorInterval + 1:0;
			col = 0xffff00;
			pathLayer.graphics.lineStyle(1);
			pathLayer.graphics.beginFill(col);
			pathLayer.graphics.drawCircle((p.x * len) + len / 2, (p.y * len) + len / 2, len / (7));
			pathLayer.graphics.endFill();			
		}
		

	}

}