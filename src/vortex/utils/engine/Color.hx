package vortex.utils.engine;

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
	public static var ALICE_BLUE(get, never):Color;
	public static var ANTIQUE_WHITE(get, never):Color;
	public static var AQUA(get, never):Color;
	public static var AQUAMARINE(get, never):Color;
	public static var AZURE(get, never):Color;
	public static var BEIGE(get, never):Color;
	public static var BISQUE(get, never):Color;
	public static var BLACK(get, never):Color;
	public static var BLANCHED_ALMOND(get, never):Color;
	public static var BLUE(get, never):Color;
	public static var BLUE_VIOLET(get, never):Color;
	public static var BROWN(get, never):Color;
	public static var BURLYWOOD(get, never):Color;
	public static var CADET_BLUE(get, never):Color;
	public static var CHARTREUSE(get, never):Color;
	public static var CHOCOLATE(get, never):Color;
	public static var CORAL(get, never):Color;
	public static var CORNFLOWER_BLUE(get, never):Color;
	public static var CORNSILK(get, never):Color;
	public static var CRIMSON(get, never):Color;
	public static var CYAN(get, never):Color;
	public static var DARK_BLUE(get, never):Color;
	public static var DARK_CYAN(get, never):Color;
	public static var DARK_GOLDENROD(get, never):Color;
	public static var DARK_GRAY(get, never):Color;
	public static var DARK_GREEN(get, never):Color;
	public static var DARK_KHAKI(get, never):Color;
	public static var DARK_MAGENTA(get, never):Color;
	public static var DARK_OLIVE_GREEN(get, never):Color;
	public static var DARK_ORANGE(get, never):Color;
	public static var DARK_ORCHID(get, never):Color;
	public static var DARK_RED(get, never):Color;
	public static var DARK_SALMON(get, never):Color;
	public static var DARK_SEA_GREEN(get, never):Color;
	public static var DARK_SLATE_BLUE(get, never):Color;
	public static var DARK_SLATE_GRAY(get, never):Color;
	public static var DARK_TURQUOISE(get, never):Color;
	public static var DARK_VIOLET(get, never):Color;
	public static var DEEP_PINK(get, never):Color;
	public static var DEEP_SKY_BLUE(get, never):Color;
	public static var DIM_GRAY(get, never):Color;
	public static var DODGER_BLUE(get, never):Color;
	public static var FIREBRICK(get, never):Color;
	public static var FLORAL_WHITE(get, never):Color;
	public static var FOREST_GREEN(get, never):Color;
	public static var FUCHSIA(get, never):Color;
	public static var GAINSBORO(get, never):Color;
	public static var GHOST_WHITE(get, never):Color;
	public static var GOLD(get, never):Color;
	public static var GOLDENROD(get, never):Color;
	public static var GRAY(get, never):Color;
	public static var GREEN(get, never):Color;
	public static var GREEN_YELLOW(get, never):Color;
	public static var HONEYDEW(get, never):Color;
	public static var HOT_PINK(get, never):Color;
	public static var INDIAN_RED(get, never):Color;
	public static var INDIGO(get, never):Color;
	public static var IVORY(get, never):Color;
	public static var KHAKI(get, never):Color;
	public static var LAVENDER(get, never):Color;
	public static var LAVENDER_BLUSH(get, never):Color;
	public static var LAWN_GREEN(get, never):Color;
	public static var LEMON_CHIFFON(get, never):Color;
	public static var LIGHT_BLUE(get, never):Color;
	public static var LIGHT_CORAL(get, never):Color;
	public static var LIGHT_CYAN(get, never):Color;
	public static var LIGHT_GOLDENROD(get, never):Color;
	public static var LIGHT_GRAY(get, never):Color;
	public static var LIGHT_GREEN(get, never):Color;
	public static var LIGHT_PINK(get, never):Color;
	public static var LIGHT_SALMON(get, never):Color;
	public static var LIGHT_SEA_GREEN(get, never):Color;
	public static var LIGHT_SKY_BLUE(get, never):Color;
	public static var LIGHT_SLATE_GRAY(get, never):Color;
	public static var LIGHT_STEEL_BLUE(get, never):Color;
	public static var LIGHT_YELLOW(get, never):Color;
	public static var LIME(get, never):Color;
	public static var LIME_GREEN(get, never):Color;
	public static var LINEN(get, never):Color;
	public static var MAGENTA(get, never):Color;
	public static var MAROON(get, never):Color;
	public static var MEDIUM_AQUAMARINE(get, never):Color;
	public static var MEDIUM_BLUE(get, never):Color;
	public static var MEDIUM_ORCHID(get, never):Color;
	public static var MEDIUM_PURPLE(get, never):Color;
	public static var MEDIUM_SEA_GREEN(get, never):Color;
	public static var MEDIUM_SLATE_BLUE(get, never):Color;
	public static var MEDIUM_SPRING_GREEN(get, never):Color;
	public static var MEDIUM_TURQUOISE(get, never):Color;
	public static var MEDIUM_VIOLET_RED(get, never):Color;
	public static var MIDNIGHT_BLUE(get, never):Color;
	public static var MINT_CREAM(get, never):Color;
	public static var MISTY_ROSE(get, never):Color;
	public static var MOCCASIN(get, never):Color;
	public static var NAVAJO_WHITE(get, never):Color;
	public static var NAVY_BLUE(get, never):Color;
	public static var OLD_LACE(get, never):Color;
	public static var OLIVE(get, never):Color;
	public static var OLIVE_DRAB(get, never):Color;
	public static var ORANGE(get, never):Color;
	public static var ORANGE_RED(get, never):Color;
	public static var ORCHID(get, never):Color;
	public static var PALE_GOLDENROD(get, never):Color;
	public static var PALE_GREEN(get, never):Color;
	public static var PALE_TURQUOISE(get, never):Color;
	public static var PALE_VIOLET_RED(get, never):Color;
	public static var PAPAYA_WHIP(get, never):Color;
	public static var PEACH_PUFF(get, never):Color;
	public static var PERU(get, never):Color;
	public static var PINK(get, never):Color;
	public static var PLUM(get, never):Color;
	public static var POWDER_BLUE(get, never):Color;
	public static var PURPLE(get, never):Color;
	public static var REBECCA_PURPLE(get, never):Color;
	public static var RED(get, never):Color;
	public static var ROSY_BROWN(get, never):Color;
	public static var ROYAL_BLUE(get, never):Color;
	public static var SADDLE_BROWN(get, never):Color;
	public static var SALMON(get, never):Color;
	public static var SANDY_BROWN(get, never):Color;
	public static var SEA_GREEN(get, never):Color;
	public static var SEASHELL(get, never):Color;
	public static var SIENNA(get, never):Color;
	public static var SILVER(get, never):Color;
	public static var SKY_BLUE(get, never):Color;
	public static var SLATE_BLUE(get, never):Color;
	public static var SLATE_GRAY(get, never):Color;
	public static var SNOW(get, never):Color;
	public static var SPRING_GREEN(get, never):Color;
	public static var STEEL_BLUE(get, never):Color;
	public static var TAN(get, never):Color;
	public static var TEAL(get, never):Color;
	public static var THISTLE(get, never):Color;
	public static var TOMATO(get, never):Color;
	public static var TRANSPARENT(get, never):Color;
	public static var TURQUOISE(get, never):Color;
	public static var VIOLET(get, never):Color;
	public static var WEB_GRAY(get, never):Color;
	public static var WEB_GREEN(get, never):Color;
	public static var WEB_MAROON(get, never):Color;
	public static var WEB_PURPLE(get, never):Color;
	public static var WHEAT(get, never):Color;
	public static var WHITE(get, never):Color;
	public static var WHITE_SMOKE(get, never):Color;
	public static var YELLOW(get, never):Color;
	public static var YELLOW_GREEN(get, never):Color;

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

	@:noCompletion private static inline function get_ALICE_BLUE():Color {return Color.create(0xFFF0F8FF);}
	@:noCompletion private static inline function get_ANTIQUE_WHITE():Color {return Color.create(0xFFFAEBD7);}
	@:noCompletion private static inline function get_AQUA():Color {return Color.create(0xFF00FFFF);}
	@:noCompletion private static inline function get_AQUAMARINE():Color {return Color.create(0xFF7FFFD4);}
	@:noCompletion private static inline function get_AZURE():Color {return Color.create(0xFFF0FFFF);}
	@:noCompletion private static inline function get_BEIGE():Color {return Color.create(0xFFF5F5DC);}
	@:noCompletion private static inline function get_BISQUE():Color {return Color.create(0xFFFFE4C4);}
	@:noCompletion private static inline function get_BLACK():Color {return Color.create(0xFF000000);}
	@:noCompletion private static inline function get_BLANCHED_ALMOND():Color {return Color.create(0xFFFFEBCD);}
	@:noCompletion private static inline function get_BLUE():Color {return Color.create(0xFF0000FF);}
	@:noCompletion private static inline function get_BLUE_VIOLET():Color {return Color.create(0xFF8A2BE2);}
	@:noCompletion private static inline function get_BROWN():Color {return Color.create(0xFFA52A2A);}
	@:noCompletion private static inline function get_BURLYWOOD():Color {return Color.create(0xFFDEB887);}
	@:noCompletion private static inline function get_CADET_BLUE():Color {return Color.create(0xFF5F9EA0);}
	@:noCompletion private static inline function get_CHARTREUSE():Color {return Color.create(0xFF7FFF00);}
	@:noCompletion private static inline function get_CHOCOLATE():Color {return Color.create(0xFFD2691E);}
	@:noCompletion private static inline function get_CORAL():Color {return Color.create(0xFFFF7F50);}
	@:noCompletion private static inline function get_CORNFLOWER_BLUE():Color {return Color.create(0xFF6495ED);}
	@:noCompletion private static inline function get_CORNSILK():Color {return Color.create(0xFFFFF8DC);}
	@:noCompletion private static inline function get_CRIMSON():Color {return Color.create(0xFFDC143C);}
	@:noCompletion private static inline function get_CYAN():Color {return Color.create(0xFF00FFFF);}
	@:noCompletion private static inline function get_DARK_BLUE():Color {return Color.create(0xFF00008B);}
	@:noCompletion private static inline function get_DARK_CYAN():Color {return Color.create(0xFF008B8B);}
	@:noCompletion private static inline function get_DARK_GOLDENROD():Color {return Color.create(0xFFB8860B);}
	@:noCompletion private static inline function get_DARK_GRAY():Color {return Color.create(0xFFA9A9A9);}
	@:noCompletion private static inline function get_DARK_GREEN():Color {return Color.create(0xFF006400);}
	@:noCompletion private static inline function get_DARK_KHAKI():Color {return Color.create(0xFFBDB76B);}
	@:noCompletion private static inline function get_DARK_MAGENTA():Color {return Color.create(0xFF8B008B);}
	@:noCompletion private static inline function get_DARK_OLIVE_GREEN():Color {return Color.create(0xFF556B2F);}
	@:noCompletion private static inline function get_DARK_ORANGE():Color {return Color.create(0xFFFF8C00);}
	@:noCompletion private static inline function get_DARK_ORCHID():Color {return Color.create(0xFF9932CC);}
	@:noCompletion private static inline function get_DARK_RED():Color {return Color.create(0xFF8B0000);}
	@:noCompletion private static inline function get_DARK_SALMON():Color {return Color.create(0xFFE9967A);}
	@:noCompletion private static inline function get_DARK_SEA_GREEN():Color {return Color.create(0xFF8FBC8F);}
	@:noCompletion private static inline function get_DARK_SLATE_BLUE():Color {return Color.create(0xFF483D8B);}
	@:noCompletion private static inline function get_DARK_SLATE_GRAY():Color {return Color.create(0xFF2F4F4F);}
	@:noCompletion private static inline function get_DARK_TURQUOISE():Color {return Color.create(0xFF00CED1);}
	@:noCompletion private static inline function get_DARK_VIOLET():Color {return Color.create(0xFF9400D3);}
	@:noCompletion private static inline function get_DEEP_PINK():Color {return Color.create(0xFFFF1493);}
	@:noCompletion private static inline function get_DEEP_SKY_BLUE():Color {return Color.create(0xFF00BFFF);}
	@:noCompletion private static inline function get_DIM_GRAY():Color {return Color.create(0xFF696969);}
	@:noCompletion private static inline function get_DODGER_BLUE():Color {return Color.create(0xFF1E90FF);}
	@:noCompletion private static inline function get_FIREBRICK():Color {return Color.create(0xFFB22222);}
	@:noCompletion private static inline function get_FLORAL_WHITE():Color {return Color.create(0xFFFFFAF0);}
	@:noCompletion private static inline function get_FOREST_GREEN():Color {return Color.create(0xFF228B22);}
	@:noCompletion private static inline function get_FUCHSIA():Color {return Color.create(0xFFFF00FF);}
	@:noCompletion private static inline function get_GAINSBORO():Color {return Color.create(0xFFDCDCDC);}
	@:noCompletion private static inline function get_GHOST_WHITE():Color {return Color.create(0xFFF8F8FF);}
	@:noCompletion private static inline function get_GOLD():Color {return Color.create(0xFFFFD700);}
	@:noCompletion private static inline function get_GOLDENROD():Color {return Color.create(0xFFDAA520);}
	@:noCompletion private static inline function get_GRAY():Color {return Color.create(0xFFBEBEBE);}
	@:noCompletion private static inline function get_GREEN():Color {return Color.create(0xFF00FF00);}
	@:noCompletion private static inline function get_GREEN_YELLOW():Color {return Color.create(0xFFADFF2F);}
	@:noCompletion private static inline function get_HONEYDEW():Color {return Color.create(0xFFF0FFF0);}
	@:noCompletion private static inline function get_HOT_PINK():Color {return Color.create(0xFFFF69B4);}
	@:noCompletion private static inline function get_INDIAN_RED():Color {return Color.create(0xFFCD5C5C);}
	@:noCompletion private static inline function get_INDIGO():Color {return Color.create(0xFF4B0082);}
	@:noCompletion private static inline function get_IVORY():Color {return Color.create(0xFFFFFFF0);}
	@:noCompletion private static inline function get_KHAKI():Color {return Color.create(0xFFF0E68C);}
	@:noCompletion private static inline function get_LAVENDER():Color {return Color.create(0xFFE6E6FA);}
	@:noCompletion private static inline function get_LAVENDER_BLUSH():Color {return Color.create(0xFFFFF0F5);}
	@:noCompletion private static inline function get_LAWN_GREEN():Color {return Color.create(0xFF7CFC00);}
	@:noCompletion private static inline function get_LEMON_CHIFFON():Color {return Color.create(0xFFFFFACD);}
	@:noCompletion private static inline function get_LIGHT_BLUE():Color {return Color.create(0xFFADD8E6);}
	@:noCompletion private static inline function get_LIGHT_CORAL():Color {return Color.create(0xFFF08080);}
	@:noCompletion private static inline function get_LIGHT_CYAN():Color {return Color.create(0xFFE0FFFF);}
	@:noCompletion private static inline function get_LIGHT_GOLDENROD():Color {return Color.create(0xFFFAFAD2);}
	@:noCompletion private static inline function get_LIGHT_GRAY():Color {return Color.create(0xFFD3D3D3);}
	@:noCompletion private static inline function get_LIGHT_GREEN():Color {return Color.create(0xFF90EE90);}
	@:noCompletion private static inline function get_LIGHT_PINK():Color {return Color.create(0xFFFFB6C1);}
	@:noCompletion private static inline function get_LIGHT_SALMON():Color {return Color.create(0xFFFFA07A);}
	@:noCompletion private static inline function get_LIGHT_SEA_GREEN():Color {return Color.create(0xFF20B2AA);}
	@:noCompletion private static inline function get_LIGHT_SKY_BLUE():Color {return Color.create(0xFF87CEFA);}
	@:noCompletion private static inline function get_LIGHT_SLATE_GRAY():Color {return Color.create(0xFF778899);}
	@:noCompletion private static inline function get_LIGHT_STEEL_BLUE():Color {return Color.create(0xFFB0C4DE);}
	@:noCompletion private static inline function get_LIGHT_YELLOW():Color {return Color.create(0xFFFFFFE0);}
	@:noCompletion private static inline function get_LIME():Color {return Color.create(0xFF00FF00);}
	@:noCompletion private static inline function get_LIME_GREEN():Color {return Color.create(0xFF32CD32);}
	@:noCompletion private static inline function get_LINEN():Color {return Color.create(0xFFFAF0E6);}
	@:noCompletion private static inline function get_MAGENTA():Color {return Color.create(0xFFFF00FF);}
	@:noCompletion private static inline function get_MAROON():Color {return Color.create(0xFFB03060);}
	@:noCompletion private static inline function get_MEDIUM_AQUAMARINE():Color {return Color.create(0xFF66CDAA);}
	@:noCompletion private static inline function get_MEDIUM_BLUE():Color {return Color.create(0xFF0000CD);}
	@:noCompletion private static inline function get_MEDIUM_ORCHID():Color {return Color.create(0xFFBA55D3);}
	@:noCompletion private static inline function get_MEDIUM_PURPLE():Color {return Color.create(0xFF9370DB);}
	@:noCompletion private static inline function get_MEDIUM_SEA_GREEN():Color {return Color.create(0xFF3CB371);}
	@:noCompletion private static inline function get_MEDIUM_SLATE_BLUE():Color {return Color.create(0xFF7B68EE);}
	@:noCompletion private static inline function get_MEDIUM_SPRING_GREEN():Color {return Color.create(0xFF00FA9A);}
	@:noCompletion private static inline function get_MEDIUM_TURQUOISE():Color {return Color.create(0xFF48D1CC);}
	@:noCompletion private static inline function get_MEDIUM_VIOLET_RED():Color {return Color.create(0xFFC71585);}
	@:noCompletion private static inline function get_MIDNIGHT_BLUE():Color {return Color.create(0xFF191970);}
	@:noCompletion private static inline function get_MINT_CREAM():Color {return Color.create(0xFFF5FFFA);}
	@:noCompletion private static inline function get_MISTY_ROSE():Color {return Color.create(0xFFFFE4E1);}
	@:noCompletion private static inline function get_MOCCASIN():Color {return Color.create(0xFFFFE4B5);}
	@:noCompletion private static inline function get_NAVAJO_WHITE():Color {return Color.create(0xFFFFDEAD);}
	@:noCompletion private static inline function get_NAVY_BLUE():Color {return Color.create(0xFF000080);}
	@:noCompletion private static inline function get_OLD_LACE():Color {return Color.create(0xFFFDF5E6);}
	@:noCompletion private static inline function get_OLIVE():Color {return Color.create(0xFF808000);}
	@:noCompletion private static inline function get_OLIVE_DRAB():Color {return Color.create(0xFF6B8E23);}
	@:noCompletion private static inline function get_ORANGE():Color {return Color.create(0xFFFFA500);}
	@:noCompletion private static inline function get_ORANGE_RED():Color {return Color.create(0xFFFF4500);}
	@:noCompletion private static inline function get_ORCHID():Color {return Color.create(0xFFDA70D6);}
	@:noCompletion private static inline function get_PALE_GOLDENROD():Color {return Color.create(0xFFEEE8AA);}
	@:noCompletion private static inline function get_PALE_GREEN():Color {return Color.create(0xFF98FB98);}
	@:noCompletion private static inline function get_PALE_TURQUOISE():Color {return Color.create(0xFFAFEEEE);}
	@:noCompletion private static inline function get_PALE_VIOLET_RED():Color {return Color.create(0xFFDB7093);}
	@:noCompletion private static inline function get_PAPAYA_WHIP():Color {return Color.create(0xFFFFEFD5);}
	@:noCompletion private static inline function get_PEACH_PUFF():Color {return Color.create(0xFFFFDAB9);}
	@:noCompletion private static inline function get_PERU():Color {return Color.create(0xFFCD853F);}
	@:noCompletion private static inline function get_PINK():Color {return Color.create(0xFFFFC0CB);}
	@:noCompletion private static inline function get_PLUM():Color {return Color.create(0xFFDDA0DD);}
	@:noCompletion private static inline function get_POWDER_BLUE():Color {return Color.create(0xFFB0E0E6);}
	@:noCompletion private static inline function get_PURPLE():Color {return Color.create(0xFFA020F0);}
	@:noCompletion private static inline function get_REBECCA_PURPLE():Color {return Color.create(0xFF663399);}
	@:noCompletion private static inline function get_RED():Color {return Color.create(0xFFFF0000);}
	@:noCompletion private static inline function get_ROSY_BROWN():Color {return Color.create(0xFFBC8F8F);}
	@:noCompletion private static inline function get_ROYAL_BLUE():Color {return Color.create(0xFF4169E1);}
	@:noCompletion private static inline function get_SADDLE_BROWN():Color {return Color.create(0xFF8B4513);}
	@:noCompletion private static inline function get_SALMON():Color {return Color.create(0xFFFA8072);}
	@:noCompletion private static inline function get_SANDY_BROWN():Color {return Color.create(0xFFF4A460);}
	@:noCompletion private static inline function get_SEA_GREEN():Color {return Color.create(0xFF2E8B57);}
	@:noCompletion private static inline function get_SEASHELL():Color {return Color.create(0xFFFFF5EE);}
	@:noCompletion private static inline function get_SIENNA():Color {return Color.create(0xFFA0522D);}
	@:noCompletion private static inline function get_SILVER():Color {return Color.create(0xFFC0C0C0);}
	@:noCompletion private static inline function get_SKY_BLUE():Color {return Color.create(0xFF87CEEB);}
	@:noCompletion private static inline function get_SLATE_BLUE():Color {return Color.create(0xFF6A5ACD);}
	@:noCompletion private static inline function get_SLATE_GRAY():Color {return Color.create(0xFF708090);}
	@:noCompletion private static inline function get_SNOW():Color {return Color.create(0xFFFFFAFA);}
	@:noCompletion private static inline function get_SPRING_GREEN():Color {return Color.create(0xFF00FF7F);}
	@:noCompletion private static inline function get_STEEL_BLUE():Color {return Color.create(0xFF4682B4);}
	@:noCompletion private static inline function get_TAN():Color {return Color.create(0xFFD2B48C);}
	@:noCompletion private static inline function get_TEAL():Color {return Color.create(0xFF008080);}
	@:noCompletion private static inline function get_THISTLE():Color {return Color.create(0xFFD8BFD8);}
	@:noCompletion private static inline function get_TOMATO():Color {return Color.create(0xFFFF6347);}
	@:noCompletion private static inline function get_TRANSPARENT():Color {return Color.create(0x00000000);}
	@:noCompletion private static inline function get_TURQUOISE():Color {return Color.create(0xFF40E0D0);}
	@:noCompletion private static inline function get_VIOLET():Color {return Color.create(0xFFEE82EE);}
	@:noCompletion private static inline function get_WEB_GRAY():Color {return Color.create(0xFF808080);}
	@:noCompletion private static inline function get_WEB_GREEN():Color {return Color.create(0xFF008000);}
	@:noCompletion private static inline function get_WEB_MAROON():Color {return Color.create(0xFF800000);}
	@:noCompletion private static inline function get_WEB_PURPLE():Color {return Color.create(0xFF800080);}
	@:noCompletion private static inline function get_WHEAT():Color {return Color.create(0xFFF5DEB3);}
	@:noCompletion private static inline function get_WHITE():Color {return Color.create(0xFFFFFFFF);}
	@:noCompletion private static inline function get_WHITE_SMOKE():Color {return Color.create(0xFFF5F5F5);}
	@:noCompletion private static inline function get_YELLOW():Color {return Color.create(0xFFFFFF00);}
	@:noCompletion private static inline function get_YELLOW_GREEN():Color {return Color.create(0xFF9ACD32);}

}
