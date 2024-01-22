package vortex.nodes;

import vortex.resources.Shader;
import vortex.resources.Texture;

/**
 * A basic sprite class that can render a texture.
 */
class Sprite extends Node2D {
	/**
	 * The shader applied to this sprite when it draws.
	 */
	public var shader:Shader;

	/**
	 * The texture that this sprite draws.
	 */
	public var texture(default, set):Texture;

	/**
	 * Called when this sprite is drawing internally.
	 * 
	 * Draw your own stuff in here if you need to,
	 * just make sure to call `super.draw(delta)` before-hand!
	 */
	override function draw() {
		
	}

	/**
	 * Disposes of this sprite and removes it's
	 * properties from memory.
	 */
	override function dispose() {
		if(!disposed) {
			if(texture != null)
				texture.unreference();
		}
		super.dispose();
	}

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private inline function set_texture(newTexture:Texture):Texture {
		if(texture != null)
			texture.unreference();

		if(newTexture != null)
			newTexture.reference();

		return texture = newTexture;
	}
}