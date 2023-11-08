package vortex.macros;

#if macro
import haxe.macro.Expr;
import haxe.macro.Compiler;
import haxe.macro.Context;
#end

@:keep
class OSDefineMacro {
	public static macro function build():Array<Field> {
		switch (Sys.systemName()) {
			case "Windows":
				Compiler.define("windows", "1");

			case "Linux":
				Compiler.define("linux", "1");

			case "BSD":
				Compiler.define("bsd", "1");

			case "Mac":
				Compiler.define("mac", "1");
				Compiler.define("macos", "1");
		}
		return Context.getBuildFields();
	}
}
