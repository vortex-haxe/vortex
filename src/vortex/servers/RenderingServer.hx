package vortex.servers;

import cpp.ConstCharStar;
import vortex.resources.SpriteFrames.AnimationFrame;
import vortex.resources.Shader;
import vortex.utils.math.Matrix4x4;
import vortex.utils.math.Vector4;
import vortex.utils.math.Vector3;
import vortex.utils.math.Vector2;
import vortex.utils.math.Rectangle;
import vortex.utils.math.Vector2i;
import vortex.backend.Application;
import vortex.backend.Window;
import vortex.backend.interfaces.IServer;

import vortex.servers.rendering.*;

import vortex.utils.engine.Color;
import vortex.utils.math.Rectanglei;

interface IShaderData {
	public var shader:Any;
}

interface IQuadRenderer {
	public var texture:Any;
	public var shader:IShaderData;
	public var projection:Matrix4x4;

	public function drawColor(position:Vector2, size:Vector2, color:Color):Void;
	public function drawTexture(position:Vector2, size:Vector2, modulate:Color, sourceRect:Vector4, origin:Vector2, angle:Float):Void;
	public function drawFrame(position:Vector2, frame:AnimationFrame, size:Vector2, scale:Vector2, modulate:Color, sourceRect:Vector4, origin:Vector2, angle:Float):Void;

	public function dispose():Void;
}

class RenderingBackend {
	public var quadRenderer:IQuadRenderer;
	public var defaultShader:Shader;

	public function new() {}

	/**
	 * Initializes this rendering backend.
	 */
	public function init():Void {}

	/**
	 * Sets the values of the current viewport rectangle.
	 */
	public function setViewportRect(rect:Rectanglei):Void {}

	/**
	 * Clears whatever is on-screen currently.
	 */
	public function clear(window:Window):Void {}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public function present(window:Window):Void {}

	/**
	 * TODO: Implement this!
	 */
	public function createShader(fragmentSource:ConstCharStar, vertexSource:ConstCharStar):IShaderData {
		return null;
	}

	/**
	 * TODO: Implement this!
	 */
	public function useShader(shader:IShaderData):Void {}

	/**
	 * TODO: Implement this!
	 */
	public function disposeShader(shader:IShaderData):Void {}

	/**
	 * TODO: Implement this!
	 */
	public function setUniformInt(shader:IShaderData, name:ConstCharStar, value:Int):Void {}

	/**
	 * TODO: Implement this!
	 */
	public function setUniformFloat(shader:IShaderData, name:ConstCharStar, value:Float):Void {}

	/**
	 * TODO: Implement this!
	 */
	public function setUniformVec2(shader:IShaderData, name:ConstCharStar, value:Vector2):Void {}

	/**
	 * TODO: Implement this!
	 */
	public function setUniformVec3(shader:IShaderData, name:ConstCharStar, value:Vector3):Void {}

	/**
	 * TODO: Implement this!
	 */
	public function setUniformVec4(shader:IShaderData, name:ConstCharStar, value:Vector4):Void {}

	/**
	 * TODO: Implement this!
	 */
	public function setUniformColor(shader:IShaderData, name:ConstCharStar, value:Color):Void {}

	/**
	 * TODO: Implement this!
	 */
	public function setUniformMat4x4(shader:IShaderData, name:ConstCharStar, value:Matrix4x4):Void {}

	/**
	 * Disposes of this rendering backend and removes it's
	 * properties from memory.
	 */
	public function dispose():Void {}
}

class RenderingServer extends IServer {
	/**
	 * The current rendering backend for every window.
	 * 
	 * Changing it after Vortex has already initialized
	 * could break/crash it!
	 * 
	 * Change it before `super()` is called in your Main class.
	 * 
	 * - `OPENGL` - The standard backend, supports shaders and works on basically any GPU.
	 * - `VULKAN` - The modern backend, supports shaders and runs better, but doesn't work on older GPUs.
	 * - `SDL` - The limited backend, doesn't support shaders but works on basically any GPU. 
	 */
	public static var backend:RenderingBackend = new OpenGLBackend();

	/**
	 * The default color displayed on an empty window.
	 * 
	 * This is defined in your `project.cfg` file.
	 */
	public static var clearColor:Color;

	/**
	 * Initializes the rendering server.
	 */
	public static function init():Void {
		// Initialize basic stuff
		clearColor = new Color().copyFrom(Application.self.meta.engine.clear_color);
		
		// Initialize the actual backend
		backend.init();
	}

	/**
	 * Sets the values of the current viewport rectangle.
	 */
	public static function setViewportRect(rect:Rectanglei):Void {
		backend.setViewportRect(rect);
	}

	/**
	 * Clears whatever is on-screen currently.
	 */
	public static function clear(window:Window):Void {
		backend.clear(window);
	}
 
	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present(window:Window):Void {
		backend.present(window);
	}

	/**
	 * TODO: Implement this!
	 */
	public static function createShader(fragmentSource:String, vertexSource:String):IShaderData {
		return backend.createShader(fragmentSource, vertexSource);
	}

	/**
	 * TODO: Implement this!
	 */
	public static function useShader(shader:IShaderData):Void {
		backend.useShader(shader);
	}

	/**
	 * TODO: Implement this!
	 */
	public static function disposeShader(shader:IShaderData):Void {
		backend.disposeShader(shader);
	}

	/**
	 * TODO: Implement this!
	 */
	public static function setUniformInt(shader:IShaderData, name:String, value:Int):Void {
		backend.setUniformInt(shader, name, value);
	}

	/**
	 * TODO: Implement this!
	 */
	public static function setUniformFloat(shader:IShaderData, name:String, value:Float):Void {
		backend.setUniformFloat(shader, name, value);
	}

	/**
	 * TODO: Implement this!
	 */
	public static function setUniformVec2(shader:IShaderData, name:String, value:Vector2):Void {
		backend.setUniformVec2(shader, name, value);
	}

	/**
	 * TODO: Implement this!
	 */
	public static function setUniformVec3(shader:IShaderData, name:String, value:Vector3):Void {
		backend.setUniformVec3(shader, name, value);
	}

	/**
	 * TODO: Implement this!
	 */
	public static function setUniformVec4(shader:IShaderData, name:String, value:Vector4):Void {
		backend.setUniformVec4(shader, name, value);
	}

	/**
	 * TODO: Implement this!
	 */
	public static function setUniformColor(shader:IShaderData, name:String, value:Color):Void {
		backend.setUniformColor(shader, name, value);
	}

	/**
	 * TODO: Implement this!
	 */
	public static function setUniformMat4x4(shader:IShaderData, name:String, value:Matrix4x4):Void {
		backend.setUniformMat4x4(shader, name, value);
	}

	/**
	 * Disposes of this rendering server and removes it's
	 * properties from memory.
	 */
	public static function dispose():Void {
		backend.dispose();
	}
}