package vortex.resources;

import vortex.servers.RenderingServer;
import vortex.servers.RenderingServer.IShaderData;
import sys.io.File;
import sys.FileSystem;

import cpp.Pointer;
import cpp.Helpers;
import cpp.UInt32;
import cpp.ConstCharStar;

import glad.Glad;

import vortex.backend.Application;

import vortex.utils.engine.Color;

import vortex.utils.math.Vector2;
import vortex.utils.math.Vector3;
import vortex.utils.math.Vector4;
import vortex.utils.math.Matrix4x4;

@:access(vortex.backend.Window)
class Shader extends Resource {
	public static final VERTEX_PREFIX:String = "
		#version 330 core
		layout (location = 0) in vec4 data;
		uniform mat4 PROJECTION;
		uniform mat4 TRANSFORM;
		uniform vec4 SOURCE;
		out vec2 UV;
	";

	public static final VERTEX_DEFAULT:String = "
		void main() {
			gl_Position = PROJECTION * TRANSFORM * vec4(data.x, data.y, 0.0, 1.0);
			UV = mix(SOURCE.xy, SOURCE.zw, data.zw);
		}
	";

	public static final FRAGMENT_PREFIX:String = "
		#version 330 core
		uniform sampler2D TEXTURE;
		uniform vec4 MODULATE;
		in vec2 UV;
		out vec4 COLOR;
	";

	public static final FRAGMENT_DEFAULT:String = "
		void main() {
			COLOR = texture(TEXTURE, UV) * MODULATE;
		}
	";

	private var shaderData:IShaderData;

	/**
	 * Makes a new `Shader` based on the
	 * given `frag` and `vert` code.
	 */
	public function new(?frag:String, ?vert:String) {
		super();
		
		var fragContent = ConstCharStar.fromString(FRAGMENT_PREFIX + ((frag != null && FileSystem.exists(frag)) ? File.getContent(frag) : (frag != null && frag.trim().length > 0) ? frag : FRAGMENT_DEFAULT));
		var vertContent = ConstCharStar.fromString(VERTEX_PREFIX + ((vert != null && FileSystem.exists(vert)) ? File.getContent(vert) : (vert != null && vert.trim().length > 0) ? vert : VERTEX_DEFAULT));
		
		shaderData = RenderingServer.backend.createShader(fragContent, vertContent);
		useProgram();
	}

	private function useProgram():Void {
		RenderingServer.backend.useShader(shaderData);
	}

	public function setUniformInt(name:ConstCharStar, value:Int):Void {
		RenderingServer.backend.setUniformInt(shaderData, name, value);
	}

	public function setUniformFloat(name:ConstCharStar, value:Float) {
		RenderingServer.backend.setUniformFloat(shaderData, name, value);
	}

	public function setUniformVec2(name:ConstCharStar, value:Vector2) {
		RenderingServer.backend.setUniformVec2(shaderData, name, value);
	}

	public function setUniformVec3(name:ConstCharStar, value:Vector3) {
		RenderingServer.backend.setUniformVec3(shaderData, name, value);
	}

	public function setUniformVec4(name:ConstCharStar, value:Vector4) {
		RenderingServer.backend.setUniformVec4(shaderData, name, value);
	}

	public function setUniformColor(name:ConstCharStar, value:Color) {
		RenderingServer.backend.setUniformColor(shaderData, name, value);
	}

	public function setUniformMat4x4(name:ConstCharStar, value:Matrix4x4) {
		RenderingServer.backend.setUniformMat4x4(shaderData, name, value);
	}

	/**
	 * Disposes of this shader and removes it's
	 * properties from memory.
	 */
	override function dispose():Void {
		trace('Dispose shader #' + shaderData.shader);

		if (!disposed)
			RenderingServer.backend.disposeShader(shaderData);
		
		disposed = true;
	}
}