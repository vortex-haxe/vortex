package vortex.servers;

import vortex.servers.display.SDLGLBackend;
import vortex.utils.math.Vector2i;

interface IWindowData {
    public var window:Any;
	public var context:Any;
}

class DisplayBackend {
    public function new() {}

	/**
	 * Initializes this display backend.
	 */
	public function init():Void {}

    /**
     * TODO: Add this description lol.
     */
    public function createWindow(title:String, position:Vector2i, size:Vector2i):IWindowData {
        return null;
    }

    /**
     * TODO: Add this description lol.
     */
    public function useWindowContext(window:IWindowData):Void {}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public function present(window:IWindowData):Void {}

    /**
	 * TODO: Add this description lol.
	 */
	public function setWindowPosition(window:IWindowData, position:Vector2i):Void {}

    /**
	 * TODO: Add this description lol.
	 */
	public function setWindowSize(window:IWindowData, size:Vector2i):Void {}

    /**
	 * TODO: Add this description lol.
	 */
	public function disposeWindow(window:IWindowData):Void {}

	/**
	 * Disposes of this display backend and removes it's
	 * objects from memory.
	 */
	public function dispose():Void {}
}

class DisplayServer {
    /**
     * TODO: Add description.
     */
    public static var backend:DisplayBackend = new SDLGLBackend();

	/**
	 * Initializes this display server.
	 */
	public static function init():Void {
        backend.init();
    }

	/**
	 * Disposes of this display server and removes it's
	 * objects from memory.
	 */
	public static function dispose():Void {
        backend.dispose();
        backend = null;
    }
}
