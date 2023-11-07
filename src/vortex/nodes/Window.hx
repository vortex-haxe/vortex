package vortex.nodes;

import sdl.SDL;
import sdl.Event;

import sdl.Window.WindowInitFlags;
import sdl.Window as NativeWindow;
import sdl.Window.WindowPos;

import sdl.Renderer.RenderFlags;
import sdl.Renderer as NativeRenderer;

import vortex.core.Engine;

import vortex.math.Vector2;

import vortex.utils.Color;

@:allow(vortex.core.Engine)
@:allow(vortex.nodes.display.Sprite)
@:allow(vortex.utils.Assets)
class Window extends Node {
	/**
	 * The X and Y coordinates of this window in pixels.
	 * 
	 * Starts from the top-left corner of the screen.
	 */
	public var position:Vector2;

	/**
	 * The width and height of this window in pixels.
	 */
	public var size:Vector2;

	/**
	 * The color that this window renders
	 * when it isn't fully covered up by nodes.
	 */
	public var clearColor:Color = new Color().copyFrom(Engine.projectSettings.engine.clear_color);

	/**
	 * Returns a new `Window`.
	 * 
	 * @param title   The text to display on this window's title bar.
	 * @param x       The X coord of this window in pixels. (Centered by default)
	 * @param y       The Y coord of this window in pixels. (Centered by default)
	 * @param width   The width of this window in pixels.
	 * @param height  The height of this window in pixels.
	 */
	public function new(title:String = "Vortex", x:Int = WindowPos.CENTERED, y:Int = WindowPos.CENTERED, width:Int = 100, height:Int = 100) {
		super();
		position = new Vector2(x, y);
		size = new Vector2(width, height);

		_nativeWindow = SDL.createWindow(title, x, y, width, height, RESIZABLE);
		_nativeRenderer = SDL.createRenderer(_nativeWindow, -1, ACCELERATED);

		Engine.tree.root.addChild(this);
		_windows.push(this);
	}

	/**
	 * Updates this window.
	 * 
	 * @param delta  The time between the last and current frame in seconds.
	 */
	override function update(delta:Float) {
		SDL.pollEvent(event);
		switch(event.ref.type) {
			case QUIT:
				close();
			
			default:
		}
	}

	override function _draw() {
		SDL.setRenderDrawColor(_nativeRenderer, Std.int(clearColor.r * 255), Std.int(clearColor.g * 255), Std.int(clearColor.b * 255), Std.int(clearColor.a * 255));
		SDL.renderClear(_nativeRenderer);
		super._draw();
		SDL.renderPresent(_nativeRenderer);
	}

	/**
	 * Frees every property of this window from memory immediately.
	 * 
	 * Can cause crashes if this window is used after it is freed.
	 */
	override function free() {
		if(!_windows.contains(this))
			return;

		Engine.tree.root.removeChild(this);
		_windows.remove(this);
		
		SDL.destroyWindow(_nativeWindow);
		SDL.destroyRenderer(_nativeRenderer);
		_nativeWindow = null;
		_nativeRenderer = null;
		clearColor = null;
	}

	/**
	 * Immediately closes this window.
	 */
	public function close() {
		free();
	}

	//##==-------------------------------------------------==##//
	//##==----- Don't modify these parts below unless -----==##//
	//##==-- you are here to fix a bug or add a feature. --==##//
	//##==-------------------------------------------------==##//

	private static var event:Event;

	private static var _windows:Array<Window> = [];
	private var _nativeWindow:NativeWindow;
	private var _nativeRenderer:NativeRenderer;
}