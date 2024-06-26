package vortex.servers.display;

import glad.Glad;

import sdl.SDL;
import sdl.Types;

import sdl.SDL;
import sdl.Types.SDLEvent;
import sdl.Types.SDLWindowInitFlags;
import sdl.Types.SDLWindow;
import sdl.Types.SDLGlContext;

import vortex.backend.Application;
import vortex.servers.DisplayServer.DisplayBackend;
import vortex.servers.DisplayServer.IWindowData;
import vortex.utils.math.Vector2i;

// this was going to be a typedef but you can't do that cuz weird hxcpp stuff :(
class SDLGLWindowData implements IWindowData {
	public var window:Any;
	public var context:Any;

	public function new(nativeWindow:SDLWindow, glContext:SDLGlContext) {
		this.window = nativeWindow;
		this.context = glContext;
	}
}

class SDLGLBackend extends DisplayBackend {
    /**
	 * Initializes this display backend.
	 */
	override function init():Void {
        if (SDL.init(VIDEO | EVENTS) < 0) {
			Debug.error(SDL.getError());
			return;
		}
    }

    /**
     * Creates a window with SDL and initializes an OpenGL Core 3.3 context with it.
     */
    override function createWindow(title:String, position:Vector2i, size:Vector2i):IWindowData {
		var wFlags:SDLWindowInitFlags = OPENGL;
		if (Application.self.meta.window.resizable)
			wFlags |= RESIZABLE;

		if (Application.self.meta.window.borderless)
			wFlags |= BORDERLESS;

		var nativeWindow:SDLWindow = SDL.createWindow(title, position.x, position.y, size.x, size.y, wFlags);
		var glContext:SDLGlContext = SDL.glCreateContext(nativeWindow);
		var returnData:SDLGLWindowData = new SDLGLWindowData(nativeWindow, glContext);
		
		SDL.glMakeCurrent(nativeWindow, glContext);
		SDL.glSetSwapInterval(0);

		Glad.loadGLLoader(untyped __cpp__("SDL_GL_GetProcAddress"));

		return returnData;
	}

	/**
     * TODO: Add this description lol.
     */
	override function useWindowContext(window:IWindowData):Void {
		SDL.glMakeCurrent(window.window, window.context);
	}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	override function present(window:IWindowData):Void {
		SDL.glSwapWindow(window.window);
	}

	/**
	 * TODO: Add this description lol.
	 */
	override function setWindowPosition(window:IWindowData, position:Vector2i):Void {
		SDL.setWindowPosition(window.window, position.x, position.y);
	}

	/**
	 * TODO: Add this description lol.
	 */
	override function setWindowSize(window:IWindowData, size:Vector2i):Void {
		SDL.setWindowSize(window.window, size.x, size.y);
	}

	/**
	 * TODO: Add this description lol.
	 */
	override function disposeWindow(window:IWindowData):Void {
		SDL.glDeleteContext(window.context);
		SDL.destroyWindow(window.window);
	}

	/**
	 * Disposes of this display backend and removes it's
	 * objects from memory.
	 */
	override function dispose():Void {
		SDL.quit();
	}
}