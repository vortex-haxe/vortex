package vortex.utils.math;

#if (!macro && !eval && cpp)
import sdl.SDL.Point;
#end

@:forward abstract Vector2i(BaseVector2i) to BaseVector2i from BaseVector2i {
	public inline function new(x:Int = 0, y:Int = 0) {
		this = new BaseVector2i(x, y);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Vector2i, b:Vector2i) {
		return new Vector2i(a.x + b.x, a.y + b.y);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addIntOp(a:Vector2i, b:Int) {
		return new Vector2i(a.x + b, a.y + b);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Vector2i, b:Vector2i) {
		return a.add(b.x, b.y);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Vector2i, b:Vector2i) {
		return new Vector2i(a.x - b.x, a.y - b.y);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractIntOp(a:Vector2i, b:Int) {
		return new Vector2i(a.x - b, a.y - b);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Vector2i, b:Vector2i) {
		return a.subtract(b.x, b.y);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Vector2i, b:Vector2i) {
		return new Vector2i(a.x * b.x, a.y * b.y);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyIntOp(a:Vector2i, b:Int) {
		return new Vector2i(a.x * b, a.y * b);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Vector2i, b:Vector2i) {
		return a.multiply(b.x, b.y);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Vector2i, b:Vector2i) {
		return new Vector2i(Math.floor(a.x / b.x), Math.floor(a.y / b.y));
	}
	
	@:noCompletion
	@:op(A / B)
	private static inline function divideIntOp(a:Vector2i, b:Int) {
		return new Vector2i(Math.floor(a.x / b), Math.floor(a.y / b));
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Vector2i, b:Vector2i) {
		return a.divide(b.x, b.y);
	}

	@:from
	private static inline function fromFEquivalent(a:Vector2) {
		return new Vector2i(Math.floor(a.x), Math.floor(a.y));
	}
}

/**
 * A simple class to store 2D X and Y values.
 */
class BaseVector2i {
	/**
	 * The X value of this vector.
	 */
	public var x(default, set):Int;

	/**
	 * The Y value of this vector.
	 */
	public var y(default, set):Int;

	/**
	 * Returns a new `Vector2i`.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 */
	public function new(x:Int = 0, y:Int = 0) {
		@:bypassAccessor this.x = x;
		@:bypassAccessor this.y = y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
		#end
	}

	/**
	 * Sets the values of this vector.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 */
	public function set(x:Int = 0, y:Int = 0) {
		@:bypassAccessor this.x = x;
		@:bypassAccessor this.y = y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
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
	public function add(x:Int = 0, y:Int = 0) {
		@:bypassAccessor this.x += x;
		@:bypassAccessor this.y += y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
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
	public function subtract(x:Int = 0, y:Int = 0) {
		@:bypassAccessor this.x -= x;
		@:bypassAccessor this.y -= y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
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
	public function multiply(x:Int = 0, y:Int = 0) {
		@:bypassAccessor this.x *= x;
		@:bypassAccessor this.y *= y;
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
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
	public function divide(x:Int = 0, y:Int = 0) {
		@:bypassAccessor this.x = Math.floor(this.x / x);
		@:bypassAccessor this.y = Math.floor(this.y / y);
		#if (!macro && !eval && cpp)
		_point.x = x;
		_point.y = y;
		#end
		if (_onChange != null)
			_onChange(this.x, this.y);
		return this;
	}

	// ##==-- Privates --==## //
	private var _onChange:(x:Int, y:Int) -> Void;

	#if (!macro && !eval && cpp)
	private var _point:Point = Point.create(0, 0);
	#end

	@:noCompletion
	private function set_x(value:Int):Int {
		#if (!macro && !eval && cpp)
		_point.x = value;
		#end
		if (_onChange != null)
			_onChange(value, y);
		return x = value;
	}

	@:noCompletion
	private function set_y(value:Int):Int {
		#if (!macro && !eval && cpp)
		_point.y = value;
		#end
		if (_onChange != null)
			_onChange(x, value);
		return y = value;
	}
}
