package vortex.resources;

import sys.io.File;
import sys.FileSystem;

import cpp.Pointer;
import cpp.Helpers;
import cpp.UInt32;
import cpp.ConstCharStar;

import glad.Glad;

import vortex.backend.Application;

import vortex.utils.engine.Color;
import vortex.utils.engine.RefCounted;

import vortex.utils.math.Vector2;
import vortex.utils.math.Vector3;
import vortex.utils.math.Vector4;
import vortex.utils.math.Matrix4x4;

@:access(vortex.backend.Window)
class Shader extends RefCounted {
	public static final VERTEX_PREFIX:String = "
		#version 330 core
		layout (location = 0) in vec4 data;
		uniform mat4 PROJECTION;
		uniform mat4 TRANSFORM;
		out vec2 UV;
	";

	public static final VERTEX_DEFAULT:String = "
		void main() {
			gl_Position = PROJECTION * TRANSFORM * vec4(data.x, data.y, 0.0, 1.0);
			UV = data.zw;
		}
	";

	public static final FRAGMENT_PREFIX:String = "
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

	private var programID:UInt32;

	/**
	 * Makes a new `Shader` based on the
	 * given `frag` and `vert` code.
	 */
	public function new(?frag:String, ?vert:String) {
		super();
		var fragContent = ConstCharStar.fromString(FRAGMENT_PREFIX + ((frag != null && FileSystem.exists(frag)) ? File.getContent(frag) : (frag != null && frag.trim().length > 0) ? frag : FRAGMENT_DEFAULT));
		var vertContent = ConstCharStar.fromString(VERTEX_PREFIX + ((vert != null && FileSystem.exists(vert)) ? File.getContent(vert) : (vert != null && vert.trim().length > 0) ? vert : VERTEX_DEFAULT));
		var success:Int = 0;

		var vertID:UInt32 = Glad.createShader(Glad.VERTEX_SHADER);
		Glad.shaderSource(vertID, 1, Helpers.tempPointer(vertContent), null);
		Glad.compileShader(vertID);
		Glad.getShaderiv(vertID, Glad.COMPILE_STATUS, Pointer.addressOf(success));

		if (success == 0) {
			var infoLog:cpp.Star<cpp.Char> = Helpers.malloc(1024, cpp.Char);
			Glad.getShaderInfoLog(vertID, 1024, null, infoLog);
			Helpers.nativeTrace("Failed to load Vertex Shader.\n%s\n", infoLog);
			Helpers.free(infoLog);
		}

		var fragID:UInt32 = Glad.createShader(Glad.FRAGMENT_SHADER);
		Glad.shaderSource(fragID, 1, Helpers.tempPointer(fragContent), null);
		Glad.compileShader(fragID);
		Glad.getShaderiv(fragID, Glad.COMPILE_STATUS, Pointer.addressOf(success));

		if (success == 0) {
			var infoLog:cpp.Star<cpp.Char> = Helpers.malloc(1024, cpp.Char);
			Glad.getShaderInfoLog(fragID, 1024, null, infoLog);
			Helpers.nativeTrace("Failed to load Fragment Shader.\n%s\n", infoLog);
			Helpers.free(infoLog);
		}

		programID = Glad.createProgram();
		Glad.attachShader(programID, vertID);
		Glad.attachShader(programID, fragID);
		Glad.linkProgram(programID);
		Glad.getProgramiv(programID, Glad.LINK_STATUS, Pointer.addressOf(success));

		if (success == 0) {
			var infoLog:cpp.Star<cpp.Char> = Helpers.malloc(1024, cpp.Char);
			Glad.getProgramInfoLog(programID, 1024, null, infoLog);
			Helpers.nativeTrace("Failed to link Shader Program.\n%s\n", infoLog);
			Helpers.free(infoLog);
		}

		Glad.deleteShader(vertID);
		Glad.deleteShader(fragID);

		Glad.useProgram(programID);
		setUniformMat4x4("PROJECTION", Application.self.window._projection);
	}

	private function useProgram() {
		Glad.useProgram(programID);
	}

	public inline function setUniformInt(name:ConstCharStar, value:Int) {
		untyped __cpp__("glUniform1i(glGetUniformLocation({0}, {1}), {2})", programID, name, value);
	}

	public inline function setUniformFloat(name:ConstCharStar, value:Float) {
		untyped __cpp__("glUniform1f(glGetUniformLocation({0}, {1}), {2})", programID, name, value);
	}

	public inline function setUniformVec2(name:ConstCharStar, value:Vector2) {
		untyped __cpp__("glUniform2f(glGetUniformLocation({0}, {1}), {2}, {3})", programID, name, value.x, value.y);
	}

	public inline function setUniformVec3(name:ConstCharStar, value:Vector3) {
		untyped __cpp__("glUniform3f(glGetUniformLocation({0}, {1}), {2}, {3}, {4})", programID, name, value.x, value.y, value.z);
	}

	public inline function setUniformVec4(name:ConstCharStar, value:Vector4) {
		untyped __cpp__("glUniform4f(glGetUniformLocation({0}, {1}), {2}, {3}, {4}, {5})", programID, name, value.x, value.y, value.z, value.w);
	}

	public inline function setUniformColor(name:ConstCharStar, value:Color) {
		untyped __cpp__("glUniform4f(glGetUniformLocation({0}, {1}), {2}, {3}, {4}, {5})", programID, name, value.r, value.g, value.b, value.a);
	}

	public inline function setUniformMat4x4(name:ConstCharStar, value:Matrix4x4) {
		untyped __cpp__("
			float* _star = {0};
			glUniformMatrix4fv(glGetUniformLocation({1}, {2}), 1, GL_FALSE, _star);
			free(_star)", value.toStar(), this.programID, name);
	}

	/**
	 * Disposes of this shader and removes it's
	 * properties from memory.
	 */
	override function dispose():Void {
		if(!disposed)
			Glad.deleteProgram(programID);
		
		disposed = true;
	}
}