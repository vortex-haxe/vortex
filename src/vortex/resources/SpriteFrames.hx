package vortex.resources;

import vortex.utils.engine.RefCounted;
import vortex.utils.math.Vector2;

typedef AnimationFrame = {
	var name:String;
	var position:Vector2;
	var offset:Vector2;
	var size:Vector2;
	var marginSize:Vector2;
	var angle:Float;
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
	 * A list of animation frames to display in an `AnimatedSprite`.
	 */
	public var frames:Array<AnimationFrame> = [];

	/**
	 * Makes a new `SpriteFrames` and attaches
	 * a `Texture` to it.
	 */
	public function new(texture:Texture) {
		super();
		this.texture = texture;
	}

	/**
	 * Increases the reference counter.
	 * 
	 * Do not use this unless you know what you're doing!!
	 */
	override function reference() {
		if(texture != null)
			texture.reference();
		super.reference();
	}

	/**
	 * Decreases the reference counter.
	 * 
	 * Do not use this unless you know what you're doing!!
	 */
	override function unreference() {
		if(texture != null)
			texture.unreference();
		super.unreference();
	}

	/**
	 * Disposes of this resource and removes it's
	 * properties from memory.
	 */
	override function dispose() {
		if(!disposed) {
			texture.unreference();
			frames = null;
		}
		disposed = true;
	}
}