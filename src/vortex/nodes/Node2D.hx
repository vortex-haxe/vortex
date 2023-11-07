package vortex.nodes;

import vortex.utils.RotationUtil;
import vortex.math.Vector2;

class Node2D extends Node {
	/**
	 * The X and Y coordinates of this node on screen in pixels.
	 * 
	 * Starts from the top-left corner of the screen.
	 */
	public var position:Vector2;

	/**
	 * The X and Y scale multiplier for this node's texture.
	 * 
	 * The value for no multiplier is `(1, 1)`.
	 */
	public var scale:Vector2;

	/**
	 * The rotation of this node in radians.
	 * 
	 * Use `rotationDegrees` to get/set the rotation
	 * of this node using degrees instead.
	 */
	public var rotation:Float;

	/**
	 * The rotation of this node in degrees.
	 * 
	 * Use `rotation` to get/set the rotation
	 * of this node using radians instead.
	 */
	public var rotationDegrees(get, set):Float;

	/**
	 * Returns a new `Node2D`.
	 */
	public function new() {
		super();
		rotation = 0;
		position = new Vector2();
		scale = new Vector2(1, 1);
	}

	/**
	 * Frees every property of this node from memory immediately.
	 * 
	 * Can cause crashes if this node is used after it is freed.
	 */
	override function free() {
		position = null;
		scale = null;
	}

	//##==-------------------------------------------------==##//
	//##==----- Don't modify these parts below unless -----==##//
	//##==-- you are here to fix a bug or add a feature. --==##//
	//##==-------------------------------------------------==##//

	@:noCompletion
	private inline function get_rotationDegrees():Float {
		return rotation * RotationUtil.TO_DEGREES;
	}

	@:noCompletion
	private inline function set_rotationDegrees(value:Float):Float {
		return rotation = (value * RotationUtil.TO_RADIANS);
	}
}