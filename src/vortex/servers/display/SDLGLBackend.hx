package vortex.servers.display;

import vortex.servers.DisplayServer.IWindowData;
import glad.Glad;
import vortex.backend.Application;
import vortex.utils.math.Vector2i;
import vortex.servers.DisplayServer.IDisplayBackendImpl;

import sdl.SDL;
import sdl.Types;

import sdl.SDL;
import sdl.Types.Event;
import sdl.Types.WindowInitFlags;
import sdl.Types.Window;
import sdl.Types.GlContext;

// this was going to be a typedef but you can't do that cuz weird hxcpp stuff :(
class SDLGLWindowData implements IWindowData {
	public var window:Any;
	public var context:Any;

	public function new(nativeWindow:Window, glContext:GlContext) {
		this.window = nativeWindow;
		this.context = glContext;
	}
}

class SDLGLBackend extends IDisplayBackendImpl {
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
    public static function createWindow(title:String, position:Vector2i, size:Vector2i):SDLGLWindowData {
		var wFlags:WindowInitFlags = OPENGL;
		if (Application.self.meta.window.resizable)
			wFlags |= RESIZABLE;

		if (Application.self.meta.window.borderless)
			wFlags |= BORDERLESS;

		var nativeWindow:Window = SDL.createWindow(title, position.x, position.y, size.x, size.y, wFlags);
		var glContext:GlContext = SDL.glCreateContext(nativeWindow);
		var returnData:SDLGLWindowData = new SDLGLWindowData(nativeWindow, glContext);
		
		SDL.glMakeCurrent(nativeWindow, glContext);
		SDL.glSetSwapInterval(0);

		Glad.loadGLLoader(untyped __cpp__("SDL_GL_GetProcAddress"));

		return returnData;
	}

	/**
     * TODO: Add this description lol.
     */
	public static function useWindowContext(window:SDLGLWindowData):Void {
		SDL.glMakeCurrent(window.window, window.context);
	}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:SDLGLWindowData):Void {
		SDL.glSwapWindow(window.window);
	}

	/**
	 * TODO: Add this description lol.
	 */
	public static function setWindowPosition(window:SDLGLWindowData, position:Vector2i):Void {
		SDL.setWindowPosition(window.window, position.x, position.y);
	}

	/**
	 * TODO: Add this description lol.
	 */
	public static function setWindowSize(window:SDLGLWindowData, size:Vector2i):Void {
		SDL.setWindowSize(window.window, size.x, size.y);
	}

	/**
	 * TODO: Add this description lol.
	 */
	public static function disposeWindow(window:SDLGLWindowData):Void {
		SDL.glDeleteContext(window.context);
		SDL.destroyWindow(window.window);
	}

	/**
	 * Disposes of this display backend and removes it's
	 * objects from memory.
	 */
	public static function dispose():Void {
		SDL.quit();
	}
}