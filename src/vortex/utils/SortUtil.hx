package vortex.utils;

import vortex.nodes.Node2D;

class SortUtil {
	public static final ASCENDING:Int = -1;
	public static final DESCENDING:Int = 1;

	/**
	 * You can use this function in Node2D.getChildren().sort() to sort Node2Ds by their y values.
	 */
	public static inline function byY(Order:Int, Obj1:Node2D, Obj2:Node2D):Int {
		return byValues(Order, Obj1.position.y, Obj2.position.y);
	}

	/**
	 * You can use this function as a backend to write a custom sorting function (see byY() for an example).
	 */
	public static inline function byValues(Order:Int, Value1:Float, Value2:Float):Int {
		var result:Int = 0;

		if (Value1 < Value2)
			result = Order;
		else if (Value1 > Value2)
			result = -Order;

		return result;
	}
}
