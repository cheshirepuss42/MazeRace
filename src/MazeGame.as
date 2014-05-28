package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.ui.Mouse;

	import flash.utils.Timer;
	
	
	//todo: -add sounds
	// 		-pickup the coins
	//		-add a score counter
	//		-find out how to make it appear 
	//		-change cursor to something with a trail
	
	public class MazeGame extends Sprite
	{
		private var cursor:Cursor;
		private var model:MazeModel;
		private var view:MazeView;
		private var timer:Timer;
		private var w:int;
		private var h:int;
		private var currentPosition:Point;
		private var previousPosition:Point;
		private var madeIt:Boolean = false;
		private var touchedWall:Boolean = false;
		private var tooLate:Boolean = false;
		private var gameOverScreen:ScreenLabel;
		public function MazeGame(w:int,h:int) 
		{
			this.w = w;
			this.h = h;
			//model = new MazeModel(w, h);
			//view = new MazeView(w / model.w, h / model.h);			
			timer = new Timer(200+(w+h));
			timer.addEventListener(TimerEvent.TIMER, step);
			gameOverScreen = new ScreenLabel();

			
			this.filters = [new GlowFilter(0x0000ff)];
			addEventListener(MouseEvent.CLICK, handleMouseClick);
			//addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
		}
		public function setup():void
		{
			//trace(stage.stageWidth, stage.stageHeight);

			graphics.clear();
			graphics.beginFill(0x111111, 1);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			currentPosition = new Point();
			previousPosition = new Point();
			while (this.numChildren > 0)
				this.removeChildAt(0);
			model = new MazeModel(w, h);

			var endPoint:Point;
			do
			{
				endPoint = new Point(int(Math.random() * (w - 1)), int(Math.random() * (h - 1)));
			}
			while (endPoint.equals(new Point()));
			for (var i:int = 0; i < 10; i++) 
			{
				//model.removeRandomWall();
			}			
			model.getPath(new Point(), endPoint);	

						
			touchedWall = false;
			tooLate = false;
			madeIt = false;
			gameOverScreen.visible = false;			
			view = new MazeView(stage.stageHeight/h);	
			addChild(view);	
			addChild(gameOverScreen);
			view.showMaze(model.maze);
			view.addPathPoint(model.path[0]);	
			view.addPathPoint(model.path[model.path.length - 1]);
			cursor = new Cursor(stage.stageHeight / h);

			addChild(cursor);
			//this.filters = [new GlowFilter(0x0000ff, 1, 6, 6, 2, 1, true, false)];			
			//cursor.onFrame();			
		}
		public function start():void
		{
			Mouse.hide();
			cursor.pos(mouseX,mouseY,this);
			cursor.visible = true;
			timer.start();	
			addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
		}
		private function step(e:TimerEvent):void
		{
			view.addPathPoint(model.path[timer.currentCount - 1]);	
			if (timer.currentCount >= model.path.length)
			{
				tooLate = true;
				stop();
			}
		}
		private function handleMouseClick(e:MouseEvent):void
		{
			if (tooLate||touchedWall || madeIt)
			{
				setup();
			}
			else
			{
				var cp:Point = new Point(int(e.localX / view.blockSize), int(e.localY / view.blockSize));
				if (cp.equals(new Point()))
				{
					start();
				}
				//if (cp.equals(new Point(model.w - 1, model.h - 1))&&!gameOver)
				//{
					//stop();
				//}				
			}
	
			
			
		}
		private function handleMouseMove(e:MouseEvent):void
		{
			cursor.pos(e.localX,e.localY,this);
			var cp:Point = new Point(int(e.localX / view.blockSize), int(e.localY / view.blockSize));
			
			if (!cp.equals(currentPosition))
			{				
				previousPosition = currentPosition;
				currentPosition = cp;
				if (model.wallBetweenPoints(previousPosition, currentPosition))
				{					
					
					touchedWall = true;
					stop();
				}
			}
			if (cp.equals(new Point(model.path[model.path.length-1].x,model.path[model.path.length-1].y)))
			{
				madeIt = true;
				stop();
			}			
			//trace(cp);			
		}		
		public function stop():void
		{
			Mouse.show();
			cursor.visible = false;
			removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);			
			timer.reset();
			if (madeIt)
			{
				gameOverScreen.text = "well\ndone";
				gameOverScreen.visible = true;				
				//trace("made it");
			}
			if (touchedWall)
			{
				//trace("sjgksdjgk");
				gameOverScreen.text = "don't touch\nthe wall";
				gameOverScreen.visible = true;
			}
			if (tooLate)
			{
				//trace("sjgksdjgk");
				gameOverScreen.text = "you are\ntoo slow";
				gameOverScreen.visible = true;
			}			
		}
	}

}