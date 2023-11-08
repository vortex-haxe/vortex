package vortex.core.native;

/**
 * @see https://github.com/FNF-CNE-Devs/CodenameEngine/blob/main/source/funkin/backend/utils/NativeAPI.hx
 */
class NativeAPI {
	/**
	 * Sets the console colors
	 */
	public static function setConsoleColors(foregroundColor:ConsoleColor = NONE, ?backgroundColor:ConsoleColor = NONE) {
		#if sys
		Sys.print("\x1b[0m");
		if (foregroundColor != NONE)
			Sys.print("\x1b[" + Std.int(consoleColorToANSI(foregroundColor)) + "m");
		if (backgroundColor != NONE)
			Sys.print("\x1b[" + Std.int(consoleColorToANSI(backgroundColor) + 10) + "m");
		#end
	}

	public static function consoleColorToANSI(color:ConsoleColor) {
		return switch (color) {
			case BLACK: 30;
			case DARKBLUE: 34;
			case DARKGREEN: 32;
			case DARKCYAN: 36;
			case DARKRED: 31;
			case DARKMAGENTA: 35;
			case DARKYELLOW: 33;
			case LIGHTGRAY: 37;
			case GRAY: 90;
			case BLUE: 94;
			case GREEN: 92;
			case CYAN: 96;
			case RED: 91;
			case MAGENTA: 95;
			case YELLOW: 93;
			case WHITE | _: 97;
		}
	}

	public static function consoleColorToInt(color:ConsoleColor) {
		return switch (color) {
			case BLACK: 0xFF000000;
			case DARKBLUE: 0xFF000088;
			case DARKGREEN: 0xFF008800;
			case DARKCYAN: 0xFF008888;
			case DARKRED: 0xFF880000;
			case DARKMAGENTA: 0xFF880000;
			case DARKYELLOW: 0xFF888800;
			case LIGHTGRAY: 0xFFBBBBBB;
			case GRAY: 0xFF888888;
			case BLUE: 0xFF0000FF;
			case GREEN: 0xFF00FF00;
			case CYAN: 0xFF00FFFF;
			case RED: 0xFFFF0000;
			case MAGENTA: 0xFFFF00FF;
			case YELLOW: 0xFFFFFF00;
			case WHITE | _: 0xFFFFFFFF;
		}
	}
}

enum abstract ConsoleColor(Int) {
	var BLACK = 0;
	var DARKBLUE = 1;
	var DARKGREEN = 2;
	var DARKCYAN = 3;
	var DARKRED = 4;
	var DARKMAGENTA = 5;
	var DARKYELLOW = 6;
	var LIGHTGRAY = 7;
	var GRAY = 8;
	var BLUE = 9;
	var GREEN = 10;
	var CYAN = 11;
	var RED = 12;
	var MAGENTA = 13;
	var YELLOW = 14;
	var WHITE = 15;

	var NONE = -1;
}

enum abstract MessageBoxIcon(Int) {
	var MSG_ERROR = 0x00000010;
	var MSG_QUESTION = 0x00000020;
	var MSG_WARNING = 0x00000030;
	var MSG_INFORMATION = 0x00000040;
}
