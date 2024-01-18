package;

import haxe.io.Path;
import haxe.io.Bytes;

import sys.io.File;
import sys.FileSystem;

import vortex.debug.Debug;
import vortex.macros.ProjectMacro;
import vortex.utils.generic.CFGParser;
import vortex.utils.engine.Project.ProjectInfo;
import vortex.utils.generic.FileUtil;

using StringTools;

typedef Command = {
	var name:String;
	var description:String;
	var method:Void->Void;
}

@:access(vortex.debug.Debug)
class Run {
	static final cmds:Array<Command> = [
		{
			name: "help",
			description: "Lists every available command.",
			method: () -> {
				Sys.print("\r\n--========##[ Command List ]##========--\r\n\r\n");
				for (cmd in cmds)
					Sys.print('${cmd.name} - ${cmd.description}\r\n');
				Sys.print("\r\n--========####################========--\r\n\r\n");
			}
		},
		{
			name: "create",
			description: "Create a fresh Vortex project.",
			method: () -> {
				final emptyZipFile:String = Path.normalize(Path.join([ProjectMacro.getConfigDir(), "projects", "empty.zip"]));
				final args:Array<String> = Sys.args() ?? [];
				final curDir:String = Path.normalize(args[args.length - 1]);
				Sys.print('Please input the name of the new project. (Will be created in ${curDir})\r\n');
				try {
					final result:String = Sys.stdin().readLine().toString();
					final newDir:String = Path.normalize(Path.join([curDir, result]));
					if (FileSystem.exists(newDir)) {
						Sys.print('Project at ${newDir} already exists! Please delete it before continuing.');
						return;
					} else {
						Sys.print('Creating project at ${newDir}...\r\n');
						FileSystem.createDirectory(newDir);
						FileUtil.unzipFile(emptyZipFile, newDir);
					}
					Sys.print('Project at ${newDir} has been created!');
				} catch (e) {}
			}
		},
		{
			name: "build",
			description: "Build a Vortex project.",
			method: buildProj.bind(false)
		},
		{
			name: "test",
			description: "Build and run a Vortex project.",
			method: buildProj.bind(true)
		}
	];

	static function main() {
		var isValidCMD:Bool = false;
		final args:Array<String> = Sys.args() ?? [];
		for (cmd in cmds) {
			if (args[0] == cmd.name) {
				isValidCMD = true;
				if (cmd.method != null)
					cmd.method();
				break;
			}
		}
		if (!isValidCMD) {
			final asciiArt:String = "
            ───────────────────────────────────────────────────────────────────────────────────────────────────
            ─██████──██████─██████████████─████████████████───██████████████─██████████████─████████──████████─
            ─██░░██──██░░██─██░░░░░░░░░░██─██░░░░░░░░░░░░██───██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░██──██░░░░██─
            ─██░░██──██░░██─██░░██████░░██─██░░████████░░██───██████░░██████─██░░██████████─████░░██──██░░████─
            ─██░░██──██░░██─██░░██──██░░██─██░░██────██░░██───────██░░██─────██░░██───────────██░░░░██░░░░██───
            ─██░░██──██░░██─██░░██──██░░██─██░░████████░░██───────██░░██─────██░░██████████───████░░░░░░████───
            ─██░░██──██░░██─██░░██──██░░██─██░░░░░░░░░░░░██───────██░░██─────██░░░░░░░░░░██─────██░░░░░░██─────
            ─██░░██──██░░██─██░░██──██░░██─██░░██████░░████───────██░░██─────██░░██████████───████░░░░░░████───
            ─██░░░░██░░░░██─██░░██──██░░██─██░░██──██░░██─────────██░░██─────██░░██───────────██░░░░██░░░░██───
            ─████░░░░░░████─██░░██████░░██─██░░██──██░░██████─────██░░██─────██░░██████████─████░░██──██░░████─
            ───████░░████───██░░░░░░░░░░██─██░░██──██░░░░░░██─────██░░██─────██░░░░░░░░░░██─██░░░░██──██░░░░██─
            ─────██████─────██████████████─██████──██████████─────██████─────██████████████─████████──████████─
            ───────────────────────────────────────────────────────────────────────────────────────────────────
            \r\n";
			Debug._coloredPrint(MAGENTA, asciiArt);
			
			Sys.print("Welcome to Vortex, an easy and performant 2D game framework built for Haxe.\r\n\r\n");
			Sys.print("Type in \"haxelib run vortex help\" for a list of every available command!\r\n\r\n");
		}
	}

	static function buildProj(?runAfterBuild:Bool = false) {
        final sysArgs:Array<String> = Sys.args();
        final curDir:String = sysArgs[sysArgs.length - 1];

		if (!FileSystem.exists('${curDir}project.cfg')) {
			Debug._coloredPrint(RED, "[ ERROR ]");
			Sys.print(" A project.cfg file couldn't be found in the current directory.");
			return;
		}
		final args:Array<String> = [];
		final cfg:ProjectInfo = CFGParser.parse(File.getContent('${curDir}project.cfg'));
        
		final mainCl:String = cfg.source.main.substring(cfg.source.main.lastIndexOf(".") + 1, cfg.source.main.length);

        args.push('--class-path ${cfg.source.name}');

        args.push('--library vortex');
		for (lib in cfg.source.libraries)
			args.push('--library ${lib}');

        if (cfg.export.x32_build)
            args.push('--define HXCPP_M32');

		args.push('--main ${cfg.source.main}');
		args.push('--cpp ${cfg.export.build_dir}');

		if(args[1] == "-debug" || args[1] == "--debug")
			args.push("--debug");

		Sys.command('cd ${curDir}');
		Sys.command('haxe ${args.join(" ")}');

		if(runAfterBuild) {
			if(Sys.systemName() == "Windows") { // Windows
				final exec:String = Path.normalize(Path.join([curDir, cfg.export.build_dir, '${mainCl}.exe']));
				if(FileSystem.exists(exec))
					Sys.command('"${exec}"');
			} else { // Linux/MacOS (Maybe BSD too, I forgot how BSD works)
				final exec:String = Path.normalize(Path.join([curDir, cfg.export.build_dir]));
				if(FileSystem.exists(exec)) {
					Sys.setCwd(exec);
					Sys.command('"./${mainCl}"');
				}
			}
		}
	}
}
