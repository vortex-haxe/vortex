package vortex;

import vortex.math.Point;
import vortex.display.Camera;

import vortex.utilities.Axes;
import vortex.utilities.DestroyUtil;

/**
 * Your simple generic game object.
 * Can be used for several things such as players, enemies, UI, etc.
 * 
 * Includes 2D positional, sizing, and rendering data.
 */
class Entity implements IDestroyable {
    /**
     * The container that this entity resides within.
     */
    public var container:Container;

    /**
     * Controls whether or not this entity
     * can call `update()` in it's container.
     */
    public var active:Bool = true;

    /**
     * Controls whether or not this entity
     * can call `draw()` in it's container.
     */
    public var visible:Bool = true;

    /**
     * The X and Y coordinates of this entity, in pixels
     * starting from the X coord of it's container (Usually top left).
     */
    public var position:Point = Point.get();

    /**
     * The X and Y coordinates of this entity when rendered
     * onto the screen, in pixels.
     */
    @:isVar
    public var globalPosition(get, null):Point = Point.get();

    /**
     * The width and height of this entity, in pixels.
     */
    public var size:Point = Point.get();

    /**
     * The first camera in this entity's camera list.
     */
    public var camera(get, set):Camera;

    /**
     * A list of cameras that this entity will render to.
     */
    public var cameras(get, set):Array<Camera>;

    /**
     * Makes a new `Entity` instance.
     */
    public function new(x:Float = 0, y:Float = 0) {
        position.set(x, y);
    }

    /**
     * Makes this entity inactive and invisible.
     * 
     * Useful if you want to remove an entity and
     * reuse it later.
     */
    public function kill():Void {
        active = false;
        visible = false;
    }

    /**
     * Makes this entity active and visible.
     * 
     * Useful if you want to reuse a previously
     * removed entity.
     */
    public function revive():Void {
        active = true;
        visible = true;
    }

    /**
     * Updates this entity and all of it's properties.
     * 
     * @param  delta  The time since the last frame in seconds.
     */
    public function update(delta:Float):Void {}

    /**
     * Draws this entity onto the screen.
     */
    public function draw():Void {}

    /**
	 * Centers this `Entity` to the screen, either by the x axis, y axis, or both.
	 *
	 * @param  axes  On what axes to center the object (e.g. `X`, `Y`, `XY`) - default is both. 
	 */
	public function screenCenter(axes:Axes = XY):Entity {
		if(axes.x)
			position.x = (GlobalCtx.width - size.x) * 0.5;

		if(axes.y)
			position.y = (GlobalCtx.height - size.y) * 0.5;

		return this;
	}

    /**
     * Destroys this entity and all
     * of it's values with it.
     * 
     * WARNING: Trying to use a destroyed entity could
     * cause an unwanted crash!
     */
    public function destroy():Void {
        position = DestroyUtil.put(position);
        globalPosition = DestroyUtil.put(@:bypassAccessor globalPosition);
        size = DestroyUtil.put(size);
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private var _cameras:Array<Camera>;

    @:noCompletion
    private function get_globalPosition():Point {
        var containerOffX:Float = 0;
        var containerOffY:Float = 0;

        var parent:Entity = this;
        while(parent != null && parent.container != null) {
            parent = parent.container;
            containerOffX += parent.position.x;
            containerOffY += parent.position.y;
        }
        return globalPosition.set(
            position.x + containerOffX,
            position.y + containerOffY
        );
    }

    @:noCompletion
    private function get_camera():Camera {
        if(_cameras != null)
            return _cameras[0];

        _cameras = [GlobalCtx.camera];
        return _cameras[0];
    }

    @:noCompletion
    private function set_camera(newCamera:Camera):Camera {
        if(_cameras != null)
            return _cameras[0] = newCamera;

        _cameras = [newCamera];
        return _cameras[0];
    }

    @:noCompletion
    private function get_cameras():Array<Camera> {
        if(_cameras != null)
            return _cameras;

        _cameras = [GlobalCtx.camera];
        return _cameras;
    }

    @:noCompletion
    private function set_cameras(newCameras:Array<Camera>):Array<Camera> {
        _cameras = newCameras ?? [];
        return _cameras;
    }
}