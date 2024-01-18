package vortex.backend;

import vortex.utils.math.Vector2i;

#if (!macro && !eval && cpp)
import sdl.SDL;
import sdl.Types;
#end

import vortex.backend.Window;
import vortex.utils.generic.CFGParser;
import vortex.utils.engine.Project.ProjectInfo;
import vortex.macros.ProjectMacro;

/**
 * The very base of your games!
 */
@:autoBuild(vortex.macros.ApplicationMacro.build())
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
     * Makes a new `Application`.
     */
    public function new() {
        self = this;
        meta = CFGParser.parse(ProjectMacro.getConfig());

        #if (!macro && !eval && cpp)
        SDL.init(VIDEO | EVENTS);

        window = new Window(meta.window.title, new Vector2i(WindowPos.CENTERED, WindowPos.CENTERED), new Vector2i().copyFrom(meta.window.size));
        window.dispose();

        SDL.quit();
        #end
    }
}