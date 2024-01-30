package vortex.backend;

import vortex.servers.DisplayServer;
import vortex.servers.DisplayServer.IWindowData;

import sdl.SDL;
import sdl.Types.Event;
import sdl.Types.MouseButton;

import vortex.servers.RenderingServer;

import vortex.nodes.Node;

import vortex.utils.generic.Signal;
import vortex.utils.math.Vector2i;
import vortex.utils.math.Rectanglei;

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
	 * 
	 * Parameters are:
	 * - New Window Width
	 * - New Window Height
	 */
	public var onResize:Signal<Int->Int->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window recieves a key press.
	 * 
	 * Parameters are:
	 * - Key Code
	 * - Key Modifier
	 */
	public var onKeyPress:Signal<Int->Int->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window recieves a key release.
	 * 
	 * Parameters are:
	 * - Key Code
	 * - Key Modifier
	 */
	public var onKeyRelease:Signal<Int->Int->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window recieves a mouse click.
	 * 
	 * Parameters are:
	 * - Mouse Button
	 */
	public var onMouseClick:Signal<MouseButton->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window recieves a mouse release.
	 * 
	 * Parameters are:
	 * - Mouse Button
	 */
	public var onMouseRelease:Signal<MouseButton->Void> = new Signal();

	/**
	 * The signal that gets emitted when the window recieves a mouse movement.
	 * 
	 * Parameters are:
	 * - Mouse Button
	 * - Mouse X
	 * - Mouse Y
	 * - Mouse X (Relative)
	 * - Mouse Y (Relative)
	 */
	public var onMouseMove:Signal<MouseButton->Int->Int->Int->Int->Void> = new Signal();

	/**
	 * Makes a new `Window`.
	 */
	public function new(title:String, position:Vector2i, size:Vector2i) {
		super();
		@:bypassAccessor this.position = position;
		@:bypassAccessor this.size = size;
		initialSize = new Vector2i().copyFrom(size);

		_nativeWindow = DisplayServer.backend.createWindow(title, position, size);

		@:privateAccess {
			this.position._onChange = (x:Int, y:Int) -> {
				DisplayServer.backend.setWindowPosition(_nativeWindow, new Vector2i(x, y));
			};
			this.size._onChange = (x:Int, y:Int) -> {
				DisplayServer.backend.setWindowSize(_nativeWindow, new Vector2i(x, y));
			};
		}

		_children.push(null); // forcefully make room for current scene
		Application.self.windows.push(this);
	}

	private function pollEvents() {
		while(SDL.pollEvent(_ev) != 0) {
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
							
							RenderingServer.backend.setViewportRect(_recti);
							onResize.emit(_ev.ref.window.data1, _ev.ref.window.data2);
	
						default:
					}
	
				case KEYDOWN:
					onKeyPress.emit(_ev.ref.key.keysym.sym, _ev.ref.key.keysym.mod);
	
				case KEYUP:
					onKeyRelease.emit(_ev.ref.key.keysym.sym, _ev.ref.key.keysym.mod);
	
				case MOUSEMOTION:
					onMouseMove.emit(_ev.ref.motion.state, _ev.ref.motion.x, _ev.ref.motion.y, _ev.ref.motion.xRel, _ev.ref.motion.yRel);
	
				case MOUSEBUTTONDOWN:
					onMouseClick.emit(_ev.ref.button.button);
	
				case MOUSEBUTTONUP:
					onMouseRelease.emit(_ev.ref.button.button);
	
				default:
			}
		}
	}

	/**
	 * Disposes of this window and removes it's
	 * properties from memory.
	 */
	override function dispose():Void {
		if(!disposed) {
			Application.self.windows.remove(this);
			DisplayServer.backend.disposeWindow(_nativeWindow);
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