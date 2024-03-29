package vortex.utils.math;

import vortex.utils.math.Rectangle;

/**
 * A class containing a set of math-related functions
 * that Haxe doesn't already have.
 * 
 * @see https://github.com/HaxeFlixel/flixel/blob/master/flixel/math/FlxMath.hx
 */
class MathUtil {
	/**
	 * Minimum value of a floating point number.
	 */
	public static inline var MIN_VALUE_FLOAT:Float = #if (js || ios) 0.0000000000000001 #else 5e-324 #end;

	/**
	 * Maximum value of a floating point number.
	 */
	public static inline var MAX_VALUE_FLOAT:Float = 1.79e+308;

	/**
	 * Minimum value of an integer.
	 */
	public static inline var MIN_VALUE_INT:Int = -MAX_VALUE_INT;

	/**
	 * Maximum value of an integer.
	 */
	public static inline var MAX_VALUE_INT:Int = 0x7FFFFFFF;

	/**
	 * Approximation of `Math.sqrt(2)`.
	 */
	public static inline var SQUARE_ROOT_OF_TWO:Float = 1.41421356237;

	/**
	 * Used to account for floating-point inaccuracies.
	 */
	public static inline var EPSILON:Float = 0.0000001;

	/**
	 * Round a decimal number to have reduced precision (less decimal numbers).
	 *
	 * ```haxe
	 * roundDecimal(1.2485, 2) = 1.25
	 * ```
	 *
	 * @param	Value		Any number.
	 * @param	Precision	Number of decimals the result should have.
	 * @return	The rounded value of that number.
	 */
	public static function roundDecimal(Value:Float, Precision:Int):Float {
		var mult:Float = 10 ^ Precision;
		return Math.fround(Value * mult) / mult;
	}

	/**
	 * Bound a number by a minimum and maximum. Ensures that this number is
	 * no smaller than the minimum, and no larger than the maximum.
	 * Leaving a bound `null` means that side is unbounded.
	 *
	 * @param	Value	Any number.
	 * @param	Min		Any number.
	 * @param	Max		Any number.
	 * @return	The bounded value of the number.
	 */
	public static inline function bound(Value:Float, ?Min:Float, ?Max:Float):Float {
		var lowerBound:Float = (Min != null && Value < Min) ? Min : Value;
		return (Max != null && lowerBound > Max) ? Max : lowerBound;
	}

	/**
	 * Bound a integer by a minimum and maximum. Ensures that this integer is
	 * no smaller than the minimum, and no larger than the maximum.
	 * Leaving a bound `null` means that side is unbounded.
	 *
	 * @param	Value	Any integer.
	 * @param	Min		Any integer.
	 * @param	Max		Any integer.
	 * @return	The bounded value of the integer.
	 */
	public static inline function boundInt(Value:Int, ?Min:Int, ?Max:Int):Int {
		var lowerBound:Int = (Min != null && Value < Min) ? Min : Value;
		return (Max != null && lowerBound > Max) ? Max : lowerBound;
	}

	/**
	 * Linearly interpolates between two values by the factor defined in weight. 
	 * To perform interpolation, weight should be between 0.0 and 1.0 (inclusive).
	 *  
	 * However, values outside this range are allowed and can be used to perform extrapolation. 
	 * If this is not desired, use bound() on the result of this function.
	 * 
	 * @param from The value to lerp from.
	 * @param to The value to lerp to.
	 * @param weight The value to lerp from.
	 */
	public static inline function lerp(from:Float, to:Float, weight:Float):Float {
		return from + weight * (to - from);
	}

	/**
	 * Checks if number is in defined range. A null bound means that side is unbounded.
	 *
	 * @param Value		Number to check.
	 * @param Min		Lower bound of range.
	 * @param Max 		Higher bound of range.
	 * @return Returns true if Value is in range.
	 */
	public static inline function inBounds(Value:Float, Min:Null<Float>, Max:Null<Float>):Bool {
		return (Min == null || Value >= Min) && (Max == null || Value <= Max);
	}

	/**
	 * Returns `true` if the given number is odd.
	 */
	public static inline function isOdd(n:Float):Bool {
		return (Std.int(n) & 1) != 0;
	}

	/**
	 * Returns `true` if the given number is even.
	 */
	public static inline function isEven(n:Float):Bool {
		return (Std.int(n) & 1) == 0;
	}

	/**
	 * Returns `-1` if `a` is smaller, `1` if `b` is bigger and `0` if both numbers are equal.
	 */
	public static function numericComparison(a:Float, b:Float):Int {
		if (b > a) {
			return -1;
		} else if (a > b) {
			return 1;
		}
		return 0;
	}

	/**
	 * Returns true if the given x/y coordinate is within the given rectangular block
	 *
	 * @param	pointX		The X value to test
	 * @param	pointY		The Y value to test
	 * @param	rectX		The X value of the region to test within
	 * @param	rectY		The Y value of the region to test within
	 * @param	rectWidth	The width of the region to test within
	 * @param	rectHeight	The height of the region to test within
	 *
	 * @return	true if pointX/pointY is within the region, otherwise false
	 */
	public static function pointInCoordinates(pointX:Float, pointY:Float, rectX:Float, rectY:Float, rectWidth:Float, rectHeight:Float):Bool {
		if (pointX >= rectX && pointX <= (rectX + rectWidth)) {
			if (pointY >= rectY && pointY <= (rectY + rectHeight)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Returns true if the given x/y coordinate is within the given rectangular block
	 *
	 * @param	pointX		The X value to test
	 * @param	pointY		The Y value to test
	 * @param	rect		The Rectangle to test within
	 * @return	true if pointX/pointY is within the Rectangle, otherwise false
	 */
	public static function pointInRectangle(pointX:Float, pointY:Float, rect:Rectangle):Bool {
		return pointX >= rect.x && pointX <= rect.width && pointY >= rect.y && pointY <= rect.height;
	}

	/**
	 * Adds the given amount to the value, but never lets the value
	 * go over the specified maximum or under the specified minimum.
	 *
	 * @param 	value 	The value to add the amount to
	 * @param 	amount 	The amount to add to the value
	 * @param 	max 	The maximum the value is allowed to be
	 * @param 	min 	The minimum the value is allowed to be
	 * @return The new value
	 */
	public static function maxAdd(value:Int, amount:Int, max:Int, min:Int = 0):Int {
		value += amount;

		if (value > max) {
			value = max;
		} else if (value <= min) {
			value = min;
		}

		return value;
	}

	/**
	 * Makes sure that value always stays between 0 and max,
	 * by wrapping the value around.
	 *
	 * @param 	value 	The value to wrap around
	 * @param 	min		The minimum the value is allowed to be
	 * @param 	max 	The maximum the value is allowed to be
	 * @return The wrapped value
	 */
	public static function wrap(value:Int, min:Int, max:Int):Int {
		var range:Int = max - min + 1;

		if (value < min)
			value += range * Std.int((min - value) / range + 1);

		return min + (value - min) % range;
	}

	/**
	 * Remaps a number from one range to another.
	 *
	 * @param 	value	The incoming value to be converted
	 * @param 	start1 	Lower bound of the value's current range
	 * @param 	stop1 	Upper bound of the value's current range
	 * @param 	start2  Lower bound of the value's target range
	 * @param 	stop2 	Upper bound of the value's target range
	 * @return The remapped value
	 */
	public static function remapToRange(value:Float, start1:Float, stop1:Float, start2:Float, stop2:Float):Float {
		return start2 + (value - start1) * ((stop2 - start2) / (stop1 - start1));
	}

	/**
	 * Finds the dot product value of two vectors
	 *
	 * @param	ax		Vector X
	 * @param	ay		Vector Y
	 * @param	bx		Vector X
	 * @param	by		Vector Y
	 *
	 * @return	Result of the dot product
	 */
	public static inline function dotProduct(ax:Float, ay:Float, bx:Float, by:Float):Float {
		return ax * bx + ay * by;
	}

	/**
	 * Returns the length of the given vector.
	 */
	public static inline function vectorLength(dx:Float, dy:Float):Float {
		return Math.sqrt(dx * dx + dy * dy);
	}

	/**
	 * Returns the amount of decimals a `Float` has.
	 */
	public static function getDecimals(n:Float):Int {
		var helperArray:Array<String> = Std.string(n).split(".");
		var decimals:Int = 0;

		if (helperArray.length > 1) {
			decimals = helperArray[1].length;
		}

		return decimals;
	}

	public static inline function equal(aValueA:Float, aValueB:Float, aDiff:Float = EPSILON):Bool {
		return Math.abs(aValueA - aValueB) <= aDiff;
	}

	/**
	 * Returns `-1` if the number is smaller than `0` and `1` otherwise
	 */
	public static inline function signOf(n:Float):Int {
		return (n < 0) ? -1 : 1;
	}

	/**
	 * Checks if two numbers have the same sign (using `MathUtil.signOf()`).
	 */
	public static inline function sameSign(a:Float, b:Float):Bool {
		return signOf(a) == signOf(b);
	}

	/**
	 * A faster but slightly less accurate version of `Math.sin()`.
	 * About 2-6 times faster with < 0.05% average error.
	 *
	 * @param	n	The angle in radians.
	 * @return	An approximated sine of `n`.
	 */
	public static inline function fastSin(n:Float):Float {
		n *= 0.3183098862; // divide by pi to normalize

		// bound between -1 and 1
		if (n > 1) {
			n -= (Math.ceil(n) >> 1) << 1;
		} else if (n < -1) {
			n += (Math.ceil(-n) >> 1) << 1;
		}

		// this approx only works for -pi <= rads <= pi, but it's quite accurate in this region
		if (n > 0) {
			return n * (3.1 + n * (0.5 + n * (-7.2 + n * 3.6)));
		} else {
			return n * (3.1 - n * (0.5 + n * (7.2 + n * 3.6)));
		}
	}

	/**
	 * A faster, but less accurate version of `Math.cos()`.
	 * About 2-6 times faster with < 0.05% average error.
	 *
	 * @param	n	The angle in radians.
	 * @return	An approximated cosine of `n`.
	 */
	public static inline function fastCos(n:Float):Float {
		return fastSin(n + 1.570796327); // sin and cos are the same, offset by pi/2
	}

	/**
	 * Hyperbolic sine.
	 */
	public static inline function sinh(n:Float):Float {
		return (Math.exp(n) - Math.exp(-n)) / 2;
	}

	/**
	 * Returns the bigger argument.
	 */
	public static inline function maxInt(a:Int, b:Int):Int {
		return (a > b) ? a : b;
	}

	/**
	 * Returns the smaller argument.
	 */
	public static inline function minInt(a:Int, b:Int):Int {
		return (a > b) ? b : a;
	}

	/**
	 * Returns the absolute integer value.
	 */
	public static inline function absInt(n:Int):Int {
		return (n > 0) ? n : -n;
	}
}
