package vortex.graphics.frames;

import vortex.math.MathEx;
import vortex.math.Rect;
import vortex.utilities.DestroyUtil;

/**
 * Base class for all frame collections.
 */
class FramesCollection implements IDestroyable {
    /**
     * Array with all frames of this collection.
     */
    public var frames:Array<Frame>;

    /**
     * The amount of frames in this collection.
     */
    public var numFrames(get, never):Int;

    /**
     * The graphic object this frames belongs to.
     */
    public var graphic:Graphic;

    public function new(graphic:Graphic) {
        this.graphic = graphic;
        frames = [];
        framesByName = [];
    }

    /**
     * Finds a frame in the collection by its name.
     *
     * @param   name   The name of the frame to find.
     */
    public inline function getByName(name:String):Frame {
        return framesByName.get(name);
    }

    /**
     * Whether the collection has frame with the specified name.
     *
     * @param   name   The name of the frame to find.
     */
    public inline function exists(name:String):Bool {
        return framesByName.exists(name);
    }

    /**
     * Helper method for a adding frame to the collection.
     *
     * @param   frameObj       Frame to add.
     * @param   overwriteHash  If true, any new frames with matching names will replace old ones.
     */
    public function pushFrame(frameObj:Frame, overwriteHash = false):Frame {
        final name:String = frameObj.name;
        if(name != null && exists(name) && !overwriteHash)
            return getByName(name);

        frames.push(frameObj);

        if(name != null)
            framesByName.set(name, frameObj);

        return frameObj;
    }

    /**
     * Adds new regular (not rotated) `Frame` to this frame collection.
     *
     * @param   region   Region of image which new frame will display.
     */
    public function addSpriteSheetFrame(region:Rect):Frame {
        // Ensure region is not a weak rect
        region = Rect.get().copyFrom(region);
        final frame = new Frame(graphic);
        frame.region = checkFrame(region);
        frame.sourceSize.set(region.width, region.height);
        frame.offset.set(0, 0);
        return pushFrame(frame);
    }

    /**
     * Checks if frame's area fits into atlas image, and trims if it's out of atlas image bounds.
     *
     * @param   frame   Frame area to check.
     * @param   name    Optional frame name for debugging info.
     */
    public function checkFrame(frame:Rect, ?name:String):Rect {
        var x:Float = MathEx.bound(frame.x, 0, graphic.width);
        var y:Float = MathEx.bound(frame.y, 0, graphic.height);

        var r:Float = MathEx.bound(frame.right, 0, graphic.width);
        var b:Float = MathEx.bound(frame.bottom, 0, graphic.height);

        frame.set(x, y, r - x, b - y);

        if (frame.width <= 0 || frame.height <= 0)
            GlobalCtx.log.warn("The frame " + name + " has incorrect data and results in an image with the size of (0, 0)");

        return frame;
    }

    public function destroy():Void {
        frames = DestroyUtil.destroyArray(frames);
        framesByName = null;
        graphic = null;
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    /**
     * Map of frames, by name, for this frame collection.
     */
    private var framesByName(default, null):Map<String, Frame>;

    @:noCompletion
    private function get_numFrames():Int {
        return frames.length;
    }
}