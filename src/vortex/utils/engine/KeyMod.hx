package vortex.utils.engine;

import sdl.Types.SDLKeyMod as NativeMod;
import vortex.utils.generic.MacroUtil;

enum abstract KeyMod(Int) from Int to Int {
	public static var fromStringMap(default, null):Map<String, KeyMod> = MacroUtil.buildMap("vortex.utils.engine.KeyMod");
	public static var toStringMap(default, null):Map<KeyMod, String> = MacroUtil.buildMap("vortex.utils.engine.KeyMod", true);

	var NONE = 0x0000;
    var LSHIFT = 0x0001;
    var RSHIFT = 0x0002;
    var LCTRL = 0x0040;
    var RCTRL = 0x0080;
    var LALT = 0x0100;
    var RALT = 0x0200;
    var LGUI = 0x0400;
    var RGUI = 0x0800;
    var NUM = 0x1000;
    var CAPS = 0x2000;
    var MODE = 0x4000;
    var SCROLL = 0x8000;
    var CTRL = 192;
    var SHIFT = 3;
    var ALT = 768;
    var GUI = 3072;

	@:from
	public static inline function fromString(s:String) {
		s = s.toUpperCase();
		return fromStringMap.exists(s) ? fromStringMap.get(s) : NONE;
	}

	@:to
	public inline function toString():String {
		return toStringMap.get(this);
	}
}