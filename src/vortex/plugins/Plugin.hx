package vortex.plugins;

import vortex.backend.interfaces.IDisposable;

class Plugin implements IDisposable {
	/**
	 * Whether or not this object has been
	 * disposed.
	 */
	public var disposed:Bool;

	/**
	 * Disposes of this object and removes it's
	 * properties from memory.
	 */
	public function dispose():Void {
		
	}
}