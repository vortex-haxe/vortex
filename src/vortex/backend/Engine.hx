package vortex.backend;

/**
 * A class full of globally accessable engine
 * properties and helpers.
 */
class Engine {
	/**
	 * Whether or not the game is paused.
	 */
	public static var paused:Bool = false;

	/**
	 * The time between the last frame in seconds.
	 */
	public static var deltaTime:Float = 0;
}
