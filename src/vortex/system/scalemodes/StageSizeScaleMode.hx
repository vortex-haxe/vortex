package vortex.system.scalemodes;

/**
 * `StageSizeScaleMode` is a scaling mode which extends the game's
 * size to match that of the window, this means entities further away
 * will get cut-off on smaller window sizes, and that their scale and position
 * will always remain the same.
 */
class StageSizeScaleMode extends BaseScaleMode {
	override function onMeasure(width:Int, height:Int):Void {
		GlobalCtx.width = width;
		GlobalCtx.height = height;

		scale.set(1, 1);
		GlobalCtx.game.x = GlobalCtx.game.y = 0;

		if(GlobalCtx.camera != null)
			GlobalCtx.camera.setSize(width, height);
	}
}
