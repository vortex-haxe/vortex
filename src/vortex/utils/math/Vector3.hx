package vortex.utils.math;

@:forward abstract Vector3(BaseVector3) to BaseVector3 from BaseVector3 {
	public static var ZERO(get, never):Vector3;
	public static var ONE(get, never):Vector3;

	public static var UP(get, never):Vector3;
	public static var DOWN(get, never):Vector3;
	public static var LEFT(get, never):Vector3;
	public static var RIGHT(get, never):Vector3;
	public static var FRONT(get, never):Vector3;
	public static var BACK(get, never):Vector3;

	public static var AXIS_X(get, never):Vector3;
	public static var AXIS_Y(get, never):Vector3;
	public static var AXIS_Z(get, never):Vector3;

	public inline function new(x:Float = 0, y:Float = 0, z:Float = 0) {
		this = new BaseVector3(x, y, z);
	}

	@:noCompletion
	@:op(-A)
	private static inline function invert(a:Vector3) {
		return new Vector3(-a.x, -a.y, -a.z);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Vector3, b:Vector3) {
		return new Vector3(a.x + b.x, a.y + b.y, a.z + b.z);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addFloatOp(a:Vector3, b:Float) {
		return new Vector3(a.x + b, a.y + b, a.z + b);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Vector3, b:Vector3) {
		return a.add(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualFloatOp(a:Vector3, b:Float) {
		return a.add(b, b, b);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Vector3, b:Vector3) {
		return new Vector3(a.x - b.x, a.y - b.y, a.z - b.z);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractFloatOp(a:Vector3, b:Float) {
		return new Vector3(a.x - b, a.y - b, a.z - b);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Vector3, b:Vector3) {
		return a.subtract(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualFloatOp(a:Vector3, b:Float) {
		return a.subtract(b, b, b);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Vector3, b:Vector3) {
		return new Vector3(a.x * b.x, a.y * b.y, a.z * b.z);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyFloatOp(a:Vector3, b:Float) {
		return new Vector3(a.x * b, a.y * b, a.z * b);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Vector3, b:Vector3) {
		return a.multiply(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualFloatOp(a:Vector3, b:Float) {
		return a.multiply(b, b, b);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Vector3, b:Vector3) {
		return new Vector3(a.x / b.x, a.y / b.y, a.z / b.z);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideFloatOp(a:Vector3, b:Float) {
		return new Vector3(a.x / b, a.y / b, a.z / b);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Vector3, b:Vector3) {
		return a.divide(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualFloatOp(a:Vector3, b:Float) {
		return a.divide(b, b, b);
	}

	@:to
	private static inline function toIEquivalent(a:Vector3) {
		return new Vector3i(Math.floor(a.x), Math.floor(a.y), Math.floor(a.z));
	}

	@:noCompletion
	private static inline function get_ZERO():Vector3 {
		return new Vector3(0, 0, 0);
	}

	@:noCompletion
	private static inline function get_ONE():Vector3 {
		return new Vector3(1, 1, 1);
	}

	@:noCompletion
	private static inline function get_UP():Vector3 {
		return new Vector3(0, -1, 0);
	}

	@:noCompletion
	private static inline function get_DOWN():Vector3 {
		return new Vector3(0, 1, 0);
	}

	@:noCompletion
	private static inline function get_LEFT():Vector3 {
		return new Vector3(-1, 0, 0);
	}

	@:noCompletion
	private static inline function get_RIGHT():Vector3 {
		return new Vector3(1, 0, 0);
	}

	@:noCompletion
	private static inline function get_FRONT():Vector3 {
		return new Vector3(0, 0, -1);
	}

	@:noCompletion
	private static inline function get_BACK():Vector3 {
		return new Vector3(0, 0, 1);
	}

	@:noCompletion
	private static inline function get_AXIS_X():Vector3 {
		return new Vector3(1, 0, 0);
	}
	@:noCompletion
	private static inline function get_AXIS_Y():Vector3 {
		return new Vector3(0, 1, 0);
	}
	@:noCompletion
	private static inline function get_AXIS_Z():Vector3 {
		return new Vector3(0, 0, 1);
	}
}

/**
 * A simple class to store 3D X, Y and Z values.
 */
class BaseVector3 {
	/**
	 * The X value of this vector.
	 */
	public var x(default, set):Float;

	/**
	 * The Y value of this vector.
	 */
	public var y(default, set):Float;

	/**
	 * The Z value of this vector.
	 */
	public var z(default, set):Float;

	/**
	 * Returns a new `Vector3`.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 * @param z  The Z value of this vector.
	 */
	public function new(x:Float = 0, y:Float = 0, z:Float = 0) {
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
	public function set(x:Float = 0, y:Float = 0, z:Float = 0) {
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
	public function add(x:Float = 0, y:Float = 0, z:Float = 0) {
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
	public function subtract(x:Float = 0, y:Float = 0, z:Float = 0) {
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
	public function multiply(x:Float = 0, y:Float = 0, z:Float = 0) {
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
	public function divide(x:Float = 0, y:Float = 0, z:Float = 0) {
		@:bypassAccessor this.x /= x;
		@:bypassAccessor this.y /= y;
		@:bypassAccessor this.z /= z;
		if (_onChange != null)
			_onChange(this.x, this.y, this.z);
		return this;
	}

	/**
	 * Copies the values from another Vector3
	 * onto this one.
	 */
	public function copyFrom(vec:Vector3) {
		x = vec.x;
		y = vec.y;
		z = vec.z;
		return this;
	}

	// ##==-- Privates --==## //
	private var _onChange:(x:Float, y:Float, z:Float) -> Void;

	@:noCompletion
	private function set_x(value:Float):Float {
		if (_onChange != null)
			_onChange(value, y, z);
		return x = value;
	}

	@:noCompletion
	private function set_y(value:Float):Float {
		if (_onChange != null)
			_onChange(x, value, z);
		return y = value;
	}

	@:noCompletion
	private function set_z(value:Float):Float {
		if (_onChange != null)
			_onChange(x, y, value);
		return z = value;
	}
}
