package vortex.math;

import vortex.utilities.Pool;

/**
 * Simple 2-dimensional point class.
 * 
 * ## Pooling
 * To avoid creating new instances unnecessarily, points can be recycled
 * for later use. Rather than creating a new instance directly, call
 * `Point.get(x, y)` and it will retrieve a point from the pool, if
 * one exists, otherwise it will create a new instance. Similarly, when
 * you're done using a point, call `myPoint.put()` to place it back.
 * 
 * ## Weak points
 * Weak points are points meant for a singular use, rather than calling
 * `put` on every point you `get`, you can create a weak point, and have
 * it already back in the pool once you are done with it.
 * 
 * Otherwise, the remaining points will become garbage, adding to the
 * heap, potentially triggering a garbage collection when you don't want one.
 */
@:forward abstract Point(BasePoint) to BasePoint from BasePoint {
    public static var ZERO(default, never):Point = new Point(0, 0);
	public static var ONE(default, never):Point = new Point(1, 1);

	public static var UP(default, never):Point = new Point(0, -1);
	public static var DOWN(default, never):Point = new Point(0, 1);
	public static var LEFT(default, never):Point = new Point(-1, 0);
	public static var RIGHT(default, never):Point = new Point(1, 0);

	public static var AXIS_X(default, never):Point = new Point(1, 0);
	public static var AXIS_Y(default, never):Point = new Point(0, 1);

    @:noCompletion
    public inline function new(x:Float = 0, y:Float = 0) {
        this = new BasePoint(x, y);
    }

    /**
     * Returns a recycled or new `Point`.
     * 
     * Make sure to `put()` it back into the pool
     * once you're done with it.
     * 
     * @param x  The X value of this point.
     * @param y  The Y value of this point.
     */
    public static function get(x:Float = 0, y:Float = 0):Point {
        return BasePoint.get(x, y);
    }

    /**
     * Returns a recycled or new `Point`.
     * 
     * The returned point is meant for a singular use,
     * and will already be back in the pool by the time
     * you are done with it.
     * 
     * @param x  The X value of this point.
     * @param y  The Y value of this point.
     */
    public static function weak(x:Float = 0, y:Float = 0):Point {
        return BasePoint.weak(x, y);
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    @:noCompletion
    @:op(-A)
    private static inline function invert(a:Point) {
        return new Point(-a.x, -a.y);
    }

    @:noCompletion
    @:op(A + B)
    private static inline function addOp(a:Point, b:Point) {
        return new Point(a.x + b.x, a.y + b.y);
    }

    @:noCompletion
    @:op(A + B)
    private static inline function addFloatOp(a:Point, b:Float) {
        return new Point(a.x + b, a.y + b);
    }

    @:noCompletion
    @:op(A += B)
    private static inline function addEqualOp(a:Point, b:Point) {
        return a.add(b.x, b.y);
    }

    @:noCompletion
    @:op(A += B)
    private static inline function addEqualFloatOp(a:Point, b:Float) {
        return a.add(b, b);
    }

    @:noCompletion
    @:op(A - B)
    private static inline function subtractOp(a:Point, b:Point) {
        return new Point(a.x - b.x, a.y - b.y);
    }

    @:noCompletion
    @:op(A - B)
    private static inline function subtractFloatOp(a:Point, b:Float) {
        return new Point(a.x - b, a.y - b);
    }

    @:noCompletion
    @:op(A -= B)
    private static inline function subtractEqualOp(a:Point, b:Point) {
        return a.subtract(b.x, b.y);
    }

    @:noCompletion
    @:op(A -= B)
    private static inline function subtractEqualFloatOp(a:Point, b:Float) {
        return a.subtract(b, b);
    }

    @:noCompletion
    @:op(A * B)
    private static inline function multiplyOp(a:Point, b:Point) {
        return new Point(a.x * b.x, a.y * b.y);
    }

    @:noCompletion
    @:op(A * B)
    private static inline function multiplyFloatOp(a:Point, b:Float) {
        return new Point(a.x * b, a.y * b);
    }

    @:noCompletion
    @:op(A *= B)
    private static inline function multiplyEqualOp(a:Point, b:Point) {
        return a.multiply(b.x, b.y);
    }

    @:noCompletion
    @:op(A *= B)
    private static inline function multiplyEqualFloatOp(a:Point, b:Float) {
        return a.multiply(b, b);
    }

    @:noCompletion
    @:op(A / B)
    private static inline function divideOp(a:Point, b:Point) {
        return new Point(a.x / b.x, a.y / b.y);
    }
    
    @:noCompletion
    @:op(A / B)
    private static inline function divideFloatOp(a:Point, b:Float) {
        return new Point(a.x / b, a.y / b);
    }

    @:noCompletion
    @:op(A /= B)
    private static inline function divideEqualOp(a:Point, b:Point) {
        return a.divide(b.x, b.y);
    }

    @:noCompletion
    @:op(A /= B)
    private static inline function divideEqualFloatOp(a:Point, b:Float) {
        return a.divide(b, b);
    }
}

@:noDoc
@:noCompletion
class BasePoint implements IPooled {
    /**
     * The X value of this point.
     */
    public var x(default, set):Float;

    /**
     * The Y value of this point.
     */
    public var y(default, set):Float;

    /**
     * Returns a new `Point`.
     * 
     * @param x  The X value of this point.
     * @param y  The Y value of this point.
     */
    @:noCompletion
    public function new(x:Float = 0, y:Float = 0) {
        set(x, y);
    }

    /**
     * Returns a recycled or new `BasePoint`.
     * 
     * Make sure to `put()` it back into the pool
     * once you're done with it.
     * 
     * @param x  The X value of this point.
     * @param y  The Y value of this point.
     */
    public static function get(x:Float = 0, y:Float = 0):BasePoint {
        final point = _pool.get().set(x, y);
        point._inPool = true;
        return point;
    }

    /**
     * Returns a recycled or new `BasePoint`.
     * 
     * The returned point is meant for a singular use,
     * and will already be back in the pool by the time
     * you are done with it.
     * 
     * @param x  The X value of this point.
     * @param y  The Y value of this point.
     */
    public static function weak(x:Float = 0, y:Float = 0):BasePoint {
        final point = _pool.get().set(x, y);
        point._weak = true;
        return point;
    }

    /**
     * Sets the values of this point.
     * 
     * @param x  The X value of this point.
     * @param y  The Y value of this point.
     */
    public function set(x:Float = 0, y:Float = 0) {
        this.x = x;
        this.y = y;
        return this;
    }

    /**
     * Adds to the values of this point with given values.
     * 
     * @param x  The X value to add.
     * @param y  The Y value to add.
     */
    public function add(x:Float = 0, y:Float = 0) {
        this.x += x;
        this.y += y;
        return this;
    }

    /**
     * Subtracts the values of this point by given values.
     * 
     * @param x  The X value to subtract.
     * @param y  The Y value to subtract.
     */
    public function subtract(x:Float = 0, y:Float = 0) {
        this.x -= x;
        this.y -= y;
        return this;
    }

    /**
     * Multiplies the values of this point with given values.
     * 
     * @param x  The X value to multiply.
     * @param y  The Y value to multiply.
     */
    public function multiply(x:Float = 0, y:Float = 0) {
        this.x *= x;
        this.y *= y;
        return this;
    }

    /**
     * Divides the values of this point by given values.
     * 
     * @param x  The X value to divide.
     * @param y  The Y value to divide.
     */
    public function divide(x:Float = 0, y:Float = 0) {
        this.x /= x;
        this.y /= y;
        return this;
    }

    /**
     * Copies the values from another Point
     * onto this one.
     */
    public function copyFrom(vec:Point) {
        x = vec.x;
        y = vec.y;
        return this;
    }

    /**
     * Returns a human-readable string
     * representation of this point.
     */
    public function toString():String {
        return '[Point] (${x}, ${y})';
    }

    /**
     * Puts this point back into it's pool.
     */
    public function put():Void {
        if(!_inPool) {
			_inPool = true;
			_weak = false;
			_pool.put(this);
		}
    }

    /**
     * Puts this Point back into it's pool if
	 * it is a weak Point.
     */
	public function putWeak():Void {
		if(_weak)
			put();
	}

    /**
     * Necessary for `IDestroyable`.
     */
    public function destroy():Void {}

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private static var _pool:Pool<BasePoint> = new Pool(BasePoint.new.bind(0, 0));
    
    private var _weak:Bool = false;
    private var _inPool:Bool = false;

    @:noCompletion
    private function set_x(value:Float):Float {
        return x = value;
    }

    @:noCompletion
    private function set_y(value:Float):Float {
        return y = value;
    }
}