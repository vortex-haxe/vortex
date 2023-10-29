package lunar.display;

import lunar.math.Vector2;
import lunar.core.Basic;

/**
 * An object with basic 2D capabilities.
 */
class Object extends Basic {
	/**
	 * The X and Y position of this object in pixels.
	 */
	public var position:Vector2;

	public function new(x:Float = 0, y:Float = 0) {
		super();
		position = new Vector2(x, y);
	}
}