package vortex.system.frontend;

import canvas._backend.Logs;

/**
 * Accessed via `GlobalCtx`.
 */
class LogFrontEnd {
    public function new() {}

    /**
     * Logs any given data to the debugger and the console.
     * 
     * @param  data  The data to log.
     */
    public function add(data:Dynamic):Void {
        Logs.trace(Std.string(data), INFO);
    }

    /**
     * Logs any given data to the debugger and the console
     * as a warning.
     * 
     * @param  data  The data to log as a warning.
     */
    public function warn(data:Dynamic):Void {
        Logs.trace(Std.string(data), WARNING);
    }

    /**
     * Logs any given data to the debugger and the console
     * as an error.
     * 
     * @param  data  The data to log as an error.
     */
    public function error(data:Dynamic):Void {
        Logs.trace(Std.string(data), ERROR);
    }
}