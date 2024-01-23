package vortex.nodes;

import vortex.nodes.Node;

import vortex.resources.Shader;

import vortex.utils.math.Vector2;
import vortex.utils.math.AngleUtil;

/**
 * A node with basic 2D properties such as position, angle, and scale.
 */
class Node2D extends Node {
	/**
	 * The X and Y position of this sprite in pixels.
	 * 
	 * Starts from the top-left corner of the screen.
	 */
	public var position(default, set):Vector2 = Vector2.ZERO;

	/**
	 * The angle/rotation of this node in radians.
	 * 
	 * Use `angleDegrees` to get/set the angle with degree values.
	 */
	public var angle:Float = 0;

	/**
	 * The angle/rotation of this node in degrees.
	 * 
	 * Use `angle` to get/set the angle with radian values.
	 */
	public var angleDegrees(get, set):Float;

	/**
	 * The rotation origin of this node.
	 * 0 is top/left, 1 is bottom/right.
	 */
	public var origin:Vector2 = new Vector2(0.5, 0.5);

	/**
	 * The X and Y scale multiplier of this node. 1 is default.
	 */
	public var scale:Vector2 = Vector2.ONE;

	/**
	 * The shader applied to this sprite when it draws.
	 */
	public var shader(default, set):Shader;

	/**
	 * Disposes of this node and removes it's
	 * properties from memory.
	 */
	override function dispose() {
		if(!disposed) {
			shader.unreference();
			position = null;
			scale = null;
			origin = null;
		}
		super.dispose();
	}

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private inline function get_angleDegrees():Float {
		return angle * AngleUtil.TO_DEGREES;
	}

	@:noCompletion
	private inline function set_angleDegrees(newAngle:Float):Float {
		angle = newAngle * AngleUtil.TO_RADIANS;
		return newAngle;
	}

	@:noCompletion
	private inline function set_position(newPosition:Vector2) {
		return position.copyFrom(newPosition);
	}

	@:noCompletion
	private inline function set_shader(newShader:Shader):Shader {
		if(shader != null)
			shader.unreference();

		if(newShader != null)
			newShader.reference();

		return shader = newShader;
	}
}