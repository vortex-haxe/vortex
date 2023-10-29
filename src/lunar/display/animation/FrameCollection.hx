package lunar.display.animation;

import lunar.core.assets.Graphic;

class FrameCollection {
	/**
	 * The graphic used to render the
	 * frames in this collection.
	 */
	public var graphic:Graphic;

	/**
	 * The list of frames in this collection.
	 */
	public var frames:Array<FrameData>;

	public function new(graphic:Graphic, ?frames:Array<FrameData>) {
		this.graphic = graphic;
		this.frames = frames ?? [];
	}
}

@:structInit
class FrameData {
	public var x:Int;
	public var y:Int;
	public var offsetX:Int;
	public var offsetY:Int;
	public var width:Int;
	public var height:Int;
}