package 
{
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Mouse;

	
	public class Main extends Sprite 
	{
		private var game:MazeGame;

		public function Main():void 
		{
			game = new MazeGame(18,12);
			//stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addChild(game);
			game.setup();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, kdown);
			
		
		}
		
	
		private function kdown(e:KeyboardEvent):void
		{
			if (e.keyCode == 32)
			{
				game.stop();
				game.setup();
			}
		}


	}
	
}