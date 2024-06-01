package vortex.display;

import canvas.graphics.Shader;
import canvas.graphics.Color;

import vortex.graphics.Graphic;
import vortex.graphics.frames.*;

import vortex.math.Point;
import vortex.utilities.DestroyUtil;

/**
 * This class contains helpful tools for making your games
 * such as animation, movement, etc for the needs of most 2D games.
 * 
 * If you need to however, you can extend `Sprite` and add
 * your own functionality for your own needs.
 * 
 * For example: one could make a `Bullet` class that extends
 * a `Sprite` while also adding their own values like `strength` and `speed`.
 */
class Sprite extends Object {
    /**
     * The X and Y offsets of this sprite, in pixels.
     */
    public var offset:Point = Point.get();

    /**
     * A collection of animation frames for this sprite.
     */
    public var frames(default, set):FramesCollection;

    /**
     * The graphic used to render this sprite.
     */
    public var graphic(get, never):Graphic;

    /**
     * The currently rendering frame of this sprite.
     */
    public var frame:Frame;

    /**
     * The X and Y scaling multiplier of this sprite.
     */
    public var scale:Point = Point.get(1, 1);

    /**
     * The origin of rotation for this sprite, in pixels.
     */
    public var origin:Point = Point.get();

    /**
     * The rotation of this sprite, in degrees.
     */
    public var angle:Float = 0;

    /**
     * Applies a color tint to this sprite when rendering.
     */
    public var color(default, set):Color = Color.WHITE;

    /**
     * The shader applied to this sprite when rendering.
     */
    public var shader:Shader;

    public function new(x:Float = 0, y:Float = 0, ?simpleGraphic:GraphicAsset) {
        super(x, y);
        @:bypassAccessor color = new Color().copyFrom(color);

        if(simpleGraphic != null)
            loadGraphic(simpleGraphic);
    }

    /**
     * Loads a graphic onto this sprite and then
     * returns the sprite afterwards, for chaining.
     * 
     * @param  graphic  The graphic to load onto this sprite.
     */
    public function loadGraphic(graphic:GraphicAsset):Sprite {
        var graph:Graphic = GlobalCtx.bitmap.add(graphic);
        if(graph == null)
            return this;

        frames = graph.imageFrame;
        return this;
    }

    /**
     * Sets the rotation origin to the center of this sprite.
     */
    public function centerOrigin():Void {
        origin.set(size.x * 0.5, size.y * 0.5);
    }

    /**
     * Draws this sprite onto the screen.
     */
    override function draw() {
        if(color.a == 0)
            return;

        for(camera in cameras) {
            if(camera != null)
                drawComplex(camera);
        }
    }

    /**
     * Destroys this sprite and all
     * of it's values with it.
     * 
     * WARNING: Trying to use a destroyed sprite could
     * cause an unwanted crash!
     */
    override function destroy() {
        offset = DestroyUtil.put(offset);
        origin = DestroyUtil.put(origin);
        frames = null;
        @:bypassAccessor color = null;
        super.destroy();
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private static var _pos:Point = new Point();
    private static var _orig:Point = new Point();

    private function drawComplex(camera:Camera) {
        if(frame == null || frame.graphic == null)
            return;

        camera.drawPixels(
            frame, frame.graphic.bitmap, color,
            _pos.set((globalPosition.x + offset.x) + origin.x, (globalPosition.y + offset.y) + origin.y),
            scale, _orig.set(origin.x / size.x, origin.y / size.y),
            angle, shader
        );
    }

    @:noCompletion
    private function set_frames(newFrames:FramesCollection):FramesCollection {
        if(frames != null)
            frames.destroy();

        if(newFrames != null) {
            frame = newFrames.frames[0];
            size.copyFrom(frame.sourceSize);
            centerOrigin();
        }
        return frames = newFrames;
    }

    @:noCompletion
    private function get_graphic():Graphic {
        if(frames != null && frames.graphic != null)
            return frames.graphic;

        return null;
    }

    @:noCompletion
    private function set_color(newColor:Color):Color {
        color.copyFrom(newColor);
        newColor = null;
        return color;
    }
}