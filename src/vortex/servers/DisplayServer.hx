package vortex.servers;

import vortex.servers.display.SDLGLBackend;
import vortex.backend.interfaces.IServer;
import vortex.utils.math.Vector2i;

interface IWindowData {
    public var window:Any;
	public var context:Any;
}

enum DisplayBackend {
    SDL_GL_BACKEND;

    // // TODO: Implement this
    // GLFW_BACKEND;

    // // TODO: Implement this (this would be like, x11 on linux and win32 on windows btw)
    // NATIVE_BACKEND;
}

class IDisplayBackendImpl {
	/**
	 * Initializes this display backend.
	 */
	public static function init():Void {}

    /**
     * TODO: Add this description lol.
     */
    public static function createWindow(title:String, position:Vector2i, size:Vector2i):Any {
        return null;
    }

    /**
     * TODO: Add this description lol.
     */
    public static function useWindowContext(window:Any):Void {}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:Any):Void {}

    /**
	 * TODO: Add this description lol.
	 */
	public static function setWindowPosition(window:Any, position:Vector2i):Void {}

    /**
	 * TODO: Add this description lol.
	 */
	public static function setWindowSize(window:Any, size:Vector2i):Void {}

    /**
	 * TODO: Add this description lol.
	 */
	public static function disposeWindow(window:Any):Void {}

	/**
	 * Disposes of this display backend and removes it's
	 * objects from memory.
	 */
	public static function dispose():Void {}
}

class DisplayServer extends IServer {
    /**
     * TODO: Add description.
     */
    public static var backend:DisplayBackend = SDL_GL_BACKEND;

	/**
	 * Initializes this display server.
	 */
	public static function init():Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.init();
        }
    }

    /**
     * TODO: Add this description lol.
     * TODO: Add flags property and shit for this: EX: uhh resizable idfk
     */
    public static function createWindow(title:String, position:Vector2i, size:Vector2i):IWindowData {
        switch (backend) {
            case SDL_GL_BACKEND: return SDLGLBackend.createWindow(title, position, size);
        }

        return null;
    }

    /**
     * TODO: Add this description lol.
     */
    public static function useWindowContext(window:Any):Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.useWindowContext(cast window);
        }
    }

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:IWindowData):Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.present(cast window);
        }
    }

    /**
	 * TODO: Add this description lol.
	 */
	public static function setWindowPosition(window:IWindowData, position:Vector2i):Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.setWindowPosition(cast window, position);
        }
    }

    /**
	 * TODO: Add this description lol.
	 */
	public static function setWindowSize(window:IWindowData, size:Vector2i):Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.setWindowPosition(cast window, size);
        }
    }

    /**
	 * TODO: Add this description lol.
	 */
	public static function disposeWindow(window:IWindowData):Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.disposeWindow(cast window);
        }
    }

	/**
	 * Disposes of this display server and removes it's
	 * objects from memory.
	 */
	public static function dispose():Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.dispose();
        }
    }
}
