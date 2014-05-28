package  
{
	import flash.display.Sprite;
	public class MazeCell
	{
		public var walls:Vector.<Boolean> = Vector.<Boolean>([true, true, true, true]);
		public var visited:Boolean = false;
		public var blocked:Boolean = false;
		public var visitedByPath:Boolean = false;
		public function get amountOfWalls():int
		{
			var counter:int = 0;
			for (var i:int = 0; i < walls.length; i++) 
			{
				if (walls[i])
					counter++;
			}
			return counter;
		}
	}
}