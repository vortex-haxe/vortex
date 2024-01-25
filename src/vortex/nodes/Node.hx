package vortex.nodes;

import vortex.backend.interfaces.IDisposable;
import vortex.backend.Engine;

import vortex.utils.engine.Color;

enum TickMode {
	/**
	 * Inherit the tick mode from the parent node.
	 */
	INHERIT;

	/**
	 * This object will tick regardless of the game being paused or not.
	 */
	ALWAYS;

	/**
	 * This object will always tick unless the game is paused.
	 */
	PAUSABLE;

	/**
	 * This object will never tick.
	 */
	NEVER;
}

/**
 * A simple game object to base things such as Players, Enemies, etc off of.
 * 
 * Nodes can have children nodes within them.
 */
class Node extends Object {
	/**
	 * The parent node this node belongs to.
	 */
	public var parent(default, null):Node = null;

	/**
	 * Determines when this node will get ticked.
	 */
	public var tickMode:TickMode = PAUSABLE;

	/**
	 * Whether or not this node is visible on-screen.
	 */
	public var visible:Bool = true;

	/**
	 * The color tint multiplier for this node.
	 */
	public var modulate:Color = Color.WHITE;

	/**
	 * Makes a new `Node`.
	 */
	public function new() {
		super();
	}

	/**
	 * Called when this node is finished initializing internally.
	 * 
	 * Initialize your own stuff here if you need to!
	 */
	public function ready() {}

	/**
	 * Returns an array with every child node in this parent node.
	 */
	public function getChildren():Array<Node> {
		return _children.copy();
	}

	/**
	 * Adds a child to this parent node's list of children.
	 * 
	 * @param node  The child node to add.
	 */
	public function addChild(node:Node):Void {
		if(node.parent != null && node.parent != this) {
			Debug.error("Child node already has a different parent, remove it first!");
			return;
		}
		if(node.parent == this) {
			Debug.warn("Child node is already a child of this parent node!");
			return;
		}
		node.parent = this;
		node.ready();
		_children.push(node);
	}

	/**
	 * Inserts a child to this parent node's list of children
	 * at a specific index.
	 * 
	 * @param index  The index that this child node should be added at.
	 * @param node   The child node to add.
	 */
	public function insertChild(index:Int, node:Node):Void {
		if(node.parent != null && node.parent != this) {
			Debug.error("Child node already has a different parent, remove it first!");
			return;
		}
		if(node.parent == this) {
			Debug.warn("Child node is already a child of this parent node!");
			return;
		}
		node.parent = this;
		node.ready();
		_children.insert(index, node);
	}

	/**
	 * Removes a child from this parent node's list of children.
	 * 
	 * @param node  The child node to remove.
	 */
	public function removeChild(node:Node) {
		if(node.parent == null) {
			Debug.warn("Child node has no parent!");
			return;
		}
		node.parent = null;
		_children.remove(node);
	}

	/**
	 * Goes through each child node and makes them tick,
	 * then afterwards makes this one tick.
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	public function tickAll(delta:Float):Void {
		var i:Int = 0;
		while(i < _children.length) {
			final child:Node = _children[i++];
			if(child != null && !child.disposed) {
				final canChildUpdate:Bool = child.tickMode != NEVER && (child.tickMode == ALWAYS || (child.tickMode == PAUSABLE && !Engine.paused));
				final canParentUpdate:Bool = (child.tickMode == INHERIT && tickMode != NEVER && (tickMode == ALWAYS || (tickMode == PAUSABLE && !Engine.paused)));
				if(canChildUpdate || canParentUpdate)
					child.tickAll(delta);
			}
		}
		tick(delta);
	}

	/**
	 * Goes through each child node and makes them draw,
	 * then afterwards makes this one draw.
	 */
	public function drawAll():Void {
		if(!visible)
			return;
		
		var i:Int = 0;
		while(i < _children.length) {
			final child:Node = _children[i++];
			if(child != null && child.visible && !child.disposed)
				child.drawAll();
		}
		draw();
	}

	/**
	 * Called when this node is ticking/updating internally.
	 * 
	 * Update your own stuff in here if you need to,
	 * just make sure to call `super.tick(delta)` before-hand!
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	override function tick(delta:Float):Void {}

	/**
	 * Called when this node is drawing internally.
	 * 
	 * Draw your own stuff in here if you need to,
	 * just make sure to call `super.draw()` before-hand!
	 */
	override function draw():Void {}

	/**
	 * Disposes of this node and removes it's
	 * properties from memory.
	 */
	override function dispose():Void {
		if(!disposed) {
			var i:Int = 0;
			while(i < _children.length) {
				final child:Node = _children[i++];
				if(child != null)
					child.dispose();
			}
		}
		super.dispose();
	}

	// -------- //
	// Privates //
	// -------- //
	private var _children:Array<Node> = [];
}