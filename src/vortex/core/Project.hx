package vortex.core;

import vortex.utils.Color;
import vortex.math.Vector2;

typedef ProjectInfo = {
	var engine:EngineInfo;
	var window:WindowInfo;
	var assets:AssetInfo;
}

typedef EngineInfo = {
	var fps:Int;
	var clear_color:Color;
}

typedef WindowInfo = {
	var title:String;
	var size:Vector2;
}

typedef AssetInfo = {
	var folders:Array<String>;
}
