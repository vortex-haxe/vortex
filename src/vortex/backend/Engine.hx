package vortex.backend;

import cpp.vm.Gc;

import vortex.extensions.*;

import vortex.nodes.Node;
import vortex.utils.math.Vector2i;

/**
 * A class full of globally accessable engine
 * properties and helpers.
 */
@:access(vortex.nodes.Node)
class Engine {
	/**
	 * Whether or not the game is paused.
	 */
	public static var paused:Bool = false;

	/**
	 * The time between the last frame in seconds.
	 */
	public static var deltaTime:Float = 0;

	/**
	 * The initial width and height of the game.
	 */
	public static var gameSize(get, never):Vector2i;

	/**
	 * The currently loaded scene.
	 * 
	 * Use `changeSceneTo()` to safely change to another scene.
	 * 
	 * Only set the variable directly if `changeSceneTo` doesn't work
	 * for your use cases!
	 */
	public static var currentScene:Node;

	/**
	 * The current amount of frames per second.
	 */
	public static var currentFPS:Int = 0;

	/**
	 * A helper object to manage extensions.
	 * 
	 * Allows you to add or remove them, making them
	 * start or stop ticking/updating automatically.
	 */
	public static var extensions:ExtensionManager;

	/**
	 * Changes the current scene to a new specified one.
	 * 
	 * @param newScene  The scene to change to.
	 */
	public static function changeSceneTo(newScene:Node) {
		_queuedScene = newScene;
	}

	// -------- //
	// Privates //
	// -------- //
	private static var _queuedScene:Node = null;
	private static var _fpsTimer:Float = 0;
	private static var _queuedFPS:Int = 0;

	private static function init() {
		// Initialize internal managers
		extensions = new ExtensionManager();

		// Initialize internal extensions
		extensions.add(TweenManager);
		extensions.add(TimerManager);
	}

	private static function _changeToQueuedScene() {
		// dispose old scene
		if(currentScene != null)
			currentScene.dispose();

		// change to new scene
		currentScene = _queuedScene;
		Application.self.window._children[0] = currentScene;

		// call ready on new scene
		if(currentScene != null)
			currentScene.ready();

		// call garbage collector because fuck you
		Gc.run(true);
		Gc.run(false);
	}

	private static function tick(delta:Float) {
		if(_queuedScene != null)
			_changeToQueuedScene();

		_queuedFPS++;
		if((_fpsTimer += delta) >= 1.0) {
			currentFPS = _queuedFPS;
			_fpsTimer = _queuedFPS = 0;
		}
		extensions.tick(delta);
	}

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private static inline function get_gameSize():Vector2i {
		return Application.self.meta.window.size;
	}
}
