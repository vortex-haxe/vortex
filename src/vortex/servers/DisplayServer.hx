package vortex.servers;

import vortex.servers.display.SDLBackend;
import vortex.servers.display.GLFWBackend;
import vortex.servers.display.NativeBackend;
import vortex.backend.Window;
import vortex.backend.interfaces.IServer;

enum DisplayBackend {
    SDL_BACKEND;

    // TODO: Implement this
    GLFW_BACKEND;

    // TODO: Implement this (this would be like, x11 on linux and win32 on windows btw)
    NATIVE_BACKEND;
}

class IDisplayBackendImpl {
	/**
	 * Initializes this display backend.
	 */
	public static function init():Void {}

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

class DisplayServer extends IServer {
    /**
     * TODO: Add description.
     */
    public static var backend:DisplayBackend = SDL_BACKEND;

	/**
	 * Initializes this display server.
	 */
	public static function init():Void {
        switch (backend) {
            case SDL_BACKEND: SDLBackend.init();
            case GLFW_BACKEND: GLFWBackend.init();
            case NATIVE_BACKEND: NativeBackend.init();
        }
    }

    /**
     * TODO: Add this description lol.
     */
    public static function createWindow(title:String, position:Vector2i, size:Vector2i) {
        switch (backend) {
            case SDL_BACKEND: SDLBackend.createWindow(title, position, size);
            case GLFW_BACKEND: GLFWBackend.createWindow(title, position, size);
            case NATIVE_BACKEND: NativeBackend.createWindow(title, position, size);
        }
    }

    /**
	 * Clears whatever is on-screen currently.
	 */
	public static function clear(window:Window):Void {
        switch (backend) {
            case SDL_BACKEND: SDLBackend.clear(window);
            case GLFW_BACKEND: GLFWBackend.clear(window);
            case NATIVE_BACKEND: NativeBackend.clear(window);
        }
    }

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:Window):Void {
        switch (backend) {
            case SDL_BACKEND: SDLBackend.present(window);
            case GLFW_BACKEND: GLFWBackend.present(window);
            case NATIVE_BACKEND: NativeBackend.present(window);
        }
    }

	/**
	 * Disposes of this display server and removes it's
	 * objects from memory.
	 */
	public static function dispose():Void {
        switch (backend) {
            case SDL_BACKEND: SDLBackend.dispose();
            case GLFW_BACKEND: GLFWBackend.dispose();
            case NATIVE_BACKEND: NativeBackend.dispose();
        }
    }
}
