package vortex.nodes.display;

import vortex.servers.RenderingServer;
import glad.Glad;

import vortex.backend.Application;

import vortex.servers.rendering.OpenGLBackend;

import vortex.resources.Shader;
import vortex.resources.Texture;

import vortex.utils.math.Vector2;
import vortex.utils.math.Vector2i;
import vortex.utils.math.Vector3;
import vortex.utils.math.Vector4;
import vortex.utils.math.Rectangle;
import vortex.utils.math.Matrix4x4;

/**
 * A basic sprite class that can render a texture.
 */
class Sprite extends Node2D {
	/**
	 * The texture that this sprite draws.
	 */
	public var texture(default, set):Texture;

	/**
	 * The rendered portion of the texture.
	 * 
	 * Set to `null` to render the whole texture.
	 */
	public var clipRect(default, set):Rectangle;

	/**
	 * The width and height of this sprite's texture.
	 */
	public var size(get, never):Vector2i;
	
	/**
	 * Called when this sprite is drawing internally.
	 * 
	 * Draw your own stuff in here if you need to,
	 * just make sure to call `super.draw()` before-hand!
	 */
	override function draw() {
		if(texture == null || texture.disposed)
			return;

		final shader:Shader = this.shader ?? RenderingServer.backend.defaultShader;

		@:privateAccess {
			shader.useProgram();
			RenderingServer.backend.quadRenderer.texture = texture._glID;
		}

		RenderingServer.backend.quadRenderer.drawTexture(position, size * scale, modulate, _clipRectUVCoords, origin, angle);
	}

	/**
	 * Disposes of this sprite and removes it's
	 * properties from memory.
	 */
	override function dispose() {
		if(!disposed) {
			if(texture != null)
				texture.unreference();
			
			_clipRectUVCoords = null;
		}
		super.dispose();
	}
		
	// -------- //
	// Privates //
	// -------- //
	private var _clipRectUVCoords:Vector4 = new Vector4(0.0, 0.0, 1.0, 1.0);

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private inline function get_size():Vector2i {
		if(texture != null && !texture.disposed)
			return texture.size;

		return Vector2i.ZERO;
	}

	@:noCompletion
	private inline function set_texture(newTexture:Texture):Texture {
		if(texture != null)
			texture.unreference();

		if(newTexture != null)
			newTexture.reference();

		texture = newTexture;

		if(clipRect != null)
			_updateClipRectUV(clipRect.x, clipRect.y, clipRect.width, clipRect.height);
		else
			_clipRectUVCoords.set(0.0, 0.0, 1.0, 1.0);

		return newTexture;
	}

	@:noCompletion
	private inline function set_clipRect(newRect:Rectangle):Rectangle {
		if(newRect != null) {
			@:privateAccess
			newRect._onChange = _updateClipRectUV;
			_updateClipRectUV(newRect.x, newRect.y, newRect.width, newRect.height);
		} else
			_clipRectUVCoords.set(0.0, 0.0, 1.0, 1.0);
		
		return clipRect = newRect;
	}

	@:noCompletion
	private inline function _updateClipRectUV(x:Float, y:Float, width:Float, height:Float) {
		_clipRectUVCoords.set(
			x / texture.size.x,
			y / texture.size.y,
			(x + width) / texture.size.x,
			(y + height) / texture.size.y
		);
	}
}