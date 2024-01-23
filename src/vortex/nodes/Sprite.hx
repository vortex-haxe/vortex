package vortex.nodes;

import glad.Glad;

import vortex.backend.Application;

import vortex.servers.rendering.OpenGLBackend;

import vortex.resources.Shader;
import vortex.resources.Texture;

import vortex.utils.math.Vector2;
import vortex.utils.math.Vector3;
import vortex.utils.math.Matrix4x4;

/**
 * A basic sprite class that can render a texture.
 */
class Sprite extends Node2D {
	/**
	 * The shader applied to this sprite when it draws.
	 */
	public var shader(default, set):Shader;

	/**
	 * The texture that this sprite draws.
	 */
	public var texture(default, set):Texture;

	/**
	 * Called when this sprite is drawing internally.
	 * 
	 * Draw your own stuff in here if you need to,
	 * just make sure to call `super.draw()` before-hand!
	 */
	override function draw() {
		final shader:Shader = this.shader ?? OpenGLBackend.defaultShader;
		@:privateAccess {
			shader.useProgram();
			Glad.activeTexture(Glad.TEXTURE0);
			Glad.bindTexture(Glad.TEXTURE_2D, texture._glID);
			Glad.bindVertexArray(Application.self.window._VAO);
		}
		prepareShaderVars(shader);
		Glad.drawElements(Glad.TRIANGLES, 6, Glad.UNSIGNED_INT, 0);
	}

	/**
	 * Disposes of this sprite and removes it's
	 * properties from memory.
	 */
	override function dispose() {
		if(!disposed) {
			if(shader != null)
				shader.unreference();

			if(texture != null)
				texture.unreference();
		}
		super.dispose();
	}

	// -------- //
	// Privates //
	// -------- //
	private static var _trans = new Matrix4x4();
	private static var _vec2 = new Vector2();
	private static var _vec3 = new Vector3();
	
	private function prepareShaderVars(shader:Shader) {
		_trans.reset(1.0);
		
        _vec2.set(texture.size.x * scale.x, texture.size.y * scale.y);
        _trans.scale(_vec3.set(_vec2.x, _vec2.y, 1.0));

        if (angle != 0.0) {
			_trans.translate(_vec3.set(-origin.x * _vec2.x, -origin.y * _vec2.y, 0.0));
            _trans.radRotate(angle, _vec3.set(0.0, 0.0, 1.0)); 
			_trans.translate(_vec3.set(origin.x * _vec2.x, origin.y * _vec2.y, 0.0));
        }
		_trans.translate(_vec3.set(position.x + (-origin.x * _vec2.x), position.y + (-origin.y * _vec2.y), 0.0));
		
		shader.setUniformMat4x4("TRANSFORM", _trans);
		shader.setUniformColor("MODULATE", modulate);
	}

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private inline function set_shader(newShader:Shader):Shader {
		if(shader != null)
			shader.unreference();

		if(newShader != null)
			newShader.reference();

		return shader = newShader;
	}
	
	@:noCompletion
	private inline function set_texture(newTexture:Texture):Texture {
		if(texture != null)
			texture.unreference();

		if(newTexture != null)
			newTexture.reference();

		return texture = newTexture;
	}
}