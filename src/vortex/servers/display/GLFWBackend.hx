package vortex.servers.display;

import vortex.servers.DisplayServer.IDisplayBackendImpl;

/**
 * TODO: Implement this.
 */
class GLFWBackend extends IDisplayBackendImpl {
    /**
	 * Initializes this display backend.
	 */
	public static function init():Void {
		Debug.warn("GLFW display backend is unimplemented!");
	}

    /**
     * TODO: Add this description lol.
     */
    public static function createWindow(title:String, position:Vector2i, size:Vector2i) {}

	/**
	 * Clears whatever is on-screen currently.
	 */
	public static function clear(window:Window):Void {}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:Window):Void {}

	/**
	 * Disposes of this display backend and removes it's
	 * objects from memory.
	 */
	public static function dispose():Void {}
}