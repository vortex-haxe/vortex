package vortex.debug;

import haxe.Log;
import haxe.PosInfos;

import vortex.utils.native.NativeAPI;

/**
 * A utility class to log to the debug menu and the console.
 */
class Debug {
	/**
	 * Redirects built-in `trace()` function to
	 * our custom `log()` function.
	 */
	public static function init() {
		Log.trace = function(v, ?pos) {
			Debug.log(v, pos);
		};
	}

	/**
	 * Outputs the given content to the debugger
	 * and console as an information log.
	 * 
	 * @param contents  The contents to output.
	 */
	public static function log(contents:Dynamic, ?pos:PosInfos) {
		_coloredPrint(CYAN, "[ INFO ]");
		_printPosInfos(pos);
		Sys.print('${Std.string(contents)}\r\n');
	}
	
	/**
	 * Outputs the given content to the debugger
	 * and console as an warning log.
	 * 
	 * @param contents  The contents to output.
	 */
	public static function warn(contents:Dynamic, ?pos:PosInfos) {
		_coloredPrint(YELLOW, "[ WARNING ]");
		_printPosInfos(pos);
		Sys.print('${Std.string(contents)}\r\n');
	}
	
	/**
	 * Outputs the given content to the debugger
	 * and console as an error log.
	 * 
	 * @param contents  The contents to output.
	 */
	public static function error(contents:Dynamic, ?pos:PosInfos) {
		_coloredPrint(RED, "[ ERROR ]");
		_printPosInfos(pos);
		Sys.print('${Std.string(contents)}\r\n');
	}

	// --------------- //
	// [ Private API ] //
	// --------------- //

	private static inline function _coloredPrint(color:ConsoleColor, text:String) {
		NativeAPI.setConsoleColors(color);
		Sys.print(text);
		NativeAPI.setConsoleColors();
	}

	private static inline function _printPosInfos(pos:PosInfos) {
		if (pos == null)
			return;
		_coloredPrint(MAGENTA, ' [${pos.className}.${pos.methodName}:${pos.lineNumber}] ');
	}
}
