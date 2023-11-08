package vortex.utils;

using StringTools;

/**
 * A simple class that holds RGB values for a color.
 * There are many preset colors available if you need them.
 * 
 * The preset colors have been taken from Godot Engine.
 * @see https://github.com/godotengine/godot/blob/master/core/math/color.cpp
 */
@:structInit
class Color {
	public static final ALICE_BLUE = Color.create(0xFFF0F8FF);
	public static final ANTIQUE_WHITE = Color.create(0xFFFAEBD7);
	public static final AQUA = Color.create(0xFF00FFFF);
	public static final AQUAMARINE = Color.create(0xFF7FFFD4);
	public static final AZURE = Color.create(0xFFF0FFFF);
	public static final BEIGE = Color.create(0xFFF5F5DC);
	public static final BISQUE = Color.create(0xFFFFE4C4);
	public static final BLACK = Color.create(0xFF000000);
	public static final BLANCHED_ALMOND = Color.create(0xFFFFEBCD);
	public static final BLUE = Color.create(0xFF0000FF);
	public static final BLUE_VIOLET = Color.create(0xFF8A2BE2);
	public static final BROWN = Color.create(0xFFA52A2A);
	public static final BURLYWOOD = Color.create(0xFFDEB887);
	public static final CADET_BLUE = Color.create(0xFF5F9EA0);
	public static final CHARTREUSE = Color.create(0xFF7FFF00);
	public static final CHOCOLATE = Color.create(0xFFD2691E);
	public static final CORAL = Color.create(0xFFFF7F50);
	public static final CORNFLOWER_BLUE = Color.create(0xFF6495ED);
	public static final CORNSILK = Color.create(0xFFFFF8DC);
	public static final CRIMSON = Color.create(0xFFDC143C);
	public static final CYAN = Color.create(0xFF00FFFF);
	public static final DARK_BLUE = Color.create(0xFF00008B);
	public static final DARK_CYAN = Color.create(0xFF008B8B);
	public static final DARK_GOLDENROD = Color.create(0xFFB8860B);
	public static final DARK_GRAY = Color.create(0xFFA9A9A9);
	public static final DARK_GREEN = Color.create(0xFF006400);
	public static final DARK_KHAKI = Color.create(0xFFBDB76B);
	public static final DARK_MAGENTA = Color.create(0xFF8B008B);
	public static final DARK_OLIVE_GREEN = Color.create(0xFF556B2F);
	public static final DARK_ORANGE = Color.create(0xFFFF8C00);
	public static final DARK_ORCHID = Color.create(0xFF9932CC);
	public static final DARK_RED = Color.create(0xFF8B0000);
	public static final DARK_SALMON = Color.create(0xFFE9967A);
	public static final DARK_SEA_GREEN = Color.create(0xFF8FBC8F);
	public static final DARK_SLATE_BLUE = Color.create(0xFF483D8B);
	public static final DARK_SLATE_GRAY = Color.create(0xFF2F4F4F);
	public static final DARK_TURQUOISE = Color.create(0xFF00CED1);
	public static final DARK_VIOLET = Color.create(0xFF9400D3);
	public static final DEEP_PINK = Color.create(0xFFFF1493);
	public static final DEEP_SKY_BLUE = Color.create(0xFF00BFFF);
	public static final DIM_GRAY = Color.create(0xFF696969);
	public static final DODGER_BLUE = Color.create(0xFF1E90FF);
	public static final FIREBRICK = Color.create(0xFFB22222);
	public static final FLORAL_WHITE = Color.create(0xFFFFFAF0);
	public static final FOREST_GREEN = Color.create(0xFF228B22);
	public static final FUCHSIA = Color.create(0xFFFF00FF);
	public static final GAINSBORO = Color.create(0xFFDCDCDC);
	public static final GHOST_WHITE = Color.create(0xFFF8F8FF);
	public static final GOLD = Color.create(0xFFFFD700);
	public static final GOLDENROD = Color.create(0xFFDAA520);
	public static final GRAY = Color.create(0xFFBEBEBE);
	public static final GREEN = Color.create(0xFF00FF00);
	public static final GREEN_YELLOW = Color.create(0xFFADFF2F);
	public static final HONEYDEW = Color.create(0xFFF0FFF0);
	public static final HOT_PINK = Color.create(0xFFFF69B4);
	public static final INDIAN_RED = Color.create(0xFFCD5C5C);
	public static final INDIGO = Color.create(0xFF4B0082);
	public static final IVORY = Color.create(0xFFFFFFF0);
	public static final KHAKI = Color.create(0xFFF0E68C);
	public static final LAVENDER = Color.create(0xFFE6E6FA);
	public static final LAVENDER_BLUSH = Color.create(0xFFFFF0F5);
	public static final LAWN_GREEN = Color.create(0xFF7CFC00);
	public static final LEMON_CHIFFON = Color.create(0xFFFFFACD);
	public static final LIGHT_BLUE = Color.create(0xFFADD8E6);
	public static final LIGHT_CORAL = Color.create(0xFFF08080);
	public static final LIGHT_CYAN = Color.create(0xFFE0FFFF);
	public static final LIGHT_GOLDENROD = Color.create(0xFFFAFAD2);
	public static final LIGHT_GRAY = Color.create(0xFFD3D3D3);
	public static final LIGHT_GREEN = Color.create(0xFF90EE90);
	public static final LIGHT_PINK = Color.create(0xFFFFB6C1);
	public static final LIGHT_SALMON = Color.create(0xFFFFA07A);
	public static final LIGHT_SEA_GREEN = Color.create(0xFF20B2AA);
	public static final LIGHT_SKY_BLUE = Color.create(0xFF87CEFA);
	public static final LIGHT_SLATE_GRAY = Color.create(0xFF778899);
	public static final LIGHT_STEEL_BLUE = Color.create(0xFFB0C4DE);
	public static final LIGHT_YELLOW = Color.create(0xFFFFFFE0);
	public static final LIME = Color.create(0xFF00FF00);
	public static final LIME_GREEN = Color.create(0xFF32CD32);
	public static final LINEN = Color.create(0xFFFAF0E6);
	public static final MAGENTA = Color.create(0xFFFF00FF);
	public static final MAROON = Color.create(0xFFB03060);
	public static final MEDIUM_AQUAMARINE = Color.create(0xFF66CDAA);
	public static final MEDIUM_BLUE = Color.create(0xFF0000CD);
	public static final MEDIUM_ORCHID = Color.create(0xFFBA55D3);
	public static final MEDIUM_PURPLE = Color.create(0xFF9370DB);
	public static final MEDIUM_SEA_GREEN = Color.create(0xFF3CB371);
	public static final MEDIUM_SLATE_BLUE = Color.create(0xFF7B68EE);
	public static final MEDIUM_SPRING_GREEN = Color.create(0xFF00FA9A);
	public static final MEDIUM_TURQUOISE = Color.create(0xFF48D1CC);
	public static final MEDIUM_VIOLET_RED = Color.create(0xFFC71585);
	public static final MIDNIGHT_BLUE = Color.create(0xFF191970);
	public static final MINT_CREAM = Color.create(0xFFF5FFFA);
	public static final MISTY_ROSE = Color.create(0xFFFFE4E1);
	public static final MOCCASIN = Color.create(0xFFFFE4B5);
	public static final NAVAJO_WHITE = Color.create(0xFFFFDEAD);
	public static final NAVY_BLUE = Color.create(0xFF000080);
	public static final OLD_LACE = Color.create(0xFFFDF5E6);
	public static final OLIVE = Color.create(0xFF808000);
	public static final OLIVE_DRAB = Color.create(0xFF6B8E23);
	public static final ORANGE = Color.create(0xFFFFA500);
	public static final ORANGE_RED = Color.create(0xFFFF4500);
	public static final ORCHID = Color.create(0xFFDA70D6);
	public static final PALE_GOLDENROD = Color.create(0xFFEEE8AA);
	public static final PALE_GREEN = Color.create(0xFF98FB98);
	public static final PALE_TURQUOISE = Color.create(0xFFAFEEEE);
	public static final PALE_VIOLET_RED = Color.create(0xFFDB7093);
	public static final PAPAYA_WHIP = Color.create(0xFFFFEFD5);
	public static final PEACH_PUFF = Color.create(0xFFFFDAB9);
	public static final PERU = Color.create(0xFFCD853F);
	public static final PINK = Color.create(0xFFFFC0CB);
	public static final PLUM = Color.create(0xFFDDA0DD);
	public static final POWDER_BLUE = Color.create(0xFFB0E0E6);
	public static final PURPLE = Color.create(0xFFA020F0);
	public static final REBECCA_PURPLE = Color.create(0xFF663399);
	public static final RED = Color.create(0xFFFF0000);
	public static final ROSY_BROWN = Color.create(0xFFBC8F8F);
	public static final ROYAL_BLUE = Color.create(0xFF4169E1);
	public static final SADDLE_BROWN = Color.create(0xFF8B4513);
	public static final SALMON = Color.create(0xFFFA8072);
	public static final SANDY_BROWN = Color.create(0xFFF4A460);
	public static final SEA_GREEN = Color.create(0xFF2E8B57);
	public static final SEASHELL = Color.create(0xFFFFF5EE);
	public static final SIENNA = Color.create(0xFFA0522D);
	public static final SILVER = Color.create(0xFFC0C0C0);
	public static final SKY_BLUE = Color.create(0xFF87CEEB);
	public static final SLATE_BLUE = Color.create(0xFF6A5ACD);
	public static final SLATE_GRAY = Color.create(0xFF708090);
	public static final SNOW = Color.create(0xFFFFFAFA);
	public static final SPRING_GREEN = Color.create(0xFF00FF7F);
	public static final STEEL_BLUE = Color.create(0xFF4682B4);
	public static final TAN = Color.create(0xFFD2B48C);
	public static final TEAL = Color.create(0xFF008080);
	public static final THISTLE = Color.create(0xFFD8BFD8);
	public static final TOMATO = Color.create(0xFFFF6347);
	public static final TRANSPARENT = Color.create(0x00000000);
	public static final TURQUOISE = Color.create(0xFF40E0D0);
	public static final VIOLET = Color.create(0xFFEE82EE);
	public static final WEB_GRAY = Color.create(0xFF808080);
	public static final WEB_GREEN = Color.create(0xFF008000);
	public static final WEB_MAROON = Color.create(0xFF800000);
	public static final WEB_PURPLE = Color.create(0xFF800080);
	public static final WHEAT = Color.create(0xFFF5DEB3);
	public static final WHITE = Color.create(0xFFFFFFFF);
	public static final WHITE_SMOKE = Color.create(0xFFF5F5F5);
	public static final YELLOW = Color.create(0xFFFFFF00);
	public static final YELLOW_GREEN = Color.create(0xFF9ACD32);

	/**
	 * The red channel of this color. Ranges from `0.0` - `1.0`.
	 */
	public var r:Float = 0;

	/**
	 * The green channel of this color. Ranges from `0.0` - `1.0`.
	 */
	public var g:Float = 0;

	/**
	 * The blue channel of this color. Ranges from `0.0` - `1.0`.
	 */
	public var b:Float = 0;

	/**
	 * The alpha channel of this color. Ranges from `0.0` - `1.0`.
	 */
	public var a:Float = 1;

	/**
	 * Returns a new `Color`.
	 */
	public function new(r:Float = 0, g:Float = 0, b:Float = 0, a:Float = 1) {
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
	}

	/**
	 * Creates a color from a string.
	 * 
	 * The string can start with `0x`, `0xFF`, or `#`.
	 * 
	 * @param color  The string to create a color from.
	 */
	public static overload extern inline function create(color:String) {
		final colorStr:String = color.replace("#", "").replace("0xFF", "").replace("0x", "");
		return _parseInt(Std.parseInt(colorStr));
	}

	/**
	 * Creates a color from a direct integer value.
	 * 
	 * @param color  The integer to create a color from.
	 */
	public static overload extern inline function create(color:Int) {
		return _parseInt(color);
	}

	/**
	 * Creates a new color from HSV values.
	 * 
	 * @param h  The hue to use for this color. (0 to 1)
	 * @param s  The saturation to use for this color. (0 to 1)
	 * @param v  The value/brightness to use for this color. (0 to 1)
	 * @param a  The alpha to use for this color. (0 to 1)
	 */
	public static overload extern inline function create(h:Float, s:Float, v:Float, a:Float = 1.0) {
		final newColor:Color = {};

		var i:Int;
		var f:Float, p:Float, q:Float, t:Float;
		newColor.a = a;

		if (s == 0.0) {
			// Achromatic (gray)
			newColor.r = newColor.g = newColor.b = v;
			return newColor;
		}

		h *= 6.0;
		h %= 6.0;
		i = Math.floor(h);

		f = h - i;
		p = v * (1.0 - s);
		q = v * (1.0 - s * f);
		t = v * (1.0 - s * (1.0 - f));

		switch (i) {
			case 0: // Red is the dominant color
				newColor.r = v;
				newColor.g = t;
				newColor.b = p;
			case 1: // Green is the dominant color
				newColor.r = q;
				newColor.g = v;
				newColor.b = p;
			case 2:
				newColor.r = p;
				newColor.g = v;
				newColor.b = t;
			case 3: // Blue is the dominant color
				newColor.r = p;
				newColor.g = q;
				newColor.b = v;
			case 4:
				newColor.r = t;
				newColor.g = p;
				newColor.b = v;
			default: // (5) Red is the dominant color
				newColor.r = v;
				newColor.g = p;
				newColor.b = q;
		}
		return newColor;
	}

	/**
	 * Copies the RGBA values from another color
	 * into this one.
	 * 
	 * @param color  The color to copy from.
	 */
	public function copyFrom(color:Color) {
		r = color.r;
		g = color.g;
		b = color.b;
		a = color.a;
		return this;
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //

	@:noCompletion
	private static inline function _parseInt(integer:Int) {
		final newColor:Color = {};
		newColor.r = ((integer >> 16) & 0xff) / 255;
		newColor.g = ((integer >> 8) & 0xff) / 255;
		newColor.b = ((integer) & 0xff) / 255;
		newColor.a = ((integer >> 24) & 0xff) / 255;
		return newColor;
	}
}
