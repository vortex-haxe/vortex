package vortex.math;

@:forward abstract Vector3(BaseVector3) to BaseVector3 from BaseVector3 {
	public inline function new(x:Float = 0, y:Float = 0, z:Float = 0) {
		this = new BaseVector3(x, y, z);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Vector3, b:Vector3) {
		return new Vector3(a.x + b.x, a.y + b.y, a.z + b.y);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Vector3, b:Vector3) {
		return a.add(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Vector3, b:Vector3) {
		return new Vector3(a.x - b.x, a.y - b.y, a.z - b.z);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Vector3, b:Vector3) {
		return a.subtract(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Vector3, b:Vector3) {
		return new Vector3(a.x * b.x, a.y * b.y, a.z * b.z);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Vector3, b:Vector3) {
		return a.multiply(b.x, b.y, b.z);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Vector3, b:Vector3) {
		return new Vector3(a.x / b.x, a.y / b.y, a.z / b.z);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Vector3, b:Vector3) {
		return a.divide(b.x, b.y, b.z);
	}
}

/**
 * A simple class to store 3D X, Y and Z values.
 */
@:allow(vortex.nodes.Window)
@:allow(vortex.nodes.display.Sprite)
@:allow(vortex.nodes.display.AnimatedSprite)
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
