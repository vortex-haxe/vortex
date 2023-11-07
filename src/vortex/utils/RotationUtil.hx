package vortex.utils;

class RotationUtil {
	#if !macro
	/**
	 * Convert radians to degrees by multiplying it with this value.
	 */
	public static var TO_DEGREES:Float = 180 / Math.PI;

	 /**
	  * Convert degrees to radians by multiplying it with this value.
	  */
	public static var TO_RADIANS:Float = Math.PI / 180;
	#end
}