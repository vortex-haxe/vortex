package vortex.utils.math;

@:forward abstract Vector3i(BaseVector3i) to BaseVector3i from BaseVector3i {
	public static var ZERO(get, never):Vector3i;
	public static var ONE(get, never):Vector3i;

	public static var UP(get, never):Vector3i;
	public static var DOWN(get, never):Vector3i;
	public static var LEFT(get, never):Vector3i;
	public static var RIGHT(get, never):Vector3i;
	public static var FRONT(get, never):Vector3i;
	public static var BACK(get, never):Vector3i;

	public static var AXIS_X(get, never):Vector3i;
	public static var AXIS_Y(get, never):Vector3i;
	public static var AXIS_Z(get, never):Vector3i;

	public inline function new(x:Int = 0, y:Int = 0, z:Int = 0) {
		this = new BaseVector3i(x, y, z);
	}

	@:noCompletion
	@:op(-A)
	private static inline function invert(a:Vector3i) {
		return new Vector3i(-a.x, -a.y, -a.z);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Vector3i, b:Vector3i) {
		return new Vector3i(a.x + b.x, a.y + b.y, a.z + b.z);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addIntOp(a:Vector3i, b:Int) {
		return new Vector3i(a.x + b, a.y + b, a.z + b);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Vector3i, b:Vector3i) {
		return a.add(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualIntOp(a:Vector3i, b:Int) {
		return a.add(b, b, b);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualFloatOp(a:Vector3i, b:Float) {
		return a.add(Math.floor(b), Math.floor(b), Math.floor(b));
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Vector3i, b:Vector3i) {
		return new Vector3i(a.x - b.x, a.y - b.y, a.z - b.z);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractIntOp(a:Vector3i, b:Int) {
		return new Vector3i(a.x - b, a.y - b, a.z - b);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Vector3i, b:Vector3i) {
		return a.subtract(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualIntOp(a:Vector3i, b:Int) {
		return a.subtract(b, b, b);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualFloatOp(a:Vector3i, b:Float) {
		return a.subtract(Math.floor(b), Math.floor(b), Math.floor(b));
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Vector3i, b:Vector3i) {
		return new Vector3i(a.x * b.x, a.y * b.y, a.z * b.z);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyIntOp(a:Vector3i, b:Int) {
		return new Vector3i(a.x * b, a.y * b, a.z * b);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyFloatOp(a:Vector3i, b:Float) {
		return new Vector3i(Math.floor(a.x * b), Math.floor(a.y * b), Math.floor(a.z * b));
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Vector3i, b:Vector3i) {
		return a.multiply(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualIntOp(a:Vector3i, b:Int) {
		return a.multiply(b, b, b);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualFloatOp(a:Vector3i, b:Float) {
		return a.multiply(Math.floor(b), Math.floor(b), Math.floor(b));
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Vector3i, b:Vector3i) {
		return new Vector3i(Math.floor(a.x / b.x), Math.floor(a.y / b.y), Math.floor(a.z / b.z));
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideIntOp(a:Vector3i, b:Int) {
		return new Vector3i(Math.floor(a.x / b), Math.floor(a.y / b), Math.floor(a.z / b));
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Vector3i, b:Vector3i) {
		return a.divide(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualIntOp(a:Vector3i, b:Int) {
		return a.divide(b, b, b);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualFloatOp(a:Vector3i, b:Float) {
		return a.divide(Math.floor(b), Math.floor(b), Math.floor(b));
	}

	@:from
	private static inline function fromFEquivalent(a:Vector3) {
		return new Vector3i(Math.floor(a.x), Math.floor(a.y), Math.floor(a.z));
	}

	@:noCompletion
	private static inline function get_ZERO():Vector3i {
		return new Vector3i(0, 0, 0);
	}

	@:noCompletion
	private static inline function get_ONE():Vector3i {
		return new Vector3i(1, 1, 1);
	}

	@:noCompletion
	private static inline function get_UP():Vector3i {
		return new Vector3i(0, -1, 0);
	}

	@:noCompletion
	private static inline function get_DOWN():Vector3i {
		return new Vector3i(0, 1, 0);
	}

	@:noCompletion
	private static inline function get_LEFT():Vector3i {
		return new Vector3i(-1, 0, 0);
	}

	@:noCompletion
	private static inline function get_RIGHT():Vector3i {
		return new Vector3i(1, 0, 0);
	}

	@:noCompletion
	private static inline function get_FRONT():Vector3i {
		return new Vector3i(0, 0, -1);
	}

	@:noCompletion
	private static inline function get_BACK():Vector3i {
		return new Vector3i(0, 0, 1);
	}

	@:noCompletion
	private static inline function get_AXIS_X():Vector3i {
		return new Vector3i(1, 0, 0);
	}
	@:noCompletion
	private static inline function get_AXIS_Y():Vector3i {
		return new Vector3i(0, 1, 0);
	}
	@:noCompletion
	private static inline function get_AXIS_Z():Vector3i {
		return new Vector3i(0, 0, 1);
	}
}

/**
 * A simple class to store 3D X, Y and Z values.
 */
class BaseVector3i {
	/**
	 * The X value of this vector.
	 */
	public var x(default, set):Int;

	/**
	 * The Y value of this vector.
	 */
	public var y(default, set):Int;

	/**
	 * The Z value of this vector.
	 */
	public var z(default, set):Int;

	/**
	 * Returns a new `Vector3i`.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 * @param z  The Z value of this vector.
	 */
	public function new(x:Int = 0, y:Int = 0, z:Int = 0) {
		@:bypassAccessor this.x = x;
		@:bypassAccessor this.y = y;
		@:bypassAccessor this.z = z;
	}

	/**
	 * Sets the values of this vector.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 * @param z  The Z value of this vector.
	 */
	public function set(x:Int = 0, y:Int = 0, z:Int = 0) {
		@:bypassAccessor this.x = x;
		@:bypassAccessor this.y = y;
		@:bypassAccessor this.z = z;
		if (_onChange != null)
			_onChange(this.x, this.y, this.z);
		return this;
	}

	/**
	 * Adds to the values of this vector with given values.
	 * 
	 * @param x  The X value to add.
	 * @param y  The Y value to add.
	 * @param z  The Z value to add.
	 */
	public function add(x:Int = 0, y:Int = 0, z:Int = 0) {
		@:bypassAccessor this.x += x;
		@:bypassAccessor this.y += y;
		@:bypassAccessor this.z += z;
		if (_onChange != null)
			_onChange(this.x, this.y, this.z);
		return this;
	}

	/**
	 * Subtracts the values of this vector by given values.
	 * 
	 * @param x  The X value to subtract.
	 * @param y  The Y value to subtract.
	 * @param z  The Z value to subtract.
	 */
	public function subtract(x:Int = 0, y:Int = 0, z:Int = 0) {
		@:bypassAccessor this.x -= x;
		@:bypassAccessor this.y -= y;
		@:bypassAccessor this.z -= z;
		if (_onChange != null)
			_onChange(this.x, this.y, this.z);
		return this;
	}

	/**
	 * Multiplies the values of this vector with given values.
	 * 
	 * @param x  The X value to multiply.
	 * @param y  The Y value to multiply.
	 * @param z  The Z value to multiply.
	 */
	public function multiply(x:Int = 0, y:Int = 0, z:Int = 0) {
		@:bypassAccessor this.x *= x;
		@:bypassAccessor this.y *= y;
		@:bypassAccessor this.z *= z;
		if (_onChange != null)
			_onChange(this.x, this.y, this.z);
		return this;
	}

	/**
	 * Divides the values of this vector by given values.
	 * 
	 * @param x  The X value to divide.
	 * @param y  The Y value to divide.
	 * @param z  The Z value to divide.
	 */
	public function divide(x:Int = 0, y:Int = 0, z:Int = 0) {
		@:bypassAccessor this.x = Math.floor(this.x / x);
		@:bypassAccessor this.y = Math.floor(this.y / y);
		@:bypassAccessor this.z = Math.floor(this.z / z);
		if (_onChange != null)
			_onChange(this.x, this.y, this.z);
		return this;
	}

	/**
	 * Copies the values from another Vector3i
	 * onto this one.
	 */
	public function copyFrom(vec:Vector3i) {
		x = vec.x;
		y = vec.y;
		z = vec.z;
		return this;
	}

	// ##==-- Privates --==## //
	private var _onChange:(x:Int, y:Int, z:Int) -> Void;

	@:noCompletion
	private function set_x(value:Int):Int {
		if (_onChange != null)
			_onChange(value, y, z);
		return x = value;
	}

	@:noCompletion
	private function set_y(value:Int):Int {
		if (_onChange != null)
			_onChange(x, value, z);
		return y = value;
	}

	@:noCompletion
	private function set_z(value:Int):Int {
		if (_onChange != null)
			_onChange(x, y, value);
		return z = value;
	}
}
