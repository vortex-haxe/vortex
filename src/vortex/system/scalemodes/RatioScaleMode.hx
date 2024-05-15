package vortex.system.scalemodes;

/**
 * `RatioScaleMode` is a scaling mode which maintains the game's aspect ratio.
 * When you shrink or grow the window, the width and height of the game will adjust,
 * either scaling the game or adding black bars as needed.
 *
 * This is the default scaling mode used by Vortex.
 */
class RatioScaleMode extends BaseScaleMode {
	var fillScreen:Bool;

	/**
	 * @param fillScreen Whether to cut the excess side to fill the
	 * screen or always display everything.
	 */
	public function new(fillScreen:Bool = false) {
		super();
		this.fillScreen = fillScreen;
	}

	override function updateGameSize(width:Int, height:Int):Void {
		var ratio:Float = GlobalCtx.width / GlobalCtx.height;
		var realRatio:Float = width / height;

		var scaleY:Bool = realRatio < ratio;
		if (fillScreen)
			scaleY = !scaleY;

		if (scaleY) {
			gameSize.x = width;
			gameSize.y = Math.floor(gameSize.x / ratio);
		} else {
			gameSize.y = height;
			gameSize.x = Math.floor(gameSize.y * ratio);
		}
	}
}
