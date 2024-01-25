package vortex.utils.engine;

/**
 * A collection of eases used for tweening.
 * 
 * @see https://github.com/HaxeFlixel/flixel/blob/master/flixel/tweens/FlxEase.hx
 */
class Ease {
	private static var PI2:Float = Math.PI / 2;
	private static var EL:Float = 2 * Math.PI / .45;
	private static var B1:Float = 1 / 2.75;
	private static var B2:Float = 2 / 2.75;
	private static var B3:Float = 1.5 / 2.75;
	private static var B4:Float = 2.5 / 2.75;
	private static var B5:Float = 2.25 / 2.75;
	private static var B6:Float = 2.625 / 2.75;
	private static var ELASTIC_AMPLITUDE:Float = 1;
	private static var ELASTIC_PERIOD:Float = 0.4;

	public static function LINEAR(t:Float):Float {
		return t;
	}

	public static function QUAD_IN(t:Float):Float {
		return t * t;
	}

	public static function QUAD_OUT(t:Float):Float {
		return -t * (t - 2);
	}

	public static function QUAD_IN_OUT(t:Float):Float {
		return t <= .5 ? t * t * 2 : 1 - (--t) * t * 2;
	}

	public static function CUBE_IN(t:Float):Float {
		return t * t * t;
	}

	public static function CUBE_OUT(t:Float):Float {
		return 1 + (--t) * t * t;
	}

	public static function CUBE_IN_OUT(t:Float):Float {
		return t <= .5 ? t * t * t * 4 : 1 + (--t) * t * t * 4;
	}

	public static function QUART_IN(t:Float):Float {
		return t * t * t * t;
	}

	public static function QUART_OUT(t:Float):Float {
		return 1 - (t -= 1) * t * t * t;
	}

	public static function QUART_IN_OUT(t:Float):Float {
		return t <= .5 ? t * t * t * t * 8 : (1 - (t = t * 2 - 2) * t * t * t) / 2 + .5;
	}

	public static function QUINT_IN(t:Float):Float {
		return t * t * t * t * t;
	}

	public static function QUINT_OUT(t:Float):Float {
		return (t = t - 1) * t * t * t * t + 1;
	}

	public static function QUINT_IN_OUT(t:Float):Float {
		return ((t *= 2) < 1) ? (t * t * t * t * t) / 2 : ((t -= 2) * t * t * t * t + 2) / 2;
	}

	public static function SMOOTH_STEP_IN(t:Float):Float {
		return 2 * SMOOTH_STEP_IN_OUT(t / 2);
	}

	public static function SMOOTH_STEP_OUT(t:Float):Float {
		return 2 * SMOOTH_STEP_IN_OUT(t / 2 + 0.5) - 1;
	}

	public static function SMOOTH_STEP_IN_OUT(t:Float):Float {
		return t * t * (t * -2 + 3);
	}

	public static function SMOOTHER_STEP_IN(t:Float):Float {
		return 2 * SMOOTHER_STEP_IN_OUT(t / 2);
	}

	public static function SMOOTHER_STEP_OUT(t:Float):Float {
		return 2 * SMOOTHER_STEP_IN_OUT(t / 2 + 0.5) - 1;
	}

	public static function SMOOTHER_STEP_IN_OUT(t:Float):Float {
		return t * t * t * (t * (t * 6 - 15) + 10);
	}

	public static function SINE_IN(t:Float):Float {
		return -Math.cos(PI2 * t) + 1;
	}

	public static function SINE_OUT(t:Float):Float {
		return Math.sin(PI2 * t);
	}

	public static function SINE_IN_OUT(t:Float):Float {
		return -Math.cos(Math.PI * t) / 2 + .5;
	}

	public static function BOUNCE_IN(t:Float):Float {
		return 1 - BOUNCE_OUT(1 - t);
	}

	public static function BOUNCE_OUT(t:Float):Float {
		if (t < B1)
			return 7.5625 * t * t;
		if (t < B2)
			return 7.5625 * (t - B3) * (t - B3) + .75;
		if (t < B4)
			return 7.5625 * (t - B5) * (t - B5) + .9375;
		return 7.5625 * (t - B6) * (t - B6) + .984375;
	}

	public static function BOUNCE_IN_OUT(t:Float):Float {
		return t < 0.5 ? (1 - BOUNCE_OUT(1 - 2 * t)) / 2 : (1 + BOUNCE_OUT(2 * t - 1)) / 2;
	}

	public static function CIRC_IN(t:Float):Float {
		return -(Math.sqrt(1 - t * t) - 1);
	}

	public static function CIRC_OUT(t:Float):Float {
		return Math.sqrt(1 - (t - 1) * (t - 1));
	}

	public static function CIRC_IN_OUT(t:Float):Float {
		return t <= .5 ? (Math.sqrt(1 - t * t * 4) - 1) / -2 : (Math.sqrt(1 - (t * 2 - 2) * (t * 2 - 2)) + 1) / 2;
	}

	public static function EXPO_IN(t:Float):Float {
		return Math.pow(2, 10 * (t - 1));
	}

	public static function EXPO_OUT(t:Float):Float {
		return -Math.pow(2, -10 * t) + 1;
	}

	public static function EXPO_IN_OUT(t:Float):Float {
		return t < .5 ? Math.pow(2, 10 * (t * 2 - 1)) / 2 : (-Math.pow(2, -10 * (t * 2 - 1)) + 2) / 2;
	}

	public static function BACK_IN(t:Float):Float {
		return t * t * (2.70158 * t - 1.70158);
	}

	public static function BACK_OUT(t:Float):Float {
		return 1 - (--t) * (t) * (-2.70158 * t - 1.70158);
	}

	public static function BACK_IN_OUT(t:Float):Float {
		t *= 2;
		if (t < 1)
			return t * t * (2.70158 * t - 1.70158) / 2;
		t--;
		return (1 - (--t) * (t) * (-2.70158 * t - 1.70158)) / 2 + .5;
	}

	public static function ELASTIC_IN(t:Float):Float {
		return -(ELASTIC_AMPLITUDE * Math.pow(2, 10 * (t -= 1)) * Math.sin((t - (ELASTIC_PERIOD / (2 * Math.PI) * Math.asin(1 / ELASTIC_AMPLITUDE))) * (2 * Math.PI) / ELASTIC_PERIOD));
	}

	public static function ELASTIC_OUT(t:Float):Float {
		return (ELASTIC_AMPLITUDE * Math.pow(2, -10 * t) * Math.sin((t - (ELASTIC_PERIOD / (2 * Math.PI) * Math.asin(1 / ELASTIC_AMPLITUDE))) * (2 * Math.PI) / ELASTIC_PERIOD) + 1);
	}

	public static function ELASTIC_IN_OUT(t:Float):Float {
		if (t < 0.5) {
			return -0.5 * (Math.pow(2, 10 * (t -= 0.5)) * Math.sin((t - (ELASTIC_PERIOD / 4)) * (2 * Math.PI) / ELASTIC_PERIOD));
		}
		return Math.pow(2, -10 * (t -= 0.5)) * Math.sin((t - (ELASTIC_PERIOD / 4)) * (2 * Math.PI) / ELASTIC_PERIOD) * 0.5 + 1;
	}
}
