package vortex.utils.native;

import haxe.io.Path;
import haxe.macro.Expr;
import haxe.macro.Context;

import sys.io.Process;

using StringTools;
using haxe.macro.PositionTools;

/**
 * A utility class for interfacing with 
 * native system calls easier.
 * 
 * @see https://github.com/FNF-CNE-Devs/CodenameEngine/blob/main/source/funkin/backend/utils/NativeAPI.hx
 */
 class NativeAPI {
	/**
	 * Whether or not the current console
	 * has the ability to output colored text.
	 * 
	 * **WARNING**: Could be `null`, use `checkConsoleColorSupport()` to avoid null errors instead!
	 */
	public static var colorSupported:Null<Bool> = null;

	/**
	 * The path to the haxelib folder for Vortex.
	 */
	public static var haxelibPath:String;

	/**
	 * Initializes stuff like the `colorSupported` variable.
	 */
	public static function init() {
		haxelibPath = getHaxelibPath();
		colorSupported = checkConsoleColorSupport();
	}

	/**
	 * Returns the haxelib path for Vortex itself.
	 */
	public static macro function getHaxelibPath():Expr {
		final pos = Context.currentPos();
		final posInfo = pos.getInfos();

		var path = Path.directory(Path.directory(Path.directory(Path.directory(Path.directory(posInfo.file))))); // very messy but works
		return macro $v{path};
	}

	/**
	 * Returns whether or not the current console
	 * has the ability to output colored text.
	 */
	public static function checkConsoleColorSupport():Bool {
		if(Sys.systemName() == "Windows") {
			// make sure utf-8 chars are used in console
			// otherwise color characters won't work
			// the >nul part is so it doesn't output a success message
			// after the command is ran
			Sys.command("chcp 65001 >nul");

			if (~/cygwin|xterm|vt100/.match(Sys.getEnv("TERM") ?? "") || Sys.getEnv("ANSICON") != null)
				return true;
			
			if(Sys.command(Path.normalize(Path.join([haxelibPath, "helpers", "windows", "HasConsoleColors.exe"]))) == 0)
				return true;

		} else {
			var result = -1;
			try {
				var process = new Process("tput", ["colors"]);
				result = process.exitCode();
				process.close();
			}
			catch (e:Dynamic) {}
			return result == 0;
		}
		Sys.println("PHUCK");
		return false;
	}

	/**
	 * Sets the console colors
	 */
	public static function setConsoleColors(foregroundColor:ConsoleColor = NONE, ?backgroundColor:ConsoleColor = NONE) {
		if(!colorSupported)
			return;

		Sys.print("\x1b[0m");
		if (foregroundColor != NONE)
			Sys.print("\x1b[" + Std.int(consoleColorToANSI(foregroundColor)) + "m");
		if (backgroundColor != NONE)
			Sys.print("\x1b[" + Std.int(consoleColorToANSI(backgroundColor) + 10) + "m");
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