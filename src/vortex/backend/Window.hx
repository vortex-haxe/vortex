package vortex.backend;

import cpp.Pointer;
import cpp.UInt32;

import sdl.Types.WindowInitFlags;
import sdl.SDL;
import sdl.Types.Window as NativeWindow;
import sdl.Types.GlContext;

import glad.Glad;

import vortex.backend.interfaces.IDisposable;
import vortex.servers.rendering.OpenGLBackend;
import vortex.utils.math.Vector2i;
import vortex.utils.math.Matrix4x4;

class Window implements IDisposable {
	/**
	 * Whether or not this object has been
	 * disposed.
	 */
	public var disposed:Bool = false;

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
	 * Makes a new `Window`.
	 */
	public function new(title:String, position:Vector2i, size:Vector2i) {
		@:bypassAccessor this.position = position;
		@:bypassAccessor this.size = size;
		initialSize = new Vector2i().copyFrom(size);

		var wFlags:WindowInitFlags = OPENGL;
		if(Application.self.meta.window.resizable)
			wFlags |= RESIZABLE;

		_nativeWindow = SDL.createWindow(title, position.x, position.y, size.x, size.y, wFlags);
		_glContext = SDL.glCreateContext(_nativeWindow);
		
		SDL.glMakeCurrent(_nativeWindow, _glContext);
		SDL.glSetSwapInterval(0);

		Glad.loadGLLoader(untyped __cpp__("SDL_GL_GetProcAddress"));

		Glad.genVertexArrays(1, Pointer.addressOf(_VAO));
		Glad.bindVertexArray(_VAO);

		Glad.genBuffers(1, Pointer.addressOf(_VBO));
		Glad.bindBuffer(Glad.ARRAY_BUFFER, _VBO);
		Glad.bufferFloatArray(Glad.ELEMENT_ARRAY_BUFFER, OpenGLBackend.VERTICES, Glad.STATIC_DRAW, 16);

        Glad.genBuffers(1, Pointer.addressOf(_EBO));

        Glad.bindBuffer(Glad.ELEMENT_ARRAY_BUFFER, _EBO);
        Glad.bufferIntArray(Glad.ELEMENT_ARRAY_BUFFER, OpenGLBackend.INDICES, Glad.STATIC_DRAW, 6);

		_projection = Matrix4x4.ortho(0, initialSize.x, initialSize.y, 0, -1, 1);

		// TODO: shader class

		@:privateAccess {
			this.position._onChange = (x:Int, y:Int) -> {
				SDL.setWindowPosition(_nativeWindow, x, y);
			};
			this.size._onChange = (x:Int, y:Int) -> {
				SDL.setWindowSize(_nativeWindow, x, y);
			};
		}
		Application.self.windows.push(this);
	}

	 /**
	  * Disposes of this object and removes it's
	  * properties from memory.
	  */
	public function dispose():Void {
		if(disposed == (disposed = true))
			return;

		Application.self.windows.remove(this);
		SDL.glDeleteContext(_glContext);
		SDL.destroyWindow(_nativeWindow);
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
	private var _nativeWindow:NativeWindow;

	// GL
	private var _glContext:GlContext;
	private var _VAO:UInt32;
	private var _VBO:UInt32;
	private var _EBO:UInt32;
	private var _projection:Matrix4x4;
}