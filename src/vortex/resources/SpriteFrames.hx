package vortex.resources;

import vortex.utils.engine.RefCounted;
import vortex.utils.math.Vector2;

typedef AnimationFrame = {
	var position:Vector2;
	var offset:Vector2;
	var size:Vector2;
}

/**
 * A simple container resource for a texture and
 * animation frame data.
 */
class SpriteFrames extends RefCounted {
	/**
	 * The texture attached to this resource.
	 */
	public var texture:Texture;

	/**
	 * A map of animations to play in an `AnimatedSprite`.
	 */
	public var animations:Map<String, Array<AnimationFrame>> = [];

	/**
	 * Makes a new `SpriteFrames` and attaches
	 * a `Texture` to it.
	 */
	public function new(texture:Texture) {
		super();
		this.texture = texture;
		this.texture.reference();
	}

	/**
	 * Disposes of this resource and removes it's
	 * properties from memory.
	 */
	override function dispose() {
		if(!disposed) {
			texture.unreference();
			animations = null;
		}
		disposed = true;
	}
}