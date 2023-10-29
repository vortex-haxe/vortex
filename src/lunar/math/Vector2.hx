package lunar.math;

import sdl.SDL.Point;

@:forward abstract Vector2(BaseVector2) to BaseVector2 from BaseVector2 {
    public inline function new(x:Float = 0, y:Float = 0) {
        this = new BaseVector2(x, y);
    }

    @:noCompletion
    @:op(A + B)
    private static inline function addOp(a:Vector2, b:Vector2) {
        return new Vector2(
            a.x + b.x,
            a.y + b.y
        );
    }

    @:noCompletion
    @:op(A += B)
    private static inline function addEqualOp(a:Vector2, b:Vector2) {
        return a.add(
            b.x,
            b.y
        );
    }

    @:noCompletion
    @:op(A - B)
    private static inline function subtractOp(a:Vector2, b:Vector2) {
        return new Vector2(
            a.x - b.x,
            a.y - b.y
        );
    }

    @:noCompletion
    @:op(A -= B)
    private static inline function subtractEqualOp(a:Vector2, b:Vector2) {
        return a.subtract(
            b.x,
            b.y
        );
    }

    @:noCompletion
    @:op(A * B)
    private static inline function multiplyOp(a:Vector2, b:Vector2) {
        return new Vector2(
            a.x * b.x,
            a.y * b.y
        );
    }

    @:noCompletion
    @:op(A *= B)
    private static inline function multiplyEqualOp(a:Vector2, b:Vector2) {
        return a.multiply(
            b.x,
            b.y
        );
    }

    @:noCompletion
    @:op(A / B)
    private static inline function divideOp(a:Vector2, b:Vector2) {
        return new Vector2(
            a.x / b.x,
            a.y / b.y
        );
    }

    @:noCompletion
    @:op(A /= B)
    private static inline function divideEqualOp(a:Vector2, b:Vector2) {
        return a.divide(
            b.x,
            b.y
        );
    }
}

/**
 * A simple class to store 2D X and Y values.
 */
class BaseVector2 {
	/**
	 * The X value of this vector.
	 */
	public var x(default, set):Float;

	/**
	 * The Y value of this vector.
	 */
	public var y(default, set):Float;

	/**
	 * Returns a new `Vector2`.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 */
	public function new(x:Float = 0, y:Float = 0) {
		set(x, y);
	}

	/**
	 * Sets the values of this vector.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 */
	public function set(x:Float = 0, y:Float = 0) {
		this.x = x;
		this.y = y;
		return this;
	}

	/**
	 * Adds to the values of this vector with given values.
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
	 * Subtracts the values of this vector by given values.
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
	 * Multiplies the values of this vector with given values.
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
	 * Divides the values of this vector by given values.
	 * 
	 * @param x  The X value to divide.
	 * @param y  The Y value to divide.
	 */
	public function divide(x:Float = 0, y:Float = 0) {
		this.x /= x;
		this.y /= y;
		return this;
	}
	
	//##==-- Privates --==##//
	private var _point:Point = Point.create(0, 0);

	@:noCompletion
	private inline function set_x(value:Float):Float {
		_point.x = Std.int(value);
		return x = value;
	}

	@:noCompletion
	private inline function set_y(value:Float):Float {
		_point.y = Std.int(value);
		return y = value;
	}
}