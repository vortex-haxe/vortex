package vortex.utils.generic;

import sys.io.File;

import vortex.utils.engine.Color;
import vortex.utils.math.Vector2;
import vortex.utils.math.Vector2i;
import vortex.utils.math.Rectangle;
import vortex.utils.math.Rectanglei;

using StringTools;

typedef CFGSection = Dynamic;
typedef CFGData = Dynamic;

/**
 * A basic parser for `cfg` files.
 * 
 * Similarly to the Haxe `Json` class, it returns
 * a structure filled with the data of the config file.
 */
class CFGParser {
	public static function parse(contents:String):CFGData {
		var curSection:String = "global";
		var sections:CFGData = {curSection: {}};

		for (line in contents.trim().split("\n")) {
			final line:String = line.trim();
			if (line.startsWith("#") || line.startsWith(";")) // Comments
				continue;
			else if (line.startsWith("[") && line.endsWith("]")) {
				// Section headers
				curSection = line.substring(1, line.length - 1);
				Reflect.setField(sections, curSection, {});
			} else if (curSection != null) {
				// Assuming config lines are in format "key = value"
				var parts:Array<String> = line.split("=");
				if (parts.length == 2) {
					final value:String = parts[1].trim();
					if (value.charAt(0) == '[' && value.charAt(value.length - 1) == ']') {
						// Remove the brackets from the value and split it into an array
						final arrayValue:Array<String> = value.substring(1, value.length - 1).split(",");

						// Go through each value and parse it into a number (if it is one)
						final vals:Array<Dynamic> = [];
						if(value.charAt(0) == "[" && value.charAt(1) != "]") {
							for (v in arrayValue) {
								v = v.replace("\"", "").replace("'", "").trim();
								final number:Float = Std.parseFloat(v);
								if (!Math.isNaN(number))
									vals.push(number == Math.ffloor(number) ? Std.int(number) : number);
								else
									vals.push(v);
							}
						}

						// Trim each value in the array and add it to the section
						Reflect.setField(Reflect.field(sections, curSection), parts[0].trim(), vals);
					} else {
						final key:String = parts[0].trim();
						final value:String = parts[1].replace("\"", "").replace("'", "").trim();
						Reflect.setField(Reflect.field(sections, curSection), key, _stringToVal(value));
					}
				}
			}
		}
		return sections;
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //

	@:noCompletion
	private static function _stringToVal(value:String):Dynamic {
		// Parse numbers
		final number:Float = Std.parseFloat(value);
		if (!Math.isNaN(number)) {
			if (number == Math.ffloor(number))
				return Std.int(number);
			else
				return number;
		}

		// Parse booleans
		if(value.toLowerCase() == "true")
			return true;

		if(value.toLowerCase() == "false")
			return false;

		// ## Parse class constructors
		// Color
		var cl:String = "Color(";
		if (value.startsWith(cl) && value.endsWith(")")) {
			final sub:String = value.substring(cl.length, value.length - 1);
			final rgba:Array<String> = sub.split(",");
			for (i in 0...rgba.length)
				rgba[i] = rgba[i].trim();
			return new Color(Std.parseFloat(rgba[0] ?? "0.0"), Std.parseFloat(rgba[1] ?? "0.0"), Std.parseFloat(rgba[2] ?? "0.0"),
				Std.parseFloat(rgba[3] ?? "1.0"));
		}

		// Vector2
		cl = "Vector2(";
		if (value.startsWith(cl) && value.endsWith(")")) {
			final sub:String = value.substring(cl.length, value.length - 1);
			final vals:Array<String> = sub.split(",");
			for (i in 0...vals.length)
				vals[i] = vals[i].trim();
			return new Vector2(Std.parseFloat(vals[0] ?? "0.0"), Std.parseFloat(vals[1] ?? "0.0"));
		}

		// Vector2i
		cl = "Vector2i(";
		if (value.startsWith(cl) && value.endsWith(")")) {
			final sub:String = value.substring(cl.length, value.length - 1);
			final vals:Array<String> = sub.split(",");
			for (i in 0...vals.length)
				vals[i] = vals[i].trim();
			return new Vector2i(Std.parseInt(vals[0] ?? "0.0"), Std.parseInt(vals[1] ?? "0.0"));
		}

		// Rectangle
		cl = "Rectangle(";
		if (value.startsWith(cl) && value.endsWith(")")) {
			final sub:String = value.substring(cl.length, value.length - 1);
			final vals:Array<String> = sub.split(",");
			for (i in 0...vals.length)
				vals[i] = vals[i].trim();
			return new Rectangle(Std.parseFloat(vals[0] ?? "0.0"), Std.parseFloat(vals[1] ?? "0.0"), Std.parseFloat(vals[2] ?? "0.0"),
				Std.parseFloat(vals[3] ?? "0.0"));
		}
		
		// Rectanglei
		cl = "Rectanglei(";
		if (value.startsWith(cl) && value.endsWith(")")) {
			final sub:String = value.substring(cl.length, value.length - 1);
			final vals:Array<String> = sub.split(",");
			for (i in 0...vals.length)
				vals[i] = vals[i].trim();
			return new Rectanglei(Std.parseInt(vals[0] ?? "0.0"), Std.parseInt(vals[1] ?? "0.0"), Std.parseInt(vals[2] ?? "0.0"),
				Std.parseInt(vals[3] ?? "0.0"));
		}

		return value;
	}
}
