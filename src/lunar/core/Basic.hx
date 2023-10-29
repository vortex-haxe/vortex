package lunar.core;

class Basic {
	/**
	 * Whether or not this object can update.
	 */
	public var active:Bool = true;

	/**
	 * Whether or not this object can draw onto the screen.
	 */
	public var visible:Bool = true;

	/**
	 * Returns a new `Basic`.
	 */
	public function new() {}

	/**
	 * Updates info about this object.
	 * Typically ran every frame.
	 * 
	 * @param delta  The time between the last and current frame in seconds.
	 */
	public function update(delta:Float) {}

	/**
	 * Draws this object onto the screen.
	 * Typically ran every frame.
	 */
	public function draw() {}
}