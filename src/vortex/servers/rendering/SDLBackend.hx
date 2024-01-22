package vortex.servers.rendering;

import vortex.backend.Window;
import vortex.servers.RenderingServer.IRenderingBackendImpl;
import vortex.utils.math.Rectanglei;

/**
 * The SDL rendering backend.
 * 
 * TODO: implement me!
 */
class SDLBackend extends IRenderingBackendImpl {
	/**
	 * Initializes this rendering backend.
	 */
	public static function init():Void {
		Debug.warn("SDL rendering backend is unimplemented!");
	}

	/**
	 * Sets the values of the current viewport rectangle.
	 */
	public static function setViewportRect(rect:Rectanglei):Void {
		
	}

	/**
	 * Clears whatever is on-screen currently.
	 */
	public static function clear(window:Window):Void {

	}
 
	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:Window):Void {

	}

	/**
	 * Disposes of this rendering backend and removes it's
	 * properties from memory.
	 */
	public static function dispose():Void {

	}
}