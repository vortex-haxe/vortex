package vortex.nodes;

import vortex.backend.interfaces.IDisposable;

/**
 * An extremely basic game object used for internal classes.
 * 
 * It is recommended for you to extend `Node` instead!
 */
class Object implements IDisposable {
    /**
     * Whether or not this object has been
     * disposed.
     */
	public var disposed:Bool = false;

	/**
	 * Makes a new `Object`.
	 */
	public function new() {}

	/**
	 * Called when this object is ticking/updating internally.
	 * 
	 * Update your own stuff in here if you need to,
	 * just make sure to call `super.tick(delta)` before-hand!
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	public function tick(delta:Float):Void {}

	/**
	 * Called when this object is drawing internally.
	 * 
	 * Draw your own stuff in here if you need to,
	 * just make sure to call `super.draw()` before-hand!
	 */
	public function draw():Void {}

	/**
	 * Disposes of this object and removes it's
	 * properties from memory.
	 */
	public function dispose():Void {
		disposed = true;
	}
}