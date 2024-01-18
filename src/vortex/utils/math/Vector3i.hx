package vortex.utils.math;

@:forward abstract Vector3i(BaseVector3i) to BaseVector3i from BaseVector3i {
	public inline function new(x:Int = 0, y:Int = 0, z:Int = 0) {
		this = new BaseVector3i(x, y, z);
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
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Vector3i, b:Vector3i) {
		return a.multiply(b.x, b.y, b.z);
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

	@:from
	private static inline function fromFEquivalent(a:Vector3) {
		return new Vector3i(Math.floor(a.x), Math.floor(a.y), Math.floor(a.z));
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
