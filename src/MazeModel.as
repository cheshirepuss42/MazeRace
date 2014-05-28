package  
{
	import flash.geom.Point;

	public class MazeModel
	{		
		public var maze:Vector.<Vector.<MazeCell>> = new Vector.<Vector.<MazeCell>>();
		public var path:Vector.<Point> = new Vector.<Point>();
		public var h:int;
		public var w:int;
		private var dirs:Vector.<Point> = Directions.clockwiseNoDiag;

		public function MazeModel(w:int,h:int) 
		{
			this.h = h;
			this.w = w;
			for (var i:int = 0; i < w; i++) 
			{
				maze[i] = new Vector.<MazeCell>();
				for (var j:int = 0; j < h; j++) 
				{
					maze[i][j] = new MazeCell();
				}
			}

			generate();
			
		}
		public function removeRandomWall():void
		{
			//trace("sdfhsd");
			var p1x:int = (Math.random() * (this.w - 3)) + 1;
			var p1y:int = (Math.random() * (this.h - 3)) + 1;
			setWall(new Point(p1x, p1y), int(Math.random() * 4), false);
		}
		private function blockRandomPoints(am:int):void
		{
			for (var i:int = 0; i < am; i++) 
			{
				var x:int = int(Math.random() * maze.length);
				var y:int = int(Math.random() * maze[0].length);
				maze[x][y].blocked = true;
			}
			maze[0][0].blocked = false;
			maze[w-1][h-1].blocked = false;
		}
		private function blockSquare(offsetx:int=5,offsety:int=5,size:int=5):void
		{
			for (var i:int = 0; i < size; i++) 
			{
				for (var j:int = 0; j < size; j++) 
				{
					maze[offsetx + i][offsety + j].blocked = true;
				}
			}
		}
		public function wallBetweenPoints(p1:Point, p2:Point):Boolean
		{
			var dif:Point = p2.subtract(p1);
			
			dif.normalize(1);
			var dir:int = 0;
			for (var i:int = 0; i < dirs.length; i++) 
			{
				if (dif.equals(dirs[i]))
					dir = i;
			}
			return maze[p1.x][p1.y].walls[dir];
		}
		
		private function generate():void
		{	
			//that var to store the current point in the grid while traversing
			var here:Point = new Point();
			var visited:int = 0;
			//the var to store the nodes that have been deemed viable but not yet visited
			var toBeInvestigated:Vector.<Point> = new Vector.<Point>();
			//while not visited all nodes in grid
			while (visited < (h * w))
			{
				//get the directionid of neighbours that are neither blocked nor visited
				var viableNeighbors:Vector.<int> = getNeighbors(here);
				var amNeighbors:int = viableNeighbors.length;	
				//store the point that will be moved to 
				var there:Point = new Point();
				visited++;
				//set current node as visited
				maze[here.x][here.y].visited = true;								
				//if there are neighbours to visit
				if (amNeighbors > 0)
				{
					//get a random direction from all viable direction (makes the maze random)
					var nextCellDir:int = viableNeighbors[int(Math.random() * amNeighbors)];
					//storing the point that lies in the chosen direction
					there = here.add(dirs[nextCellDir]);
					//and putting it on the tobeinvestigated-list
					toBeInvestigated.push(here.clone());
					//break through wall based on chosen direction
					setWall(here, nextCellDir, false);
					//maze[here.x][here.y].walls[nextCellDir] = false;
					//also break trhough opposite wall in target-node
					//maze[there.x][there.y].walls[(nextCellDir > 1)?nextCellDir - 2:nextCellDir + 2] = false;
				}
				//if there are no neighbours to visit but there are points to be investigated
				else if (toBeInvestigated.length > 1)
				{					
					visited--;
					there = toBeInvestigated.pop();															
				}
				//move from currentpoint to targetpoint
				here = there.clone();
			}
			//makePath(new Point(), new Point(w - 1, h - 1));
		}	
		private function setWall(p:Point, dir:int, placeWall:Boolean = true):void
		{
			maze[p.x][p.y].walls[dir] = placeWall;
			p = p.add(dirs[dir]);
			dir = (dir > 1)?dir - 2:dir + 2;
			maze[p.x][p.y].walls[dir] = placeWall;
		}
		public function getPath(start:Point,end:Point):Vector.<Point>
		{			
			var helpMaze:IntGrid2d = new IntGrid2d(w, h);
			path = new Vector.<Point>();
			path.push(start);
			while (!path[path.length - 1].equals(end))
			{
				var here:Point = path[path.length - 1].clone();
				helpMaze.setVal(1, here);// [here.x][here.y] = 1;
				var exits:Vector.<int> = new Vector.<int>();
				for (var i:int = 0; i < dirs.length; i++) 
				{
					if (!maze[here.x][here.y].walls[i])
					{
						//trace(dirs[i], here, here.add(dirs[i]));
						var p:Point = here.add(dirs[i]);
						
						if (helpMaze.inGrid(p)&&helpMaze.getVal(p)==0)
						{
							exits.push(i);
						}
					}
				}
				if (exits.length == 0)
					path.pop();
				else
				{
					var pickedExit:int = exits[int(Math.random() * exits.length)];
					path.push(new Point(here.x + dirs[pickedExit].x, here.y + dirs[pickedExit].y));					
				}				
			}
			return path;
		}
		
		private function getNeighbors(p:Point):Vector.<int>
		{
			var viableNeighbors:Vector.<int> = new Vector.<int>();
			for (var i:int = 0; i < dirs.length; i++) 
			{
				var nx:int = p.x + dirs[i].x;
				var ny:int = p.y + dirs[i].y;
				if ((nx >= 0 && nx < w && ny >= 0 && ny < h) && !maze[nx][ny].visited && !maze[nx][ny].blocked)
				{
					viableNeighbors.push(i);
				}				
			}
			return viableNeighbors;
		}
		public function traceMaze():void
		{
			var temp:String = "";
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					temp += maze[i][j].amountOfWalls;
					temp += "\t";
				}
				temp += "\n";
			}
			trace(temp);
		}
	}
}