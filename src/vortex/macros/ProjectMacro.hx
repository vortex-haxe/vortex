package vortex.macros;

// Thanks Ne_Eo for this macro code
// I'm not good at macros so you are helping a lot 🙏

import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;
#if macro
import haxe.macro.*;
import haxe.macro.Expr;
#end
#if (macro || !eval)
import vortex.utils.generic.FileUtil;
import vortex.utils.generic.CFGParser;
import vortex.utils.engine.Project.ProjectInfo;
#end

#if macro
using haxe.macro.PositionTools;
#end
using StringTools;

@:keep
class ProjectMacro {
	public static macro function build():Array<Field> {
		#if (macro || !eval)
		final pos = Context.currentPos();
		final posInfo = pos.getInfos();

		var sourcePath:String = Path.directory(posInfo.file);
		if (!Path.isAbsolute(sourcePath))
			sourcePath = Path.join([Sys.getCwd(), sourcePath]);

		sourcePath = Path.normalize(sourcePath);

		final cfgPath:String = Path.normalize(Path.join([sourcePath, "project.cfg"]));
		if (!FileSystem.exists(cfgPath))
			Context.fatalError('Couldn\'t find a valid "project.cfg" file!', pos);

		final cfg:ProjectInfo = CFGParser.parse(File.getContent(cfgPath));
		final platform:String = Sys.systemName().toLowerCase();

		// Copy specified asset folders to export folder
		for (folder in cfg.assets.folders) {
			final dirToCopy:String = Path.normalize(Path.join([sourcePath, folder]));
			final destDir:String = Path.normalize(Path.join([sourcePath, cfg.export.build_dir, platform, "bin", folder]));
			FileUtil.copyDirectory(dirToCopy, destDir);
		}
		return Context.getBuildFields();
		#else
		return null;
		#end
	}

	public static macro function getConfigDir():Expr {
		return macro $v{Path.normalize(Sys.getCwd())};
	}

	public static macro function getConfig():Expr {
		final cwd:String = Path.normalize(Sys.getCwd());
		final cfgPath:String = Path.normalize(Path.join([cwd, "project.cfg"]));

		if (!FileSystem.exists(cfgPath))
			Context.fatalError('Couldn\'t find a valid "project.cfg" file! ' + cfgPath, Context.currentPos());

		final content:String = File.getContent(cfgPath).replace("\r\n", "\n");
		return macro $v{content};
	}

	// Keeping this code for getConfig for later
	// incase we need it again for whatever reason
	// var sourcePath:String = Path.directory(posInfo.file);
	// var cwd:String = Sys.environment().get("").trim();
	// var atest = cwd.split("=");
	// atest.shift();
	// cwd = atest.join("=");
	// trace(cwd);
	// trace(Sys.getCwd());
}
