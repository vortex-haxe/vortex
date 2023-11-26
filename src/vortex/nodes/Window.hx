package vortex.nodes;

import sdl.SDL;
import sdl.Event;
import sdl.Window.WindowInitFlags;
import sdl.Window as NativeWindow;
import sdl.Window.WindowPos;
import sdl.Renderer.RenderFlags;
import sdl.Renderer as NativeRenderer;
import sdl.Texture as NativeTexture;
import vortex.core.Engine;
import vortex.math.Vector2;
import vortex.math.Rectangle;
import vortex.utils.Color;

@:allow(vortex.core.Engine)
@:allow(vortex.utils.Assets)
@:allow(vortex.nodes.display.Sprite)
@:allow(vortex.nodes.display.AnimatedSprite)
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
	 * The initial width and height of this window in pixels.
	 */
	public var initialSize:Vector2;

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
		initialSize = new Vector2(width, height);

		_nativeWindow = SDL.createWindow(title, x, y, width, height, RESIZABLE);
		_nativeRenderer = SDL.createRenderer(_nativeWindow, -1, ACCELERATED);
		_renderTexture = SDL.createTexture(_nativeRenderer, RGBX8888, RENDER_TARGET, width, height);

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
		switch (event.ref.type) {
			case WINDOWEVENT:
				switch (event.ref.window.event) {
					case RESIZED:
						final _size = SDL.getWindowSize(_nativeWindow);
						size.set(_size.x, _size.y);
						// TODO: add signal

					case MAXIMIZED:
						// TODO: add signal
						
					case RESTORED:
						// TODO: add signal

					default:
				}

			case QUIT:
				close();

			default:
		}
	}

	override function _draw() {
		SDL.setRenderDrawColor(_nativeRenderer, 0, 0, 0, 255);
		SDL.renderClear(_nativeRenderer);
		SDL.setRenderTarget(_nativeRenderer, _renderTexture);

		final clearColor:Color = Engine.projectSettings.engine.clear_color;
		SDL.setRenderDrawColor(_nativeRenderer, Std.int(clearColor.r * 255), Std.int(clearColor.g * 255), Std.int(clearColor.b * 255), 255);
		SDL.renderClear(_nativeRenderer);

		super._draw();

		SDL.resetRenderTarget(_nativeRenderer);

		_rect.set(0, 0, initialSize.x, initialSize.y);

		final initialRatio:Float = initialSize.x / initialSize.y;
		final windowRatio:Float = size.x / size.y;

		_rect2.width = (windowRatio > initialRatio) ? (size.y * initialRatio) : size.x;
		_rect2.height = (windowRatio < initialRatio) ? (size.x / initialRatio) : size.y;
		_rect2.x = (size.x - _rect2.width) * 0.5;
		_rect2.y = (size.y - _rect2.height) * 0.5;

		SDL.setTextureScaleMode(_renderTexture, LINEAR);
		SDL.renderCopyF(_nativeRenderer, _renderTexture, _rect._recti, _rect2._rect);

		SDL.renderPresent(_nativeRenderer);
	}

	/**
	 * Frees every property of this window from memory immediately.
	 * 
	 * Can cause crashes if this window is used after it is freed.
	 */
	override function free() {
		if (!_windows.contains(this))
			return;

		Engine.tree.root.removeChild(this);
		_windows.remove(this);

		SDL.destroyTexture(_renderTexture);
		SDL.destroyWindow(_nativeWindow);
		SDL.destroyRenderer(_nativeRenderer);

		position = null;
		size = null;
		initialSize = null;

		_nativeWindow = null;
		_nativeRenderer = null;
	}

	/**
	 * Immediately closes this window.
	 */
	public function close() {
		free();
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //
	private static var event:Event;
	private static var _windows:Array<Window> = [];
	private static var _rect:Rectangle = new Rectangle();
	private static var _rect2:Rectangle = new Rectangle();

	private var _nativeWindow:NativeWindow;
	private var _nativeRenderer:NativeRenderer;
	private var _renderTexture:NativeTexture;
}
