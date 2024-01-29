package vortex.servers.display;

import sdl.SDL;
import sdl.Types;

import sdl.SDL;
import sdl.Types.Event;
import sdl.Types.WindowInitFlags;
import sdl.Types.Window;

import vortex.backend.Application;
import vortex.servers.DisplayServer.DisplayBackend;
import vortex.servers.DisplayServer.IWindowData;
import vortex.utils.math.Vector2i;

// this was going to be a typedef but you can't do that cuz weird hxcpp stuff :(
class SDLWindowData implements IWindowData {
	public var window:Any;
	public var context:Any;

	public function new(nativeWindow:Window, sdlRenderer:Renderer) {
		this.window = nativeWindow;
		this.context = sdlRenderer;
	}
}

class SDLBackend extends DisplayBackend {
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
		var wFlags:WindowInitFlags = SHOWN;
		if (Application.self.meta.window.resizable)
			wFlags |= RESIZABLE;

		if (Application.self.meta.window.borderless)
			wFlags |= BORDERLESS;

		var nativeWindow:Window = SDL.createWindow(title, position.x, position.y, size.x, size.y, wFlags);
		var sdlRenderer:Renderer = SDL.createRenderer(nativeWindow, -1, ACCELERATED);

		if (sdlRenderer == null) {
			Debug.warn("SDL_CreateRenderer couldn't find accelerated graphics. Falling back to software rendering. If this doesn't work something is REALLY bad.");

			// try software as a last resort fallback
			sdlRenderer = SDL.createRenderer(nativeWindow, -1, SOFTWARE);
		}

		return new SDLWindowData(nativeWindow, sdlRenderer);
	}

	/**
     * TODO: Add this description lol.
     */
	override function useWindowContext(window:IWindowData):Void {
		// Nothing
	}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	override function present(window:IWindowData):Void {
		SDL.renderPresent(window.context);
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
		SDL.destroyRenderer(window.context);
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