package vortex.utils.math;

#if (!macro && !eval && cpp)
import sdl.Types.Rectangle as NativeIntRectangle;
#end

@:forward abstract Rectanglei(BaseRectanglei) to BaseRectanglei from BaseRectanglei {
	public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0) {
		this = new BaseRectanglei(x, y, width, height);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Rectanglei, b:Rectanglei) {
		return new Rectanglei(a.x + b.x, a.y + b.y, a.width + b.width, a.height + b.height);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addIntOp(a:Rectanglei, b:Int) {
		return new Rectanglei(a.x + b, a.y + b, a.width + b, a.height + b);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Rectanglei, b:Rectanglei) {
		return a.add(b.x, b.y, b.width, b.height);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Rectanglei, b:Rectanglei) {
		return new Rectanglei(a.x - b.x, a.y - b.y, a.width - b.width, a.height - b.height);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractIntOp(a:Rectanglei, b:Int) {
		return new Rectanglei(a.x - b, a.y - b, a.width - b, a.height - b);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Rectanglei, b:Rectanglei) {
		return a.subtract(b.x, b.y, b.width, b.height);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Rectanglei, b:Rectanglei) {
		return new Rectanglei(a.x * b.x, a.y * b.y, a.width * b.width, a.height * b.height);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyIntOp(a:Rectanglei, b:Int) {
		return new Rectanglei(a.x * b, a.y * b, a.width * b, a.height * b);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Rectanglei, b:Rectanglei) {
		return a.multiply(b.x, b.y, b.width, b.height);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Rectanglei, b:Rectanglei) {
		return new Rectanglei(Math.floor(a.x / b.x), Math.floor(a.y / b.y), Math.floor(a.width / b.width), Math.floor(a.height / b.height));
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideIntOp(a:Rectanglei, b:Int) {
		return new Rectanglei(Math.floor(a.x / b), Math.floor(a.y / b), Math.floor(a.width / b), Math.floor(a.height / b));
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Rectanglei, b:Rectanglei) {
		return a.divide(b.x, b.y, b.width, b.height);
	}

	@:from
	private static inline function fromFEquivalent(a:Rectangle) {
		return new Rectanglei(Math.floor(a.x), Math.floor(a.y), Math.floor(a.width), Math.floor(a.height));
	}
}

/**
 * A simple class to store 2D X, Y, width, and height values.
 */
class BaseRectanglei {
	/**
	 * The X value of this rectangle.
	 */
	public var x(default, set):Int;

	/**
	 * The Y value of this rectangle.
	 */
	public var y(default, set):Int;

	/**
	 * The width of this rectangle.
	 */
	public var width(default, set):Int;

	/**
	 * The height of this rectangle.
	 */
	public var height(default, set):Int;

	/**
	 * Returns a new `Rectangle`.
	 * 
	 * @param x  The X value of this rectangle.
	 * @param y  The Y value of this rectangle.
	 * @param width   The width of this rectangle.
	 * @param height  The height of this rectangle.
	 */
	public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0) {
		@:bypassAccessor this.x = x;
		@:bypassAccessor this.y = y;
		@:bypassAccessor this.width = width;
		@:bypassAccessor this.height = height;
		#if (!macro && !eval && cpp)
		_rect.x = x;
		_rect.y = y;
		_rect.w = width;
		_rect.h = height;
		#end
	}

	/**
	 * Sets the values of this rectangle.
	 * 
	 * @param x       The X value of this rectangle.
	 * @param y       The Y value of this rectangle.
	 * @param width   The width of this rectangle.
	 * @param height  The height of this rectangle.
	 */
	public function set(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0) {
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
	public function add(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0) {
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
	public function subtract(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0) {
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
	public function multiply(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0) {
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
	public function divide(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0) {
		this.x = Math.floor(this.x / x);
		this.y = Math.floor(this.y / y);
		this.width = Math.floor(this.width / width);
		this.height = Math.floor(this.height / height);
		return this;
	}

	/**
	 * Copies the values from another rectangle
	 * onto this one.
	 */
	public function copyFrom(rect:Rectanglei) {
		x = rect.x;
		y = rect.y;
		width = rect.width;
		height = rect.height;
		return this;
	}

	// ##==-- Privates --==## //
	private var _onChange:(x:Int, y:Int, width:Int, height:Int) -> Void;

	#if (!macro && !eval && cpp)
	private var _rect:NativeIntRectangle = NativeIntRectangle.create(0, 0, 0, 0);
	#end

	@:noCompletion
	private function set_x(value:Int):Int {
		#if (!macro && !eval && cpp)
		_rect.x = value;
		#end
		if (_onChange != null)
			_onChange(value, y, width, height);
		return x = value;
	}

	@:noCompletion
	private function set_y(value:Int):Int {
		#if (!macro && !eval && cpp)
		_rect.y = value;
		#end
		if (_onChange != null)
			_onChange(x, value, width, height);
		return y = value;
	}

	@:noCompletion
	private function set_width(value:Int):Int {
		#if (!macro && !eval && cpp)
		_rect.w = value;
		#end
		if (_onChange != null)
			_onChange(x, y, value, height);
		return width = value;
	}

	@:noCompletion
	private function set_height(value:Int):Int {
		#if (!macro && !eval && cpp)
		_rect.h = value;
		#end
		if (_onChange != null)
			_onChange(x, y, width, value);
		return height = value;
	}
}
