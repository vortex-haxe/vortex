package vortex.utils.math;

@:forward abstract Vector4i(BaseVector4i) to BaseVector4i from BaseVector4i {
	public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0) {
		this = new BaseVector4i(x, y, width, height);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Vector4i, b:Vector4i) {
		return new Vector4i(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addIntOp(a:Vector4i, b:Int) {
		return new Vector4i(a.x + b, a.y + b, a.z + b, a.w + b);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Vector4i, b:Vector4i) {
		return a.add(b.x, b.y, b.z, b.w);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Vector4i, b:Vector4i) {
		return new Vector4i(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractIntOp(a:Vector4i, b:Int) {
		return new Vector4i(a.x - b, a.y - b, a.z - b, a.w - b);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Vector4i, b:Vector4i) {
		return a.subtract(b.x, b.y, b.z, b.w);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Vector4i, b:Vector4i) {
		return new Vector4i(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function addMultiplyOp(a:Vector4i, b:Int) {
		return new Vector4i(a.x * b, a.y * b, a.z * b, a.w * b);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Vector4i, b:Vector4i) {
		return a.multiply(b.x, b.y, b.z, b.w);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Vector4i, b:Vector4i) {
		return new Vector4i(Math.floor(a.x / b.x), Math.floor(a.y / b.y), Math.floor(a.z / b.z), Math.floor(a.w / b.w));
	}

	@:noCompletion
	@:op(A / B)
	private static inline function addDivideOp(a:Vector4i, b:Int) {
		return new Vector4i(Math.floor(a.x / b), Math.floor(a.y / b), Math.floor(a.z / b), Math.floor(a.w / b));
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Vector4i, b:Vector4i) {
		return a.divide(b.x, b.y, b.z, b.w);
	}

	@:from
	private static inline function fromFEquivalent(a:Vector4) {
		return new Vector4i(Math.floor(a.x), Math.floor(a.y), Math.floor(a.z), Math.floor(a.w));
	}
}

/**
 * A simple class to store 3D X, Y and Z values.
 */
class BaseVector4i {
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
	 * The W value of this vector.
	 */
	public var w(default, set):Int;

	/**
	 * Returns a new `Vector4i`.
	 * 
	 * @param x  The X value of this vector.
	 * @param y  The Y value of this vector.
	 * @param z  The Z value of this vector.
	 * @param w  The w value of this vector.
	 */
	public function new(x:Int = 0, y:Int = 0, z:Int = 0, w:Int = 0) {
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
	public function set(x:Int = 0, y:Int = 0, z:Int = 0, w:Int = 0) {
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
	public function add(x:Int = 0, y:Int = 0, z:Int = 0, w:Int = 0) {
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
	public function subtract(x:Int = 0, y:Int = 0, z:Int = 0, w:Int = 0) {
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
	public function multiply(x:Int = 0, y:Int = 0, z:Int = 0, w:Int = 0) {
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
	public function divide(x:Int = 0, y:Int = 0, z:Int = 0, w:Int = 0) {
		@:bypassAccessor this.x = Math.floor(this.x / x);
		@:bypassAccessor this.y = Math.floor(this.y / y);
		@:bypassAccessor this.z = Math.floor(this.z / z);
		@:bypassAccessor this.w = Math.floor(this.w / w);
		if (_onChange != null)
			_onChange(this.x, this.y, this.z, this.w);
		return this;
	}

	// ##==-- Privates --==## //
	private var _onChange:(x:Int, y:Int, z:Int, w:Int) -> Void;

	@:noCompletion
	private function set_x(value:Int):Int {
		if (_onChange != null)
			_onChange(value, y, z, w);
		return x = value;
	}

	@:noCompletion
	private function set_y(value:Int):Int {
		if (_onChange != null)
			_onChange(x, value, z, w);
		return y = value;
	}

	@:noCompletion
	private function set_z(value:Int):Int {
		if (_onChange != null)
			_onChange(x, y, value, w);
		return z = value;
	}

	@:noCompletion
	private function set_w(value:Int):Int {
		if (_onChange != null)
			_onChange(x, y, z, value);
		return w = value;
	}
}
