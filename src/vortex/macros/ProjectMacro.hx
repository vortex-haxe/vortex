package vortex.macros;

// Thanks Ne_Eo for this macro code
// I'm not good at macros so you are helping a lot 🙏

import sys.io.File;
import sys.FileSystem;

import haxe.io.Path;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Compiler;

import vortex.utils.CFGParser;

using haxe.macro.PositionTools;

class ProjectMacro {
	public static macro function build():Array<Field> {
		final pos = Context.currentPos();
		final posInfo = pos.getInfos();

		var sourcePath:String = Path.directory(posInfo.file);
		if(!Path.isAbsolute(sourcePath))
			sourcePath = Path.join([Sys.getCwd(), sourcePath]);

		sourcePath = Path.normalize(sourcePath);
		
		final cfgPath:String = Path.normalize(Path.join([sourcePath, "project.cfg"]));
		if(!FileSystem.exists(cfgPath))
			Context.fatalError('Couldn\'t find a valid "project.cfg" file!', pos);
		
		final cfg:CFGData = CFGParser.parse(File.getContent(cfgPath));
		config = cfg;

		return Context.getBuildFields();
	}
}