package vortex.servers.display;

import vortex.utils.math.Vector2i;
import vortex.servers.DisplayServer.IDisplayBackendImpl;

import sdl.SDL;
import sdl.Types;

import sdl.SDL;
import sdl.Types.Event;
import sdl.Types.WindowInitFlags;
import sdl.Types.Window;
import sdl.Types.GlContext;

typedef WindowData = {
	var nativeWindow:Window;
	var glContext:GlContext;
}

class SDLGLBackend extends IDisplayBackendImpl<WindowData> {
    /**
	 * Initializes this display backend.
	 */
	public static function init():Void {
        if (SDL.init(VIDEO | EVENTS) < 0) {
			Debug.error(SDL.getError());
			return;
		}
    }

    /**
     * Creates a window with SDL and initializes an OpenGL Core 3.3 context with it.
     */
    public static function createWindow(title:String, position:Vector2i, size:Vector2i):WindowData {
		var wFlags:WindowInitFlags = OPENGL;
		if (Application.self.meta.window.resizable)
			wFlags |= RESIZABLE;

		if (Application.self.meta.window.borderless)
			wFlags |= BORDERLESS;

		var nativeWindow:Window = SDL.createWindow(title, position.x, position.y, size.x, size.y, wFlags);
		var glContext:GlContext = SDL.glCreateContext(nativeWindow);
		var returnData:WindowData = {
			nativeWindow: nativeWindow,
			glContext: glContext
		};
		
		SDL.glMakeCurrent(nativeWindow, glContext);
		SDL.glSetSwapInterval(0);

		Glad.loadGLLoader(untyped __cpp__("SDL_GL_GetProcAddress"));

		return returnData;
	}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:WindowData):Void {
		SDL.glSwapWindow(window.nativeWindow);
	}

	/**
	 * TODO: Add this description lol.
	 */
	public static function setWindowPosition(window:WindowData, position:Vector2i):Void {
		SDL.setWindowPosition(window.nativeWindow, position.x, position.y);
	}

	/**
	 * TODO: Add this description lol.
	 */
	public static function setWindowSize(window:WindowData, size:Vector2i):Void {
		SDL.setWindowSize(window.nativeWindow, size.x, size.y);
	}

	/**
	 * TODO: Add this description lol.
	 */
	public static function disposeWindow(window:WindowData):Void {
		SDL.glDeleteContext(window.glContext);
		SDL.destroyWindow(window.nativeWindow);
	}

	/**
	 * Disposes of this display backend and removes it's
	 * objects from memory.
	 */
	public static function dispose():Void {
		SDL.quit();
	}
}