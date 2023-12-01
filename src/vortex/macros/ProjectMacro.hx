package vortex.macros;

// Thanks Ne_Eo for this macro code
// I'm not good at macros so you are helping a lot 🙏
import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;
#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
#end
import vortex.utils.FileUtil;
import vortex.utils.CFGParser;
import vortex.core.Project.ProjectInfo;

#if macro
using haxe.macro.PositionTools;
#end
using StringTools;

@:keep
class ProjectMacro {
	public static macro function build():Array<Field> {
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

		// Find the export folder from build.hxml
		// This is a hacky method and probably sucks, but
		// i have no other ideas on how to do this within macro context

		final hxmlPath:String = Path.normalize(Path.join([sourcePath, "build.hxml"]));
		final lines:Array<String> = [for(l in File.getContent(hxmlPath).replace("\r", "").split("\n")) l.trim()];
		
		var exportFolder:String = "";
		for (line in lines) {
			for(prefix in ["-cpp ", "--cpp "]) {
				if(line.startsWith(prefix))
					exportFolder = line.substring(prefix.length, line.length);
			}
		}

		// Copy specified asset folders to export folder
		for (folder in cfg.assets.folders) {
			final dirToCopy:String = Path.normalize(Path.join([sourcePath, folder]));
			final destDir:String = Path.normalize(Path.join([exportFolder, folder]));
			FileUtil.copyDirectory(dirToCopy, destDir);
		}
		return Context.getBuildFields();
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
