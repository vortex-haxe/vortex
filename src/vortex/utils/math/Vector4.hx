package vortex.utils.math;

@:forward abstract Vector4(BaseVector4) to BaseVector4 from BaseVector4 {
	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this = new BaseVector4(x, y, width, height);
	}

	@:noCompletion
	@:op(-A)
	private static inline function invert(a:Vector4) {
		return new Vector4(-a.x, -a.y, -a.z, -a.w);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Vector4, b:Vector4) {
		return new Vector4(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addFloatOp(a:Vector4, b:Float) {
		return new Vector4(a.x + b, a.y + b, a.z + b, a.w + b);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Vector4, b:Vector4) {
		return a.add(b.x, b.y, b.z, b.w);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualFloatOp(a:Vector4, b:Float) {
		return a.add(b, b, b, b);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Vector4, b:Vector4) {
		return new Vector4(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractFloatOp(a:Vector4, b:Float) {
		return new Vector4(a.x - b, a.y - b, a.z - b, a.w - b);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Vector4, b:Vector4) {
		return a.subtract(b.x, b.y, b.z, b.w);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualFloatOp(a:Vector4, b:Float) {
		return a.subtract(b, b, b, b);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Vector4, b:Vector4) {
		return new Vector4(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function addMultiplyOp(a:Vector4, b:Float) {
		return new Vector4(a.x * b, a.y * b, a.z * b, a.w * b);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Vector4, b:Vector4) {
		return a.multiply(b.x, b.y, b.z, b.w);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualFloatOp(a:Vector4, b:Float) {
		return a.multiply(b, b, b, b);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Vector4, b:Vector4) {
		return new Vector4(a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function addDivideOp(a:Vector4, b:Float) {
		return new Vector4(a.x / b, a.y / b, a.z / b, a.w / b);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Vector4, b:Vector4) {
		return a.divide(b.x, b.y, b.z, b.w);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualFloatOp(a:Vector4, b:Float) {
		return a.divide(b, b, b, b);
	}

	@:to
	private static inline function toIEquivalent(a:Vector4) {
		return new Vector4i(Math.floor(a.x), Math.floor(a.y), Math.floor(a.z), Math.floor(a.w));
	}
}

/**
 * A simple class to store 3D X, Y and Z values.
 */
class BaseVector4 {
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
	 * The W value of this vector.
	 */
	public var w(default, set):Float;

	/**
	 * Returns a new `Vector4`.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 * @param z  The Z value of this vector.
	 * @param w  The w value of this vector.
	 */
	public function new(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0) {
		@:bypassAccessor this.x = x;
		@:bypassAccessor this.y = y;
		@:bypassAccessor this.z = z;
		@:bypassAccessor this.w = w;
	}

	/**
	 * Sets the values of this vector.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 * @param z  The Z value of this vector.
	 * @param w  The W value of this vector.
	 */
	public function set(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0) {
		@:bypassAccessor this.x = x;
		@:bypassAccessor this.y = y;
		@:bypassAccessor this.z = z;
		@:bypassAccessor this.w = w;
		if (_onChange != null)
			_onChange(this.x, this.y, this.z, this.w);
		return this;
	}

	/**
	 * Adds to the values of this vector with given values.
	 * 
	 * @param x  The X value to add.
	 * @param y  The Y value to add.
	 * @param z  The Z value to add.
	 * @param w  The W value to add.
	 */
	public function add(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0) {
		@:bypassAccessor this.x += x;
		@:bypassAccessor this.y += y;
		@:bypassAccessor this.z += z;
		@:bypassAccessor this.w += w;
		if (_onChange != null)
			_onChange(this.x, this.y, this.z, this.w);
		return this;
	}

	/**
	 * Subtracts the values of this vector by given values.
	 * 
	 * @param x  The X value to subtract.
	 * @param y  The Y value to subtract.
	 * @param z  The Z value to subtract.
	 * @param w  The W value to subtract.
	 */
	public function subtract(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0) {
		@:bypassAccessor this.x -= x;
		@:bypassAccessor this.y -= y;
		@:bypassAccessor this.z -= z;
		@:bypassAccessor this.w -= w;
		if (_onChange != null)
			_onChange(this.x, this.y, this.z, this.w);
		return this;
	}

	/**
	 * Multiplies the values of this vector with given values.
	 * 
	 * @param x  The X value to multiply.
	 * @param y  The Y value to multiply.
	 * @param z  The Z value to multiply.
	 * @param w  The W value to multiply.
	 */
	public function multiply(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0) {
		@:bypassAccessor this.x *= x;
		@:bypassAccessor this.y *= y;
		@:bypassAccessor this.z *= z;
		@:bypassAccessor this.w *= w;
		if (_onChange != null)
			_onChange(this.x, this.y, this.z, this.w);
		return this;
	}

	/**
	 * Divides the values of this vector by given values.
	 * 
	 * @param x  The X value to divide.
	 * @param y  The Y value to divide.
	 * @param z  The Z value to divide.
	 * @param w  The W value to divide.
	 */
	public function divide(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0) {
		@:bypassAccessor this.x /= x;
		@:bypassAccessor this.y /= y;
		@:bypassAccessor this.z /= z;
		@:bypassAccessor this.w /= w;
		if (_onChange != null)
			_onChange(this.x, this.y, this.z, this.w);
		return this;
	}

	/**
	 * Copies the values from another Vector4
	 * onto this one.
	 */
	public function copyFrom(vec:Vector4) {
		x = vec.x;
		y = vec.y;
		z = vec.z;
		w = vec.w;
		return this;
	}

	// ##==-- Privates --==## //
	private var _onChange:(x:Float, y:Float, z:Float, w:Float) -> Void;

	@:noCompletion
	private function set_x(value:Float):Float {
		if (_onChange != null)
			_onChange(value, y, z, w);
		return x = value;
	}

	@:noCompletion
	private function set_y(value:Float):Float {
		if (_onChange != null)
			_onChange(x, value, z, w);
		return y = value;
	}

	@:noCompletion
	private function set_z(value:Float):Float {
		if (_onChange != null)
			_onChange(x, y, value, w);
		return z = value;
	}

	@:noCompletion
	private function set_w(value:Float):Float {
		if (_onChange != null)
			_onChange(x, y, z, value);
		return w = value;
	}
}
