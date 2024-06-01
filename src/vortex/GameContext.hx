package vortex;

import canvas.Canvas;
import canvas.utils.Assets;
import vortex.utilities.typelimit.NextState;

typedef GameSettings = {
    /**
     * The width of the game area, in pixels.
     */
    var width:Int;

    /**
     * The height of the game area, in pixels.
     */
    var height:Int;

    /**
     * The framerate the game should update at.
     * Anything equal to or below `0` means no limit.
     */
    var updateFramerate:Int;

    /**
     * The framerate the game should draw at.
     * Anything equal to or below `0` means no limit.
     */
    var drawFramerate:Int;

    /**
     * The initial state the game should boot up to.
     */
    var ?initialState:NextState;
}

/**
 * The `GameContext` is the absolute core of every game
 * made in Vortex, and is how you initialize your game.
 * 
 * Example initialization:
 * ```haxe
 * addChild(new GameContext({
 *     width: 640,
 *     height: 480, 
 *     updateFramerate: 60,
 *     drawFramerate: 60,
 *     initialState: PlayState.new
 * }));
 * ```
 * 
 * You shouldn't need to touch stuff in here directly, as
 * everything you need is available in `CtxGlobal`.
 */
@:allow(vortex.GlobalCtx)
class GameContext extends Canvas {
    /**
     * Makes and initializes a new `GameContext`.
     * 
     * @param  settings  Some settings to use when initializing the game.
     */
    public function new(settings:GameSettings) {
        super();

        GlobalCtx._init(this, settings.width, settings.height);

        GlobalCtx.updateFramerate = settings.updateFramerate;
        GlobalCtx.drawFramerate = settings.drawFramerate;

        _timeElapsed = _updateFpsFract;
        _nextState = settings.initialState ?? cast State.new;
        addedToParent.add(create);
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private var _state:State;
    private var _nextState:NextState;
    private var _timeElapsed:Float;
    private var _updateFpsFract:Float;

    private function create(_):Void {
        addedToParent.remove(create);

        switchState();
    }

    override function update(delta:Float):Void {
        _timeElapsed += delta;
        if(_timeElapsed >= GlobalCtx._updateFramerateFract) {
            // Update some global vars
            GlobalCtx.deltaTime = _timeElapsed;

            // Update all cameras
            GlobalCtx.cameras.update(_timeElapsed);
    
            // Update the current state if possible
            if(_state != null)
                _state.update(_timeElapsed);

            _timeElapsed %= delta;
        }
        super.update(delta);
    }

    override function draw():Void {
        // Clear all cameras
        GlobalCtx.cameras.clear();

        // Update the current state if possible
        if(_state != null)
            _state.draw();

        // Draw all cameras
        GlobalCtx.cameras.draw();

        super.draw();
    }

    private function switchState():Void {
        // Stop if there is no state to switch to
        if(_nextState == null)
            return;

        // Clear any cached assets before switching
        // to this new state
        GlobalCtx.bitmap.clear();
        // GlobalCtx.sound.clear(); // TODO: implement sound frontend

        // Destroy the old state (if possible)
        if(_state != null)
            _state.destroy();

        // Load the next state
        _state = _nextState.createInstance();
        _nextState = null;

        // Reset global camera list
        GlobalCtx.cameras.reset();

        // Tell the now-current state that it is ready
        _state.ready();
    }
}