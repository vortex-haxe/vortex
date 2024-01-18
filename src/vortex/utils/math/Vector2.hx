package vortex.utils.math;

#if (!macro && !eval && cpp)
import sdl.SDL.Point;
import sdl.SDL.FPoint;
#end

@:forward abstract Vector2(BaseVector2) to BaseVector2 from BaseVector2 {
	public inline function new(x:Float = 0, y:Float = 0) {
		this = new BaseVector2(x, y);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Vector2, b:Vector2) {
		return new Vector2(a.x + b.x, a.y + b.y);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addFloatOp(a:Vector2, b:Float) {
		return new Vector2(a.x + b, a.y + b);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Vector2, b:Vector2) {
		return a.add(b.x, b.y);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Vector2, b:Vector2) {
		return new Vector2(a.x - b.x, a.y - b.y);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractFloatOp(a:Vector2, b:Float) {
		return new Vector2(a.x - b, a.y - b);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Vector2, b:Vector2) {
		return a.subtract(b.x, b.y);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Vector2, b:Vector2) {
		return new Vector2(a.x * b.x, a.y * b.y);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyFloatOp(a:Vector2, b:Float) {
		return new Vector2(a.x * b, a.y * b);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Vector2, b:Vector2) {
		return a.multiply(b.x, b.y);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Vector2, b:Vector2) {
		return new Vector2(a.x / b.x, a.y / b.y);
	}
	
	@:noCompletion
	@:op(A / B)
	private static inline function divideFloatOp(a:Vector2, b:Float) {
		return new Vector2(a.x / b, a.y / b);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Vector2, b:Vector2) {
		return a.divide(b.x, b.y);
	}

	@:to
	private static inline function toIEquivalent(a:Vector2) {
		return new Vector2i(Math.floor(a.x), Math.floor(a.y));
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
		@:bypassAccessor this.x = x;
		@:bypassAccessor this.y = y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
		_pointi.x = Math.floor(x);
		_pointi.y = Math.floor(y);
		#end
	}

	/**
	 * Sets the values of this vector.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 */
	public function set(x:Float = 0, y:Float = 0) {
		@:bypassAccessor this.x = x;
		@:bypassAccessor this.y = y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
		_pointi.x = Math.floor(x);
		_pointi.y = Math.floor(y);
		#end
		if (_onChange != null)
			_onChange(this.x, this.y);
		return this;
	}

	/**
	 * Adds to the values of this vector with given values.
	 * 
	 * @param x  The X value to add.
	 * @param y  The Y value to add.
	 */
	public function add(x:Float = 0, y:Float = 0) {
		@:bypassAccessor this.x += x;
		@:bypassAccessor this.y += y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
		_pointi.x = Math.floor(x);
		_pointi.y = Math.floor(y);
		#end
		if (_onChange != null)
			_onChange(this.x, this.y);
		return this;
	}

	/**
	 * Subtracts the values of this vector by given values.
	 * 
	 * @param x  The X value to subtract.
	 * @param y  The Y value to subtract.
	 */
	public function subtract(x:Float = 0, y:Float = 0) {
		@:bypassAccessor this.x -= x;
		@:bypassAccessor this.y -= y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
		_pointi.x = Math.floor(x);
		_pointi.y = Math.floor(y);
		#end
		if (_onChange != null)
			_onChange(this.x, this.y);
		return this;
	}

	/**
	 * Multiplies the values of this vector with given values.
	 * 
	 * @param x  The X value to multiply.
	 * @param y  The Y value to multiply.
	 */
	public function multiply(x:Float = 0, y:Float = 0) {
		@:bypassAccessor this.x *= x;
		@:bypassAccessor this.y *= y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
		_pointi.x = Math.floor(x);
		_pointi.y = Math.floor(y);
		#end
		if (_onChange != null)
			_onChange(this.x, this.y);
		return this;
	}

	/**
	 * Divides the values of this vector by given values.
	 * 
	 * @param x  The X value to divide.
	 * @param y  The Y value to divide.
	 */
	public function divide(x:Float = 0, y:Float = 0) {
		@:bypassAccessor this.x /= x;
		@:bypassAccessor this.y /= y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
		_pointi.x = Math.floor(x);
		_pointi.y = Math.floor(y);
		#end
		if (_onChange != null)
			_onChange(this.x, this.y);
		return this;
	}

	// ##==-- Privates --==## //
	private var _onChange:(x:Float, y:Float) -> Void;

	#if (!macro && !eval && cpp)
	private var _point:FPoint = FPoint.create(0, 0);
	private var _pointi:Point = Point.create(0, 0);
	#end

	@:noCompletion
	private function set_x(value:Float):Float {
		#if (!macro && !eval && cpp)
		_point.x = value;
		_pointi.x = Math.floor(value);
		#end
		if (_onChange != null)
			_onChange(value, y);
		return x = value;
	}

	@:noCompletion
	private function set_y(value:Float):Float {
		#if (!macro && !eval && cpp)
		_point.y = value;
		_pointi.y = Math.floor(value);
		#end
		if (_onChange != null)
			_onChange(x, value);
		return y = value;
	}
}
