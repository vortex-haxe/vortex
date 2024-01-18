package vortex.backend;

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
     * Makes a new `Application`.
     */
    public function new() {
        meta = CFGParser.parse(ProjectMacro.getConfig());
        trace("Hello Application! :D");
    }
}