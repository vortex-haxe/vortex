package vortex.system.scalemodes;

import vortex.math.Point;
import vortex.utilities.DestroyUtil;
import vortex.utilities.HorizontalAlign;
import vortex.utilities.VerticalAlign;

/**
 * The base class from which all other scale modes extend from.
 * You can implement your own scale mode by extending this class and overriding the appropriate methods.
 * 
 * The default behavior of `BaseScaleMode` matches that of `FillScaleMode`.
 */
class BaseScaleMode implements IDestroyable {
	public var gameSize(default, null):Point;
	public var deviceSize(default, null):Point;
    public var scale(default, null):Point;
    public var offset(default, null):Point;

	public var horizontalAlign(default, set):HorizontalAlign = CENTER;
	public var verticalAlign(default, set):VerticalAlign = CENTER;

	public function new() {
		gameSize = Point.get();
		deviceSize = Point.get();
		scale = Point.get();
		offset = Point.get();
	}

	public function updateGameSize(width:Int, height:Int):Void {
		gameSize.set(width, height);
	}

	public function updateDeviceSize(width:Int, height:Int):Void {
		deviceSize.set(width, height);
	}

	public function onMeasure(width:Int, height:Int):Void {
		updateGameSize(width, height);
		updateDeviceSize(width, height);
        updateScaleOffset();
	}

	public function destroy():Void {
		gameSize = DestroyUtil.put(gameSize);
		deviceSize = DestroyUtil.put(deviceSize);
		scale = DestroyUtil.put(scale);
		offset = DestroyUtil.put(offset);
	}

	// --------------- //
	// [ Private API ] //
	// --------------- //

    private function updateScaleOffset():Void {
		scale.x = gameSize.x / GlobalCtx.width;
		scale.y = gameSize.y / GlobalCtx.height;
		updateOffsetX();
		updateOffsetY();
	}

	private function updateOffsetX():Void {
		offset.x = switch (horizontalAlign) {
			case HorizontalAlign.LEFT:
				0;
			case HorizontalAlign.CENTER:
				Math.ceil((deviceSize.x - gameSize.x) * 0.5);
			case HorizontalAlign.RIGHT:
				deviceSize.x - gameSize.x;
		}
	}

	private function updateOffsetY():Void {
		offset.y = switch (verticalAlign) {
			case VerticalAlign.TOP:
				0;
			case VerticalAlign.CENTER:
				Math.ceil((deviceSize.y - gameSize.y) * 0.5);
			case VerticalAlign.BOTTOM:
				deviceSize.y - gameSize.y;
		}
	}

	@:noCompletion
	private function set_horizontalAlign(value:HorizontalAlign):HorizontalAlign {
		horizontalAlign = value;
		if (offset != null)
			updateOffsetX();

		return value;
	}

	@:noCompletion
	private function set_verticalAlign(value:VerticalAlign):VerticalAlign {
		verticalAlign = value;
		if (offset != null)
			updateOffsetY();

		return value;
	}
}
