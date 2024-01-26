package vortex.servers;

import vortex.servers.display.SDLGLBackend;
import vortex.backend.interfaces.IServer;
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

class DisplayServer extends IServer {
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
     * TODO: Add this description lol.
     * TODO: Add flags property and shit for this: EX: uhh resizable idfk
     */
    public static function createWindow(title:String, position:Vector2i, size:Vector2i):IWindowData {
        return backend.createWindow(title, position, size);
    }

    /**
     * TODO: Add this description lol.
     */
    public static function useWindowContext(window:IWindowData):Void {
        backend.useWindowContext(window);
    }

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:IWindowData):Void {
        backend.present(window);
    }

    /**
	 * TODO: Add this description lol.
	 */
	public static function setWindowPosition(window:IWindowData, position:Vector2i):Void {
        backend.setWindowPosition(window, position);
    }

    /**
	 * TODO: Add this description lol.
	 */
	public static function setWindowSize(window:IWindowData, size:Vector2i):Void {
        backend.setWindowSize(window, size);
    }

    /**
	 * TODO: Add this description lol.
	 */
	public static function disposeWindow(window:IWindowData):Void {
        backend.disposeWindow(window);
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
