package  
{
	import flash.geom.Point;
	public class Directions
	{
		//down,left,up,right
		public static var diagonal:Vector.<Point> = Vector.<Point>([new Point(0, 1), new Point( -1, 0), new Point(0, -1), new Point(1, 0), new Point(1, 1), new Point(1, -1), new Point( -1, 1), new Point( -1, -1)]);		
		public static var clockwise:Vector.<Point> = Vector.<Point>([new Point(0, -1), new Point( 1, -1), new Point(1, 0), new Point(1, 1), new Point(0, 1), new Point( -1, 1), new Point( -1, 0), new Point( -1, -1)]);		
		public static var clockwiseNoDiag:Vector.<Point> = Vector.<Point>([new Point(0, -1), new Point(1, 0), new Point(0, 1), new Point( -1, 0)]);		
		public static var noDiagonal:Vector.<Point> = Vector.<Point>([new Point(0, 1), new Point( -1, 0), new Point(0, -1), new Point(1, 0)]);		
		public static function scaled(nr:int, scale:Number):Point
		{
			return new Point(diagonal[nr].x * scale, diagonal[nr].y * scale);
		}
		public static function getDir(p1:Point, p2:Point):Point
		{
			var diff:Point = p2.subtract(p1);
			diff.normalize(1);
			return diff;
		}
	}

}