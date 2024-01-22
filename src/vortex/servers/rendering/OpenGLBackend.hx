package vortex.servers.rendering;

import sdl.SDL;
import cpp.UInt32;
import cpp.Float32;

import glad.Glad;

import vortex.backend.Application;
import vortex.backend.Window;

import vortex.servers.RenderingServer.IRenderingBackendImpl;

import vortex.resources.Shader;

import vortex.utils.math.Vector3;
import vortex.utils.math.Rectanglei;
import vortex.utils.math.Matrix4x4;

/**
 * The OpenGL rendering backend.
 */
@:access(vortex.backend.Window)
@:access(vortex.resources.Shader)
class OpenGLBackend extends IRenderingBackendImpl {
	public static final VERTICES:Array<Float32> = [
		// positions   // texture coords
		0.0,  0.0,     0.0, 0.0,   // top left
		0.0,  1.0,     0.0, 1.0,   // bottom left
		1.0,  1.0,     1.0, 1.0,   // bottom right
		1.0,  0.0,     1.0, 0.0    // top right 
	];

	public static final INDICES:Array<UInt32> = [
		// note that we start from 0!
		0, 1, 3, // first triangle
		1, 2, 3  // second triangle
	];

	public static var defaultShader(default, null):Shader;
	public static var colorRectShader(default, null):Shader;

	/**
	 * Initializes this rendering backend.
	 */
	public static function init():Void {
		defaultShader = Application.self.window._defaultShader;
		colorRectShader = Application.self.window._colorRectShader;
		_trans = new Matrix4x4(1.0);
		_vec3 = new Vector3();
	}

	/**
	 * Sets the values of the current viewport rectangle.
	 */
	public static function setViewportRect(rect:Rectanglei):Void {
		Glad.viewport(rect.x, rect.y, rect.width, rect.height);
	}

	/**
	 * Clears whatever is on-screen currently.
	 */
	public static function clear(window:Window):Void {
		SDL.glMakeCurrent(window._nativeWindow, window._glContext);
		Glad.clear(Glad.COLOR_BUFFER_BIT);

		defaultShader = window._defaultShader;

		colorRectShader = window._colorRectShader;
		colorRectShader.useProgram();

		Glad.bindVertexArray(window._VAO);

		_trans.reset(1.0);
		_trans.scale(_vec3.set(window.initialSize.x, window.initialSize.y, 1.0));

		colorRectShader.setUniformMat4x4("TRANSFORM", _trans);
		colorRectShader.setUniformColor("MODULATE", RenderingServer.clearColor);

		Glad.drawElements(Glad.TRIANGLES, 6, Glad.UNSIGNED_INT, 0);
	}
 
	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:Window):Void {
		SDL.glSwapWindow(window._nativeWindow);
	}

	/**
	 * Disposes of this rendering backend and removes it's
	 * properties from memory.
	 */
	public static function dispose():Void {
		if(defaultShader != null && !defaultShader.disposed)
			defaultShader.dispose();

		defaultShader = null;
	}

	// -------- //
	// Privates //
	// -------- //
	private static var _trans:Matrix4x4;
	private static var _vec3:Vector3;
}