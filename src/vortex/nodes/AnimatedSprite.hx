package vortex.nodes;

import glad.Glad;

import vortex.backend.Application;

import vortex.servers.rendering.OpenGLBackend;

import vortex.resources.SpriteFrames;

import vortex.utils.math.Vector2;
import vortex.utils.math.Vector3;
import vortex.utils.math.Vector4;
import vortex.utils.math.Rectangle;
import vortex.utils.math.Matrix4x4;

/**
 * A basic sprite class that can render animations.
 * 
 * TODO: cliprect
 */
class AnimatedSprite extends Node2D {
	/**
	 * The resource containing the texture this sprite
	 * draws along with animation data for proper rendering.
	 */
	public var frames(default, set):SpriteFrames;

	// -------- //
	// Privates //
	// -------- //
	private var _clipRectUVCoords:Vector4 = new Vector4(0.0, 0.0, 1.0, 1.0);

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private inline function set_frames(newFrames:SpriteFrames):SpriteFrames {
		if(frames != null)
			frames.unreference();

		if(newFrames != null)
			newFrames.reference();

		frames = newFrames;
		return newFrames;
	}
}