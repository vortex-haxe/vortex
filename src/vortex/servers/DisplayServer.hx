package vortex.servers;

import vortex.servers.display.SDLGLBackend;
import vortex.servers.display.GLFWBackend;
import vortex.servers.display.NativeBackend;
import vortex.backend.Window;
import vortex.backend.interfaces.IServer;

enum DisplayBackend {
    SDL_GL_BACKEND;

    // TODO: Implement this
    GLFW_BACKEND;

    // TODO: Implement this (this would be like, x11 on linux and win32 on windows btw)
    NATIVE_BACKEND;
}

class IDisplayBackendImpl<NativeWindowType> {
	/**
	 * Initializes this display backend.
	 */
	public static function init():Void {}

    /**
     * TODO: Add this description lol.
     */
    public static function createWindow(title:String, position:Vector2i, size:Vector2i):NativeWindowType {}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:NativeWindowType):Void {}

    /**
	 * TODO: Add this description lol.
	 */
	public static function setWindowPosition(window:NativeWindowType, position:Vector2i):Void {}

    /**
	 * TODO: Add this description lol.
	 */
	public static function setWindowSize(window:NativeWindowType, size:Vector2i):Void {}

    /**
	 * TODO: Add this description lol.
	 */
	public static function disposeWindow(window:NativeWindowType):Void {}

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
            case GLFW_BACKEND: GLFWBackend.init();
            case NATIVE_BACKEND: NativeBackend.init();
        }
    }

    /**
     * TODO: Add this description lol.
     */
    public static function createWindow(title:String, position:Vector2i, size:Vector2i):Dynamic {
        switch (backend) {
            case SDL_GL_BACKEND: return SDLGLBackend.createWindow(title, position, size);
            case GLFW_BACKEND: return GLFWBackend.createWindow(title, position, size);
            case NATIVE_BACKEND: return NativeBackend.createWindow(title, position, size);
        }

        return null;
    }

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:Window):Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.present(window);
            case GLFW_BACKEND: GLFWBackend.present(window);
            case NATIVE_BACKEND: NativeBackend.present(window);
        }
    }

    /**
	 * TODO: Add this description lol.
	 */
	public static function setWindowPosition(window:Dynamic, position:Vector2i):Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.setWindowPosition(window, position);
            case GLFW_BACKEND: GLFWBackend.setWindowPosition(window, position);
            case NATIVE_BACKEND: NativeBackend.setWindowPosition(window, position);
        }
    }

    /**
	 * TODO: Add this description lol.
	 */
	public static function setWindowSize(window:Dynamic, size:Vector2i):Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.setWindowPosition(window, size);
            case GLFW_BACKEND: GLFWBackend.setWindowPosition(window, size);
            case NATIVE_BACKEND: NativeBackend.setWindowPosition(window, size);
        }
    }

    /**
	 * TODO: Add this description lol.
	 */
	public static function disposeWindow(window:NativeWindowType):Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.disposeWindow(window);
            case GLFW_BACKEND: GLFWBackend.disposeWindow(window);
            case NATIVE_BACKEND: NativeBackend.disposeWindow(window);
        }
    }

	/**
	 * Disposes of this display server and removes it's
	 * objects from memory.
	 */
	public static function dispose():Void {
        switch (backend) {
            case SDL_GL_BACKEND: SDLGLBackend.dispose();
            case GLFW_BACKEND: GLFWBackend.dispose();
            case NATIVE_BACKEND: NativeBackend.dispose();
        }
    }
}
