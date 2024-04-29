package vortex.graphics.frames;

import vortex.math.Rect;

/**
 * A single-frame collection.
 * 
 * Useful for static sprites without animation.
 */
class ImageFrame extends FramesCollection {
    /**
	 * Single frame of this frame collection.
	 * Added this var for faster access, so you don't need to type something like: `imageFrame.frames[0]`
	 */
	public var frame(get, never):Frame;

    public static function fromGraphic(graphic:Graphic):ImageFrame {
        final imageFrame:ImageFrame = new ImageFrame(graphic);
        final region:Rect = Rect.weak(0, 0, graphic.width, graphic.height);
        imageFrame.addSpriteSheetFrame(region);
        region.putWeak();
        return imageFrame;
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    @:noCompletion
    private function get_frame():Frame {
        return frames[0];
    }
}