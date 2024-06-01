package vortex;

import canvas.app.Application;

import vortex.display.Camera;
import vortex.system.frontend.*;
import vortex.system.scalemodes.*;

/**
 * A helper class for easily accessing values
 * from the global game context.
 */
@:allow(vortex.GameContext)
class GlobalCtx {
    /**
     * A reference to the global game context.
     */
    public static var game(default, null):GameContext;

    /**
     * The time since the last frame, in seconds.
     */
    public static var deltaTime(default, null):Float = 0;

    /**
     * The framerate the game will update at.
     */
    public static var updateFramerate(default, set):Int = 0;

    /**
     * The framerate the game will draw at.
     */
    public static var drawFramerate(default, set):Int = 0;

    /**
     * The width of the game area, in pixels.
     * 
     * NOTE: This value is read-only, use `resizeGame()`
     * to change this value!
     */
    @:allow(vortex.system.scalemodes)
    public static var width(default, null):Int = 0;
     
    /**
     * The height of the game area, in pixels.
     * 
     * NOTE: This value is read-only, use `resizeGame()`
     * to change this value!
     */
    @:allow(vortex.system.scalemodes)
    public static var height(default, null):Int = 0;

    /**
     * The first camera in the global camera list.
     */
    public static var camera:Camera;

    /**
     * The object responsible for handling how the
     * game scales according to the window.
     */
    public static var scaleMode(default, set):BaseScaleMode = new RatioScaleMode();

    /**
     * Helper for easily logging to the debugger
     * and the console.
     */
    public static var log(default, null):LogFrontEnd;

    /**
     * Helper for easily accessing and caching graphics.
     */
    public static var bitmap(default, null):BitmapFrontEnd;

    /**
     * Helper for easily accessing and adding cameras.
     */
    public static var cameras(default, null):CameraFrontEnd;

    /**
     * Resizes the game to the given width and height.
     * 
     * @param  width   The new width of the game area, in pixels.
     * @param  height  The new height of the game area, in pixels.
     */
    public static function resizeGame(width:Int, height:Int):Void {
        GlobalCtx.width = width;
        GlobalCtx.height = height;
        scaleMode.onMeasure(width, height);
    }

    /**
     * Resizes the window to the given width and height.
     * 
     * @param  width   The new width of the window, in pixels.
     * @param  height  The new height of the height, in pixels.
     */
    public static function resizeWindow(width:Int, height:Int):Void {
        final window = Application.current.window;
        window.size.set(width, height);
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private static var _updateFramerateFract:Float = 0;

    private static function _init(game:GameContext, width:Int, height:Int):Void {
        GlobalCtx.game = game;
        GlobalCtx.width = width;
        GlobalCtx.height = height;

        log = new LogFrontEnd();
        bitmap = new BitmapFrontEnd();
        cameras = new CameraFrontEnd();

        Application.current.window.onResize.add((width:Int, height:Int) -> {
            scaleMode.onMeasure(width, height);
        });
        scaleMode.onMeasure(width, height);
    }

    @:noCompletion
    private static function set_scaleMode(newScaleMode:BaseScaleMode):BaseScaleMode {
        if(scaleMode != null)
            scaleMode.destroy();
        
        final window = Application.current.window;
        newScaleMode.onMeasure(window.size.x, window.size.y);

        return scaleMode = newScaleMode;
    }

    @:noCompletion
    private static function set_updateFramerate(newFramerate:Int):Int {
        _updateFramerateFract = 1 / newFramerate;
        return updateFramerate = newFramerate;
    }

    @:noCompletion
    private static function set_drawFramerate(newFramerate:Int):Int {
        Application.current.window.frameRate = newFramerate;
        return drawFramerate = newFramerate;
    }
}