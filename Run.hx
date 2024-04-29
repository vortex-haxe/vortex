package;

import haxe.io.Path;
import sys.FileSystem;

import canvas._backend.macros.ProjectMacro;
import canvas._backend.native.NativeAPI;

import canvas.tools.FileUtil;

using StringTools;

typedef Command = {
	var name:String;
	var description:String;
	var method:Void->Void;
}

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
			method: () -> buildProj(false)
		},
		{
			name: "test",
			description: "Build and run a Vortex project.",
			method: () -> buildProj(true)
		},
		{
			name: "run",
			description: "Run a Vortex project.",
			method: () -> runProj()
		}
	];

	static function main() {
		NativeAPI.init();
		
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
			final oldConsoleAsciiArt:String = "
                    __                 
___  ______________/  |_  ____ ___  ___
\\  \\/ /  _ \\_  __ \\   __\\/ __ \\\\  \\/  /
 \\   (  <_> )  | \\/|  | \\  ___/ >    < 
  \\_/ \\____/|__|   |__|  \\___  >__/\\_ \\
                             \\/      \\/
            \r\n";
			final newConsoleAsciiArt:String = "
┌──┐┌──┐
│  └┘  │
└┐ ╱╲ ┌┘ ┌─┬─┐┌───┐┌───┐┌───┐┌───┐┌─┬─┐
┌┘ ╲╱ └┐ │ │ ││ │ ││ │ │└┐ ┌┘│ ╶─┤├   ┤
│  ┌┐  │ │ ╵ ││ │ ││ ╷ ┤ │ │ │ ╶─┤│ │ │
└──┘└──┘ └───┘└───┘└─┴─┘ └─┘ └───┘└─┴─┘
			\r\n";
			NativeAPI.setConsoleColors(MAGENTA);
			@:privateAccess
			if(NativeAPI.colorSupported)
				Sys.print(newConsoleAsciiArt);
			else // If we don't have colors we're very likely on an older terminal/console
				Sys.print(oldConsoleAsciiArt);

			Sys.sleep(0.001);
			NativeAPI.setConsoleColors();
			Sys.sleep(0.001);
			
			Sys.print("Welcome to Vortex, an easy and performant 2D game framework built for Haxe.\r\n\r\n");
			Sys.print("Type in \"haxelib run vortex help\" for a list of every available command!\r\n");
		}
	}

	static function buildProj(?runAfterBuild:Bool = false) {
		final sysArgs:Array<String> = Sys.args();
		Sys.setCwd(sysArgs[sysArgs.length - 1]);

		if(runAfterBuild)
			Sys.command("haxelib", ["run", "canvas2d", "test"]);
		else
			Sys.command("haxelib", ["run", "canvas2d", "build"]);
	}

	static function runProj() {
		final sysArgs:Array<String> = Sys.args();
		Sys.setCwd(sysArgs[sysArgs.length - 1]);
        Sys.command("haxelib", ["run", "canvas2d", "run"]);
	}
}
