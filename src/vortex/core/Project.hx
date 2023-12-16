package vortex.core;

import vortex.utils.Color;
import vortex.math.Vector2;

typedef ProjectInfo = {
	var engine:EngineInfo;
	var window:WindowInfo;
	var assets:AssetInfo;
	var source:SourceInfo;
	var export:ExportInfo;
}

typedef EngineInfo = {
	var fps:Int;
	var clear_color:Color;
}

typedef WindowInfo = {
	var title:String;
	var icon:String;
	var size:Vector2;
}

typedef AssetInfo = {
	var folders:Array<String>;
}

typedef SourceInfo = {
	var libraries:Array<String>;
	var name:String;
	var main:String;
}

typedef ExportInfo = {
	var build_dir:String;
	var x32_build:Bool;
	var debug_build:Bool;
}
