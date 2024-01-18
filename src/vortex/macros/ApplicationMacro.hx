package vortex.macros;

import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;
#if macro
import haxe.macro.*;
import haxe.macro.Expr;
#end
#if (macro || !eval)
import vortex.backend.Application;
import vortex.utils.generic.CFGParser;
import vortex.utils.engine.Project.ProjectInfo;
#end

#if macro
using haxe.macro.PositionTools;
#end

@:keep
class ApplicationMacro {
	public static macro function build():Array<Field> {
        final fields = Context.getBuildFields();

        // Get project config file
        final pos = Context.currentPos();
		final posInfo = pos.getInfos();

		final sourcePath:String = Path.normalize(Sys.getCwd());
		final cfgPath:String = Path.normalize(Path.join([sourcePath, "project.cfg"]));

		if (!FileSystem.exists(cfgPath))
			Context.fatalError('Couldn\'t find a valid "project.cfg" file!', pos);

		final cfg:ProjectInfo = CFGParser.parse(File.getContent(cfgPath));
        
        // The actual macro
        var mainExpr = macro {
            Type.createInstance(Type.resolveClass($v{cfg.source.main}), []);
        };

        var func:Function = {
            ret: TPath({name: "Void", params: [], pack: []}),
            params: [],
            expr: mainExpr,
            args: []
        };

        var mainField:Field = {
            name: "main",
            access: [AStatic],
            kind: FFun(func),
            pos: Context.currentPos(),
            doc: null,
            meta: []
        };
        fields.push(mainField);
        
        return fields;
    }
}