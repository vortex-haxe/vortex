package vortex.graphics.frames;

import vortex.math.Point;
import vortex.math.Rect;

import vortex.utilities.DestroyUtil;

class Frame implements IDestroyable {
    public var name:String;

    /**
     * Region of the graphic to render.
     */
    public var region(default, set):Rect;

    /**
     * UV coordinates for this frame.
     * 
     * WARNING: For optimization purposes, width and height of this rect
     * contain right and bottom coordinates (`x + width` and `y + height`).
     */
    public var uv:Rect;

    /**
     * The graphic used to render this frame.
     */
    public var graphic:Graphic;

    /**
	 * Rotation angle of this frame.
	 * Required for packed atlas images.
	 */
    public var angle:Float;

    /**
	 * Original (uncropped) image size.
	 */
	public var sourceSize(default, null):Point;

	/**
	 * Frame offset from top left corner of original image.
	 */
	public var offset(default, null):Point;

    /**
     * Destroys this frame and all of it's values.
     */
    public function destroy():Void {
        name = null;
        region = DestroyUtil.put(region);
        uv = DestroyUtil.put(uv);
        sourceSize = DestroyUtil.put(sourceSize);
        offset = DestroyUtil.put(offset);
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    @:allow(vortex.graphics.Graphic)
	@:allow(vortex.graphics.frames.FramesCollection)
    private function new(graphic:Graphic, ?angle:Float = 0) {
        this.graphic = graphic;
        this.angle = angle;

        sourceSize = Point.get();
        offset = Point.get();
    }

    @:noCompletion
    private function set_region(value:Rect):Rect {
		if(value != null) {
			if(uv == null)
				uv = Rect.get();

			uv.set(
                value.x / graphic.width,
                value.y / graphic.height,
                value.right / graphic.width,
                value.bottom / graphic.height
            );
		}
		return region = value;
	}
}