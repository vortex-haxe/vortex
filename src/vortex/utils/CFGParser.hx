package vortex.utils;

import sys.io.File;

using StringTools;

typedef CFGSection = Dynamic;
typedef CFGData = Dynamic;

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
						for(v in arrayValue) {
							v = v.replace("\"", "").replace("'", "").trim();
							final number:Float = Std.parseFloat(v);
							if(!Math.isNaN(number))
								vals.push(number);
							else
								vals.push(v);
						}

						// Trim each value in the array and add it to the section
						Reflect.setField(Reflect.field(sections, curSection), parts[0].trim(), vals);
					} else {
						final key:String = parts[0].trim();
						final value:String = parts[1].trim();
						final number:Float = Std.parseFloat(value);
						Reflect.setField(Reflect.field(sections, curSection), key, !Math.isNaN(number) ? number : value);
					}
				}
			}
		}
		return sections;
	}
}
