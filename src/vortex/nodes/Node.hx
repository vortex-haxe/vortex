package vortex.nodes;

import vortex.core.interfaces.IFreeable;

@:allow(vortex.core.Engine)
class Node implements IFreeable {
	/**
	 * The parent of this node.
	 * 
	 * Returns `null` if this node is the parent itself
	 * or if this node isn't added to any possible parent node.
	 */
	public var parent:Node;

	/**
	 * Returns a new `Node`.
	 */
	public function new() {}

	/**
	 * Gets called when this node is ready
	 * to be used.
	 * 
	 * Override to initialize your own stuff
	 * after Vortex initializes it's own stuff.
	 */
	public function ready() {}

	/**
	 * Adds a given child node to this parent
	 * node's list of children.
	 * 
	 * @param node  The node to add.
	 */
	public function addChild(node:Node) {
		if (node == null || children.contains(node))
			return null;

		node.parent = this;
		children.push(node);
		_queuedToReady.push(node);
		node.enterTree();
		return node;
	}

	/**
	 * Removes a given child node from this parent
	 * node's list of children.
	 * 
	 * @param node  The node to remove.
	 */
	public function removeChild(node:Node) {
		if (node == null || !children.contains(node))
			return null;

		node.parent = null;
		children.remove(node);
		node.exitTree();
		return node;
	}

	/**
	 * Called when this node is added
	 * to a parent node.
	 */
	public function enterTree() {}

	/**
	 * Called when this node is removed
	 * from a parent node.
	 */
	public function exitTree() {}

	/**
	 * Returns the children in this node.
	 */
	public function getChildren():Array<Node> {
		return children;
	}

	/**
	 * Updates this node.
	 * 
	 * Override this function to make custom behavior.
	 * 
	 * @param delta  The time between the last and current frame in seconds.
	 */
	public function update(delta:Float) {}

	/**
	 * Draws this node to the screen.
	 * 
	 * Override this function to make custom behavior.
	 */
	public function draw() {}

	/**
	 * Queues this node to be freed once the game
	 * has finished updating every node possible.
	 * 
	 * This means you can use the node after calling this function
	 * because it won't be freed immediately.
	 */
	public inline function queueFree() {
		if (!_queuedToFree.contains(this))
			_queuedToFree.push(this);
	}

	/**
	 * Frees every property of this node from memory immediately.
	 * 
	 * Can cause crashes if this node is used after it is freed.
	 */
	public function free() {}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //
	private static var _queuedToFree:Array<Node> = [];
	private static var _queuedToReady:Array<Node> = [];

	/**
	 * The children of this node.
	 */
	@:noCompletion
	private var children:Array<Node> = [];

	@:noCompletion
	private function _update(delta:Float) {
		update(delta);
		for (child in children)
			child._update(delta);
	}

	@:noCompletion
	private function _draw() {
		draw();
		for (child in children)
			child._draw();
	}

	@:noCompletion
	private function _free() {
		free();
		for (child in children)
			child.free();
	}
}
