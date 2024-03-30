package vortex.utils.engine;

import vortex.backend.interfaces.IDisposable;

/**
 * A simple reference based object.
 * 
 * Once the amount of references drops below 1,
 * this object will automatically be disposed.
 */
class RefCounted implements IDisposable {
	/**
	 * The amount of times this object has been referenced.
	 */
	public var references(default, null):Int = 0;

    /**
     * Whether or not this object has been
     * disposed.
     */
	public var disposed:Bool = false;

	/**
	 * Makes a new `RefCounted`.
	 */
	public function new() {}

	/**
	 * Increases the reference counter.
	 * 
	 * Do not use this unless you know what you're doing!!
	 */
	public function reference():Void {
		references++;
	}

	/**
	 * Decreases the reference counter.
	 * 
	 * Do not use this unless you know what you're doing!!
	 */
	public function unreference():Void {
		references--;
		if(references < 1 && !disposed)
			dispose();
	}

	/**
	 * Disposes of this object and removes it's
	 * properties from memory.
	 */
	public function dispose():Void {
		disposed = true;
	}
}