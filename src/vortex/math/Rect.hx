package vortex.math;

import vortex.utilities.Pool;

/**
 * Simple 2-dimensional rectangle class.
 * 
 * ## Pooling
 * To avoid creating new instances unnecessarily, rects can be recycled
 * for later use. Rather than creating a new instance directly, call
 * `Rect.get(x, y)` and it will retrieve a rect from the pool, if
 * one exists, otherwise it will create a new instance. Similarly, when
 * you're done using a rect, call `myRect.put()` to place it back.
 * 
 * ## Weak rects
 * Weak rects are rects meant for a singular use, rather than calling
 * `put` on every rect you `get`, you can create a weak rect, and have
 * it already back in the pool once you are done with it.
 * 
 * Otherwise, the remaining rects will become garbage, adding to the
 * heap, potentially triggering a garbage collection when you don't want one.
 */
 @:forward abstract Rect(BaseRect) to BaseRect from BaseRect {
	public static var ZERO(default, never):Rect = new Rect(0, 0, 0, 0);
	public static var ONE(default, never):Rect = new Rect(0, 0, 0, 0);

    @:noCompletion
	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this = new BaseRect(x, y, width, height);
	}

    /**
     * Returns a recycled or new `Rect`.
     * 
     * Make sure to `put()` it back into the pool
     * once you're done with it.
     * 
     * @param  x       The X value of this rect.
     * @param  y       The Y value of this rect.
     * @param  width   The width of this rect.
     * @param  height  The height of this rect.
     */
    public static function get(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):Rect {
        return BaseRect.get(x, y);
    }

    /**
     * Returns a recycled or new `Rect`.
     * 
     * The returned rect is meant for a singular use,
     * and will already be back in the pool by the time
     * you are done with it.
     * 
     * @param  x       The X value of this rect.
     * @param  y       The Y value of this rect.
     * @param  width   The width of this rect.
     * @param  height  The height of this rect.
     */
    public static function weak(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):Rect {
        return BaseRect.weak(x, y, width, height);
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Rect, b:Rect) {
		return new Rect(a.x + b.x, a.y + b.y, a.width + b.width, a.height + b.height);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addFloatOp(a:Rect, b:Float) {
		return new Rect(a.x + b, a.y + b, a.width + b, a.height + b);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Rect, b:Rect) {
		return a.add(b.x, b.y, b.width, b.height);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualFloatOp(a:Rect, b:Float) {
		return a.add(b, b, b, b);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Rect, b:Rect) {
		return new Rect(a.x - b.x, a.y - b.y, a.width - b.width, a.height - b.height);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractFloatOp(a:Rect, b:Float) {
		return new Rect(a.x - b, a.y - b, a.width - b, a.height - b);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Rect, b:Rect) {
		return a.subtract(b.x, b.y, b.width, b.height);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualFloatOp(a:Rect, b:Float) {
		return a.subtract(b, b, b, b);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Rect, b:Rect) {
		return new Rect(a.x * b.x, a.y * b.y, a.width * b.width, a.height * b.height);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyFloatOp(a:Rect, b:Float) {
		return new Rect(a.x * b, a.y * b, a.width * b, a.height * b);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Rect, b:Rect) {
		return a.multiply(b.x, b.y, b.width, b.height);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualFloatOp(a:Rect, b:Float) {
		return a.multiply(b, b, b, b);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Rect, b:Rect) {
		return new Rect(a.x / b.x, a.y / b.y, a.width / b.width, a.height / b.height);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function addDivideOp(a:Rect, b:Float) {
		return new Rect(a.x / b, a.y / b, a.width / b, a.height / b);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Rect, b:Rect) {
		return a.divide(b.x, b.y, b.width, b.height);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualFloatOp(a:Rect, b:Float) {
		return a.divide(b, b, b, b);
	}
}

/**
 * A simple class to store 2D X, Y, width, and height values.
 */
class BaseRect implements IPooled {
	/**
	 * The X value of this rectangle.
	 */
	public var x(default, set):Float;

	/**
	 * The Y value of this rectangle.
	 */
	public var y(default, set):Float;

	/**
	 * The width of this rectangle.
	 */
	public var width(default, set):Float;

	/**
	 * The height of this rectangle.
	 */
	public var height(default, set):Float;

    /**
	 * The right side of this rectangle.
	 */
	public var right(get, never):Float;

	/**
	 * The bottom side of this rectangle.
	 */
	public var bottom(get, never):Float;

	/**
	 * Returns a new `BaseRect`.
	 * 
	 * @param x  The X value of this rectangle.
	 * @param y  The Y value of this rectangle.
	 * @param width   The width of this rectangle.
	 * @param height  The height of this rectangle.
	 */
    @:noCompletion
	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		set(x, y, width, height);
	}

    /**
     * Returns a recycled or new `BaseRect`.
     * 
     * Make sure to `put()` it back into the pool
     * once you're done with it.
     * 
     * @param  x       The X value of this rect.
     * @param  y       The Y value of this rect.
     * @param  width   The width of this rect.
     * @param  height  The height of this rect.
     */
    public static function get(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):BaseRect {
        final rect = _pool.get().set(x, y, width, height);
        rect._inPool = true;
        return rect;
    }

    /**
     * Returns a recycled or new `BaseRect`.
     * 
     * The returned rect is meant for a singular use,
     * and will already be back in the pool by the time
     * you are done with it.
     * 
     * @param  x       The X value of this rect.
     * @param  y       The Y value of this rect.
     * @param  width   The width of this rect.
     * @param  height  The height of this rect.
     */
    public static function weak(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0):BaseRect {
        final rect = get(x, y, width, height);
        rect._weak = true;
        return rect;
    }

	/**
	 * Sets the values of this rectangle.
	 * 
	 * @param x       The X value of this rectangle.
	 * @param y       The Y value of this rectangle.
	 * @param width   The width of this rectangle.
	 * @param height  The height of this rectangle.
	 */
	public function set(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		return this;
	}

	/**
	 * Adds to the values of this rectangle with given values.
	 * 
	 * @param x       The X value to add.
	 * @param y       The Y value to add.
	 * @param width   The width to add.
	 * @param height  The height to add.
	 */
	public function add(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this.x += x;
		this.y += y;
		this.width += width;
		this.height += height;
		return this;
	}

	/**
	 * Subtracts the values of this rectangle by given values.
	 * 
	 * @param x       The X value to subtract.
	 * @param y       The Y value to subtract.
	 * @param width   The width to subtract.
	 * @param height  The height to subtract.
	 */
	public function subtract(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this.x -= x;
		this.y -= y;
		this.width -= width;
		this.height -= height;
		return this;
	}

	/**
	 * Multiplies the values of this rectangle with given values.
	 * 
	 * @param x       The X value to multiply.
	 * @param y       The Y value to multiply.
	 * @param width   The width to multiply.
	 * @param height  The height to multiply.
	 */
	public function multiply(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this.x *= x;
		this.y *= y;
		this.width *= width;
		this.height *= height;
		return this;
	}

	/**
	 * Divides the values of this rectangle by given values.
	 * 
	 * @param x       The X value to divide.
	 * @param y       The Y value to divide.
	 * @param width   The width to divide.
	 * @param height  The height to divide.
	 */
	public function divide(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this.x /= x;
		this.y /= y;
		this.width /= width;
		this.height /= height;
		return this;
	}

	/**
	 * Copies the values from another rectangle
	 * onto this one.
	 */
	public function copyFrom(rect:Rect) {
		x = rect.x;
		y = rect.y;
		width = rect.width;
		height = rect.height;
		return this;
	}

	/**
	 * Returns a human-readable string
     * representation of this rect.
	 */
	public function toString():String {
        return '[Rect] (${x}, ${y}, ${width}, ${height})';
    }

    /**
     * Puts this Rect back into it's pool.
     */
    public function put():Void {
		if(!_inPool) {
			_inPool = true;
			_weak = false;
			_pool.put(this);
		}
    }

	/**
     * Puts this Rect back into it's pool if
	 * it is a weak Rect.
     */
	public function putWeak():Void {
		if(_weak)
			put();
	}

    /**
     * Necessary for `IDestroyable`.
     */
    public function destroy():Void {}

    // -------------- //
	// [ Public API ] //
    // -------------- //

    private static var _pool:Pool<BaseRect> = new Pool(BaseRect.new.bind(0, 0, 0, 0));
    
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

	@:noCompletion
	private function set_width(value:Float):Float {
		return width = value;
	}

	@:noCompletion
	private function set_height(value:Float):Float {
		return height = value;
	}

    @:noCompletion
	private function get_right():Float {
		return x + width;
	}

    @:noCompletion
	private function get_bottom():Float {
		return y + height;
	}
}