package vortex.servers.rendering;

import cpp.UInt32;
import cpp.Float32;

import glad.Glad;

import vortex.servers.RenderingServer.IRenderingBackendImpl;
import vortex.utils.math.Rectanglei;

/**
 * The OpenGL rendering backend.
 */
class OpenGLBackend extends IRenderingBackendImpl {
	public static final VERTICES:Array<Float32> = [
		// positions   // texture coords
		0.0,  0.0,     0.0, 0.0,   // top left
		0.0,  1.0,     0.0, 1.0,   // bottom left
		1.0,  1.0,     1.0, 1.0,   // bottom right
		1.0,  0.0,     1.0, 0.0    // top right 
	];

	public static final INDICES:Array<UInt32> = [
		// note that we start from 0!
		0, 1, 3, // first triangle
		1, 2, 3  // second triangle
	];

	/**
	 * Initializes this rendering backend.
	 */
	public static function init():Void {
		
	}

	/**
	 * Sets the values of the current viewport rectangle.
	 */
	public static function setViewportRect(rect:Rectanglei):Void {
		Glad.viewport(rect.x, rect.y, rect.width, rect.height);
	}

	/**
	 * Clears whatever is on-screen currently.
	 */
	public static function clear():Void {

	}
 
	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present():Void {

	}

	/**
	 * Disposes of this rendering backend and removes it's
	 * properties from memory.
	 */
	public static function dispose():Void {

	}
}