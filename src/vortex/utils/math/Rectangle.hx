package vortex.utils.math;

#if (!macro && !eval && cpp)
import sdl.SDL.FRectangle as NativeRectangle;
import sdl.SDL.Rectangle as NativeIntRectangle;
#end

@:forward abstract Rectangle(BaseRectangle) to BaseRectangle from BaseRectangle {
	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this = new BaseRectangle(x, y, width, height);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addOp(a:Rectangle, b:Rectangle) {
		return new Rectangle(a.x + b.x, a.y + b.y, a.width + b.width, a.height + b.height);
	}

	@:noCompletion
	@:op(A + B)
	private static inline function addFloatOp(a:Rectangle, b:Float) {
		return new Rectangle(a.x + b, a.y + b, a.width + b, a.height + b);
	}

	@:noCompletion
	@:op(A += B)
	private static inline function addEqualOp(a:Rectangle, b:Rectangle) {
		return a.add(b.x, b.y, b.width, b.height);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractOp(a:Rectangle, b:Rectangle) {
		return new Rectangle(a.x - b.x, a.y - b.y, a.width - b.width, a.height - b.height);
	}

	@:noCompletion
	@:op(A - B)
	private static inline function subtractFloatOp(a:Rectangle, b:Float) {
		return new Rectangle(a.x - b, a.y - b, a.width - b, a.height - b);
	}

	@:noCompletion
	@:op(A -= B)
	private static inline function subtractEqualOp(a:Rectangle, b:Rectangle) {
		return a.subtract(b.x, b.y, b.width, b.height);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function multiplyOp(a:Rectangle, b:Rectangle) {
		return new Rectangle(a.x * b.x, a.y * b.y, a.width * b.width, a.height * b.height);
	}

	@:noCompletion
	@:op(A * B)
	private static inline function addMultiplyOp(a:Rectangle, b:Float) {
		return new Rectangle(a.x * b, a.y * b, a.width * b, a.height * b);
	}

	@:noCompletion
	@:op(A *= B)
	private static inline function multiplyEqualOp(a:Rectangle, b:Rectangle) {
		return a.multiply(b.x, b.y, b.width, b.height);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function divideOp(a:Rectangle, b:Rectangle) {
		return new Rectangle(a.x / b.x, a.y / b.y, a.width / b.width, a.height / b.height);
	}

	@:noCompletion
	@:op(A / B)
	private static inline function addDivideOp(a:Rectangle, b:Float) {
		return new Rectangle(a.x / b, a.y / b, a.width / b, a.height / b);
	}

	@:noCompletion
	@:op(A /= B)
	private static inline function divideEqualOp(a:Rectangle, b:Rectangle) {
		return a.divide(b.x, b.y, b.width, b.height);
	}

	@:to
	private static inline function toIEquivalent(a:Rectangle) {
		return new Rectanglei(Math.floor(a.x), Math.floor(a.y), Math.floor(a.width), Math.floor(a.height));
	}
}

/**
 * A simple class to store 2D X, Y, width, and height values.
 */
class BaseRectangle {
	/**
	 * The X value of this rectangle.
	 */
	public var x(default, set):Float;

	/**
	 * The Y value of this rectangle.
	 */
	public var y(default, set):Float;

	/**
	 * The width of this rectangle.
	 */
	public var width(default, set):Float;

	/**
	 * The height of this rectangle.
	 */
	public var height(default, set):Float;

	/**
	 * Returns a new `Rectangle`.
	 * 
	 * @param x  The X value of this rectangle.
	 * @param y  The Y value of this rectangle.
	 * @param width   The width of this rectangle.
	 * @param height  The height of this rectangle.
	 */
	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		@:bypassAccessor this.x = x;
		@:bypassAccessor this.y = y;
		@:bypassAccessor this.width = width;
		@:bypassAccessor this.height = height;
		#if (!macro && !eval && cpp)
		_rect.x = x;
		_rect.y = y;
		_rect.w = width;
		_rect.h = height;
		_recti.x = Math.floor(x);
		_recti.y = Math.floor(y);
		_recti.w = Math.floor(width);
		_recti.h = Math.floor(height);
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
	public function set(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
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
	public function add(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
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
	public function subtract(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
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
	public function multiply(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
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
	public function divide(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this.x /= x;
		this.y /= y;
		this.width /= width;
		this.height /= height;
		return this;
	}

	// ##==-- Privates --==## //
	private var _onChange:(x:Float, y:Float, width:Float, height:Float) -> Void;

	#if (!macro && !eval && cpp)
	private var _rect:NativeRectangle = NativeRectangle.create(0, 0, 0, 0);
	private var _recti:NativeIntRectangle = NativeIntRectangle.create(0, 0, 0, 0);
	#end

	@:noCompletion
	private function set_x(value:Float):Float {
		#if (!macro && !eval && cpp)
		_rect.x = value;
		_recti.x = Math.floor(value);
		#end
		if (_onChange != null)
			_onChange(value, y, width, height);
		return x = value;
	}

	@:noCompletion
	private function set_y(value:Float):Float {
		#if (!macro && !eval && cpp)
		_rect.y = value;
		_recti.y = Math.floor(value);
		#end
		if (_onChange != null)
			_onChange(x, value, width, height);
		return y = value;
	}

	@:noCompletion
	private function set_width(value:Float):Float {
		#if (!macro && !eval && cpp)
		_rect.w = value;
		_recti.w = Math.floor(value);
		#end
		if (_onChange != null)
			_onChange(x, y, value, height);
		return width = value;
	}

	@:noCompletion
	private function set_height(value:Float):Float {
		#if (!macro && !eval && cpp)
		_rect.h = value;
		_recti.h = Math.floor(value);
		#end
		if (_onChange != null)
			_onChange(x, y, width, value);
		return height = value;
	}
}
