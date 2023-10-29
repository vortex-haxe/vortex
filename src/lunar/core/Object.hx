package lunar.core;

class Object {
	/**
	 * Whether or not this node can update.
	 */
	public var active:Bool = true;

	/**
	 * Whether or not this node can draw onto the screen.
	 */
	public var visible:Bool = true;

	/**
	 * Returns a new `Node`.
	 */
	public function new() {}

	/**
	 * Updates info about this node.
	 * Typically ran every frame.
	 * 
	 * @param delta  The time between the last and current frame in seconds.
	 */
	public function update(delta:Float) {}

	/**
	 * Draws this node onto the screen.
	 * Typically ran every frame.
	 */
	public function draw() {}
}