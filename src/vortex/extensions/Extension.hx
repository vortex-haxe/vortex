package vortex.extensions;

/**
 * Extensions are classes that simply
 * run in the background if toggled on.
 * 
 * Add the following code somewhere to allow
 * the extension to function correctly:
 * 
 * ```haxe
 * Engine.extensions.add(MyExtension);
 * ```
 */
class Extension {
	/**
	 * Whether or not this extension is allowed to
	 * tick/update automatically by the global extension manager.
	 */
	public var enabled:Bool = true;

	/**
	 * Makes a new `Extension`.
	 */
	public function new() {}

	/**
	 * Called when this extension is ticking/updating internally.
	 * 
	 * Update your own stuff in here if you need to,
	 * just make sure to call `super.tick(delta)` before-hand!
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	public function tick(delta:Float):Void {}
}