package vortex.utilities;

enum abstract Axes(String) {
	var X = "x";
	var Y = "y";
	var XY = "xy";
	var NONE = "none";

	/**
	 * Whether the horizontal axis is anebled
	 */
	public var x(get, never):Bool;

	/**
	 * Whether the vertical axis is anebled
	 */
	public var y(get, never):Bool;

	/**
	 * Returns a string representation of the axes.
	 */
	public function toString():String {
		return this;
	}

	public static function fromBools(x:Bool, y:Bool):Axes {
        if(x && y)
            return XY;
        else if(x)
            return X;
        else if(y)
            return Y;

		return NONE;
	}

    @:from
	public static function fromString(axes:String):Axes {
		return switch(axes.toLowerCase()) {
			case "x": X;
			case "y": Y;
			case "xy" | "yx" | "both": XY;
			case "none" | "" | null: NONE;
			default: throw "Invalid axes value: " + axes;
		}
	}

    // --------------- //
    // [ Private API ] //
    // --------------- //

    @:noCompletion
    private function get_x() {
		return this == X || this == XY;
	}

	@:noCompletion
    private function get_y() {
		return this == Y || this == XY;
	}
}
