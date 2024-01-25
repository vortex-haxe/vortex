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
		},
		{
			name: "run",
			description: "Run a Vortex project.",
			method: runProj
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
		final libDir:String = Sys.getCwd();

        final sysArgs:Array<String> = Sys.args();
        final curDir:String = sysArgs[sysArgs.length - 1];

		if (!FileSystem.exists('${curDir}project.cfg')) {
			Debug._coloredPrint(RED, "[ ERROR ]");
			Sys.print(" A project.cfg file couldn't be found in the current directory.\r\n");
			return;
		}
		final args:Array<String> = [];
		final cfg:ProjectInfo = CFGParser.parse(File.getContent('${curDir}project.cfg'));

        args.push('--class-path ${cfg.source.name}');

        args.push('--library vortex');
		for (lib in cfg.source.libraries)
			args.push('--library ${lib}');

        if (cfg.export.x32_build)
            args.push('--define HXCPP_M32');

		args.push('--main ${cfg.source.main}');

		final platform:String = Sys.systemName().toLowerCase();
		args.push('--cpp ${cfg.export.build_dir}/${platform}/obj');
		
		if(args[1] == "-debug" || args[1] == "--debug")
			args.push("--debug");
		
		Sys.setCwd(curDir);

		final binFolder:String = Path.normalize(Path.join([curDir, cfg.export.build_dir, platform, "bin"]));
		if(!FileSystem.exists(binFolder))
			FileSystem.createDirectory(binFolder);
			
		final compileError:Int = Sys.command('haxe ${args.join(" ")}');
		if(compileError == 0) {
			Sys.setCwd(Path.normalize(Path.join([curDir, cfg.export.build_dir, platform, "obj"])));
			
			if(Sys.systemName() == "Windows") { // Windows
				final exePath:String = Path.normalize(Path.join([binFolder, '${cfg.export.executable_name}.exe']));
				File.copy(
					Path.normalize(Path.join([Sys.getCwd(), '${cfg.source.main}.exe'])),
					exePath
				);
				for(file in FileSystem.readDirectory(Sys.getCwd())) {
					if(Path.extension(file) == "dll") {
						File.copy(
							Path.normalize(Path.join([Sys.getCwd(), file])),
							Path.normalize(Path.join([binFolder, file]))
						);
					}
				}
				final projIconDir:String = Path.normalize(Path.join([curDir, cfg.window.icon]));
				final outputIconDir:String = Path.normalize(Path.join([binFolder, "icon.ico"]));
				
				if(FileSystem.exists(projIconDir)) {
					// Generate ico file
					Sys.setCwd(Path.normalize(Path.join([libDir, "helpers", "windows", "magick"])));
					Sys.command("convert.exe", ["-resize", "256x256", projIconDir, outputIconDir]);
					
					// Apply icon to exe file
					Sys.setCwd(Path.normalize(Path.join([libDir, "helpers", "windows"])));
					Sys.command("ReplaceVistaIcon.exe", [exePath, outputIconDir]);
				} else {
					Debug._coloredPrint(RED, "[ WARNING ]");
					Sys.print(' Icon file "${cfg.window.icon}" doesn\'t exist in the project directory!.\r\n');
				}
			} else { // Linux/MacOS (Maybe BSD too, I forgot how BSD works)
				File.copy(
					Path.normalize(Path.join([Sys.getCwd(), '${cfg.source.main}'])),
					Path.normalize(Path.join([binFolder, '${cfg.export.executable_name}']))
				);
				Sys.setCwd(binFolder);
				Sys.command('chmod +x "${cfg.export.executable_name}"');
			}
			if(runAfterBuild)
				runProj();
		}
	}

	static function runProj() {
        final sysArgs:Array<String> = Sys.args();
        final curDir:String = sysArgs[sysArgs.length - 1];

		if (!FileSystem.exists('${curDir}project.cfg')) {
			Debug._coloredPrint(RED, "[ ERROR ]");
			Sys.print(" A project.cfg file couldn't be found in the current directory.\r\n");
			return;
		}
		final cfg:ProjectInfo = CFGParser.parse(File.getContent('${curDir}project.cfg'));
		final platform:String = Sys.systemName().toLowerCase();

		Sys.setCwd(curDir);
		if(Sys.systemName() == "Windows") { // Windows
			final exec:String = Path.normalize(Path.join([curDir, cfg.export.build_dir, platform, "bin"]));
			if(FileSystem.exists(exec)) {
				Sys.setCwd(exec);
				Sys.command('"${cfg.export.executable_name}.exe"');
			}
		} else { // Linux/MacOS (Maybe BSD too, I forgot how BSD works)
			final exec:String = Path.normalize(Path.join([curDir, cfg.export.build_dir, platform, "bin"]));
			if(FileSystem.exists(exec)) {
				Sys.setCwd(exec);
				Sys.command('"./${cfg.export.executable_name}"');
			}
		}
	}
}
