package vortex.nodes;

@:allow(vortex.core.Engine)
class SceneTree {
	/**
	 * The root of this tree, where all nodes are located within.
	 */
	public var root:Node;

	/**
	 * The main window used by the game to draw
	 * things on-screen.
	 */
	public var window:Window;

	/**
	 * The currently loaded scene.
	 * 
	 * You can manually set this variable, but the 
	 * current scene will not be freed, Which can cause memory leaks.
	 * 
	 * It is recommended to call `changeScene()` to safely change scenes.
	 * 
	 * Only unsafely change scenes when absolutely necessary!
	 */
	public var currentScene:Node;

	/**
	 * Returns a new `SceneTree`.
	 */
	public function new() {
		root = new Node();
	}

	/**
	 * Waits until the current scene is finished updating,
	 * and then changes it to a new specified one.
	 * 
	 * This allows the current scene's updating to not be interrupted
	 * and thus finish correctly.
	 * 
	 * @param scene  The scene to change to.
	 */
	public function changeScene(scene:Node) {
		_pendingScene = scene;
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //
	private var _pendingScene:Node;
}
