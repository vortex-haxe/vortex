package vortex.backend;

#if !macro
import cpp.UInt64;
import cpp.vm.Gc;

import vortex.backend.macros.ProjectMacro;
import vortex.backend.Window;

import vortex.servers.DisplayServer;
import vortex.servers.RenderingServer;
import vortex.servers.AudioServer;
import vortex.servers.InputServer;
import vortex.servers.ResourceServer;

import vortex.utils.generic.CFGParser;
import vortex.utils.engine.Project.ProjectInfo;
import vortex.utils.math.Vector2i;

import sdl.SDL;
import sdl.Types.SDLWindowPos;

/**
 * The very base of your games!
 */
@:access(vortex.nodes.Node)
@:access(vortex.backend.Engine)
@:access(vortex.backend.Window)
@:autoBuild(vortex.backend.macros.ApplicationMacro.build())
class Application {
	/**
	 * The current application instance.
	 */
	public static var self:Application;

	/**
	 * The metadata of the project config.
	 */
	public var meta:ProjectInfo;

	/**
	 * The main window of this application.
	 */
	public var window:Window;

	/**
	 * All of the windows attached to this application.
	 */
	public var windows:Array<Window> = [];

	/**
	 * Makes a new `Application`.
	 */
	public function new() {
		if(self == null)
			self = this;
		
		meta = CFGParser.parse(ProjectMacro.getConfig());

		DisplayServer.init();
		AudioServer.init();
		
		window = new Window(meta.window.title, new Vector2i(SDLWindowPos.CENTERED, SDLWindowPos.CENTERED), new Vector2i().copyFrom(meta.window.size));
		InputServer.init();
		
		RenderingServer.init();
		Engine.init();
	}

	public function startEventLoop() {
		self.window._children[0] = Engine.currentScene;
		if(Engine.currentScene != null)
			Engine.currentScene.ready();

		Window._ev = SDL.makeEvent();
		
		var curTime:UInt64 = SDL.getPerformanceCounter();
		var oldTime:UInt64 = 0;

		while(windows.length != 0) {
			oldTime = curTime;
			curTime = SDL.getPerformanceCounter();

			Engine.deltaTime = untyped __cpp__("(double)({0} - {1}) / (double){2}", curTime, oldTime, SDL.getPerformanceFrequency());
			Engine.tick(Engine.deltaTime);

			var i:Int = 0;
			while(i < windows.length) {
				final window:Window = windows[i++];
				if(window != null) {
					RenderingServer.backend.clear(window);

					window.pollEvents();
					window.tickAll(Engine.deltaTime);
					window.drawAll();
					
					RenderingServer.backend.present(window);
				}
			}
			InputServer.updateStates();

			// past cube: hxcpp is coded weirdly enough to where
			// this might prevent gc blowups while keeping decent fps

			// future cube: yeah the memory usage stays good while
			// fps stays at like over 1000 on my pc i think we good
			// this is stupid but it works for some reason
			Gc.run(true);
			Gc.run(false);
		}
		
		ResourceServer.removeDisposed();
		RenderingServer.dispose();
		window.dispose();
		DisplayServer.dispose();
		AudioServer.dispose();
	}
}
#else
class Application {
	public function new() {}
}
#end