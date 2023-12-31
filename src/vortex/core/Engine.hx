package vortex.core;

import al.AL;
import vortex.utils.AudioMixer;
import sdl.SDL;
import sdl.Image;
import sdl.ttf.TTF;
import sdl.Window.WindowPos;
import vortex.core.Project.ProjectInfo;
import vortex.macros.ProjectMacro;
import vortex.nodes.Node;
import vortex.nodes.Window;
import vortex.nodes.SceneTree;
import vortex.utils.MathUtil;
import vortex.utils.CFGParser;

class Engine {
	/**
	 * The settings for the project.
	 */
	public static var projectSettings:ProjectInfo;

	/**
	 * The tree containing all nodes.
	 */
	public static var tree:SceneTree;

	/**
	 * Returns how long it has taken
	 * for the last frame to update.
	 */
	public static var deltaTime:Float = 0;

	/**
	 * Initializes your Vortex game.
	 * 
	 * Most of the configuration is within your `project.cfg` file.
	 * 
	 * Class path, defines, libraries, main class and export folder are within `build.hxml`.
	 * 
	 * @param scene  The initial scene to load.
	 */
	public static function init(scene:Node) {
		projectSettings = CFGParser.parse(ProjectMacro.getConfig());

		SDL.setHint("SDL_HINT_RENDER_BATCHING", "1");

		Debug.init();

		if (!AudioMixer.init()) {
			Debug.error('OpenAL failed to initialize!');
			return;
		}
		if (SDL.init(VIDEO) < 0) {
			Debug.error('SDL failed to initialize video! - ${cast (SDL.getError(), String)}');
			return;
		}
		if (SDL.init(EVENTS) < 0) {
			Debug.error('SDL failed to initialize events! - ${cast (SDL.getError(), String)}');
			return;
		}
		if (Image.init(EVERYTHING) == 0) {
			Debug.error('SDL image failed to initialize! - ${cast (SDL.getError(), String)}');
			return;
		}
		if (TTF.init() < 0) {
			Debug.error('SDL ttf failed to initialize! - ${cast (SDL.getError(), String)}');
			return;
		}
		Window.event = SDL.createEventPtr();

        tree = new SceneTree();
		tree.window = new Window(
			projectSettings.window.title, 
			WindowPos.CENTERED, WindowPos.CENTERED, 
			Std.int(projectSettings.window.size.x), Std.int(projectSettings.window.size.y)
		);
		tree.window.addChild(tree.currentScene = (scene ?? new Node()));

		Node._queuedToReady = [];
		tree.window.ready();
		tree.currentScene.ready();

		while (Window._windows.length > 0) {
			final curTime:Int = cast SDL.getPerformanceCounter();
			Engine.deltaTime = MathUtil.bound((curTime - lastTime) / (cast SDL.getPerformanceFrequency()), 0, 0.1);

			tree.root._update(Engine.deltaTime);
			tree.root._draw();

			if (tree._pendingScene != null) {
				if (tree.currentScene != null) {
					tree.window.removeChild(tree.currentScene);
					tree.currentScene.free();
				}
				tree.currentScene = tree._pendingScene;
				tree.window.addChild(tree.currentScene);

				tree._pendingScene = null;
			}

			while (Node._queuedToFree.length > 0) {
				final node = Node._queuedToFree.shift();
				node.parent?.removeChild(node);
				node.free();
			}
			while (Node._queuedToReady.length > 0)
				Node._queuedToReady.shift().ready();

			lastTime = curTime;
			if(projectSettings.engine.fps != 0)
				SDL.delay(Std.int(1000.0 / projectSettings.engine.fps));
		}

		AudioMixer.quit();
		TTF.quit();
		Image.quit();
		SDL.quit();
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //
	private static var lastTime:Int = 0;
}
