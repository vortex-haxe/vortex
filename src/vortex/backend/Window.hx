package vortex.backend;

import vortex.servers.DisplayServer;
import vortex.servers.DisplayServer.IWindowData;
import vortex.utils.generic.Signal;
import cpp.Pointer;
import cpp.UInt32;

import sdl.SDL;
import sdl.Types.Event;
import sdl.Types.WindowInitFlags;
import sdl.Types.Window as NativeWindow;
import sdl.Types.GlContext;

import glad.Glad;

import vortex.backend.interfaces.IDisposable;

import vortex.servers.RenderingServer;
import vortex.servers.rendering.OpenGLBackend;

import vortex.nodes.Node;

import vortex.resources.Shader;

import vortex.utils.math.Vector2i;
import vortex.utils.math.Rectanglei;
import vortex.utils.math.Matrix4x4;

@:access(vortex.resources.Shader)
class Window extends Node {
	/**
	 * The X and Y coordinates of this window
	 * on the screen.
	 */
	public var position:Vector2i;

	/**
	 * The width and height of this window
	 * in pixels.
	 */
	public var size:Vector2i;

	/**
	 * The initial width and height of this window
	 * in pixels.
	 */
	public var initialSize(default, null):Vector2i;

	/**
	 * The signal that gets emitted when the window is closed.
	 */
	public var onClose:Signal<Void->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window is minimized.
	 */
	public var onMinimize:Signal<Void->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window is maximized.
	 */
	public var onMaximize:Signal<Void->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window is restored.
	 */
	public var onRestore:Signal<Void->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window is refocused.
	 */
	public var onFocusGain:Signal<Void->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window is unfocused.
	 */
	public var onFocusLost:Signal<Void->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window is resized.
	 */
	public var onResize:Signal<Int->Int->Void> = new Signal();

	/**
	 * Makes a new `Window`.
	 */
	public function new(title:String, position:Vector2i, size:Vector2i) {
		super();
		@:bypassAccessor this.position = position;
		@:bypassAccessor this.size = size;
		initialSize = new Vector2i().copyFrom(size);

		_nativeWindow = DisplayServer.createWindow(title, position, size);

		@:privateAccess {
			this.position._onChange = (x:Int, y:Int) -> {
				DisplayServer.setWindowPosition(_nativeWindow, new Vector2i(x, y));
			};
			this.size._onChange = (x:Int, y:Int) -> {
				DisplayServer.setWindowSize(_nativeWindow, new Vector2i(x, y));
			};
		}

		_children.push(null); // forcefully make room for current scene
		Application.self.windows.push(this);
	}

	override function tick(delta:Float) {
		SDL.pollEvent(_ev);
		switch(_ev.ref.type) {
			case WINDOWEVENT:
				switch(_ev.ref.window.event) {
					case CLOSE:
						onClose.emit();
						dispose();
					
					case MINIMIZED:
						onMinimize.emit();
						
					case MAXIMIZED:
						onMaximize.emit();

					case RESTORED:
						onRestore.emit();

					case FOCUS_GAINED:
						onFocusGain.emit();

					case FOCUS_LOST:
						onFocusLost.emit();

					case RESIZED:
						@:privateAccess {
							final _ooc = size._onChange;
							size._onChange = null;
							size.set(_ev.ref.window.data1, _ev.ref.window.data2);
							size._onChange = _ooc;
						}
						final initialRatio:Float = initialSize.x / initialSize.y;
						final windowRatio:Float = size.x / size.y;

						_recti.width = (windowRatio > initialRatio) ? Math.floor(size.y * initialRatio) : size.x;
						_recti.height = (windowRatio < initialRatio) ? Math.floor(size.x / initialRatio) : size.y;
						_recti.x = Math.floor((size.x - _recti.width) * 0.5);
						_recti.y = Math.floor((size.y - _recti.height) * 0.5);
						
						RenderingServer.setViewportRect(_recti);
						onResize.emit(_ev.ref.window.data1, _ev.ref.window.data2);

					default:
				}

			default:
		}
	}

	/**
	 * Disposes of this window and removes it's
	 * properties from memory.
	 */
	override function dispose():Void {
		if(!disposed) {
			Application.self.windows.remove(this);
			DisplayServer.disposeWindow(_nativeWindow);
		}
		disposed = true;
	}

	/**
	 * A shortcut function to `dispose()`.
	 */
	public inline function close():Void {
		dispose();
	}

	// ------------------ //
	// Internal Variables //
	// ------------------ //
	// SDL
	private static var _ev:Event;

	// rendering
	private var _nativeWindow:IWindowData;

	// Vortex
	private static var _recti:Rectanglei = new Rectanglei();
}