package vortex.resources;

import vortex.utils.engine.RefCounted;

/**
 * A simple resource class that automatically
 * disposes of itself when it isn't in use, similarly
 * to the `RefCounted` class.
 * 
 * Resources however can be set to persist and thus
 * not automatically dispose themselves.
 * 
 * You can still manually dispose of persisting resources.
 */
class Resource extends RefCounted {
	/**
	 * Whether or not this resource can automatically
	 * dispose of itself when not in use.
	 */
	public var persist:Bool = false;

	/**
	 * Decreases the reference counter.
	 * 
	 * Do not use this unless you know what you're doing!!
	 */
	override function unreference() {
		references--;
		if(references < 1 && !disposed && !persist)
			dispose();
	}
}