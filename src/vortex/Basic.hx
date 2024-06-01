package vortex;

import vortex.utilities.DestroyUtil.IDestroyable;

/**
 * The most basic and bare-bones game object, mainly
 * used for plugins and internal classes.
 * 
 * For most things however you should extend `Object` instead.
 */
class Basic implements IDestroyable {
    /**
     * The container that this object resides within.
     * 
     * WARNING: This value may be `null`, which represents
     * this object being in no container!
     */
    public var container:Container = null;

    /**
     * Controls whether or not this object
     * can call `update()` in it's container.
     */
    public var active:Bool = true;

    /**
     * Controls whether or not this object
     * can call `draw()` in it's container.
     */
    public var visible:Bool = true;

    /**
     * Whether or not this object is considered to be alive.
     * 
     * Useful for player or enemy objects.
     */
    public var alive:Bool = true;

    /**
     * Makes a new `Basic` instance.
     */
    public function new() {}

    /**
     * Makes this object inactive and invisible.
     * 
     * Useful if you want to remove an object and
     * reuse it later.
     */
    public function kill():Void {
        alive = false;
    }

    /**
     * Makes this object active and visible.
     * 
     * Useful if you want to reuse a previously
     * removed object.
     */
    public function revive():Void {
        alive = true;
    }

    /**
     * Updates this object and all of it's properties.
     * 
     * @param  delta  The time since the last frame, in seconds.
     */
    public function update(delta:Float):Void {}

    /**
     * Draws this object onto the screen.
     */
    public function draw():Void {}

    /**
     * Destroys this object and all of it's values with it.
     * 
     * WARNING: Trying to use a destroyed object could
     * cause an unwanted crash!
     */
    public function destroy():Void {
        alive = false;
    }
}