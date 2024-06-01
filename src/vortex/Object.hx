package vortex;

import vortex.math.Point;
import vortex.display.Camera;

import vortex.utilities.Axes;
import vortex.utilities.DestroyUtil;

/**
 * A simple and basic 2D game object.
 * Can be used for several things such as players, enemies, UI, etc.
 * 
 * Includes 2D positional, sizing, and rendering data.
 */
class Object extends Basic {
    /**
     * The X and Y coordinates of this object, in pixels
     * starting from the X coord of it's container (Usually top left).
     */
    public var position:Point = Point.get();

    /**
     * The X and Y coordinates of this object when rendered
     * onto the screen, in pixels.
     */
    @:isVar
    public var globalPosition(get, null):Point = Point.get();

    /**
     * The width and height of this object, in pixels.
     */
    public var size:Point = Point.get();

    /**
     * The first camera in this object's camera list.
     */
    public var camera(get, set):Camera;

    /**
     * A list of cameras that this object will render to.
     */
    public var cameras(get, set):Array<Camera>;

    /**
     * Makes a new `Object` instance.
     * 
     * @param  x  The X coordinate of this object on-screen.
     * @param  y  The Y coordinate of this object on-screen.
     */
    public function new(x:Float = 0, y:Float = 0) {
        super();
        position.set(x, y);
    }

    /**
	 * Centers this `Object` to the screen, either by the x axis, y axis, or both.
	 *
	 * @param  axes  On what axes to center the object (e.g. `X`, `Y`, `XY`) - default is both. 
	 */
	public function screenCenter(axes:Axes = XY):Object {
		if(axes.x)
			position.x = (GlobalCtx.width - size.x) * 0.5;

		if(axes.y)
			position.y = (GlobalCtx.height - size.y) * 0.5;

		return this;
	}

    /**
     * Destroys this object and all of it's values with it.
     * 
     * WARNING: Trying to use a destroyed object could
     * cause an unwanted crash!
     */
    override function destroy():Void {
        super.destroy();
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

        var parent:Object = this;
        while(parent != null && parent.container != null) {
            parent = cast parent.container;
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