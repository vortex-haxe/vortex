package vortex.display;

import canvas.app.Application;

import canvas.graphics.Color;
import canvas.graphics.Shader;
import canvas.graphics.BitmapData;

import canvas.math.Vector2;
import canvas.math.Vector4;
import canvas.display.Bitmap;

import canvas.servers.RenderingServer;

import vortex.math.Point;
import vortex.math.MathEx;
import vortex.graphics.frames.Frame;

/**
 * The camera class is used to display the game's visuals.
 * By default one camera is created automatically, that is the same size as the game.
 * 
 * You can add more cameras or even replace the main camera using utilities
 * in `GlobalCtx.cameras`.
 */
class Camera extends Object {
    /**
	 * Any `Camera` with a zoom of 0 (the default value) will have this zoom value.
	 */
	public static var defaultZoom:Float = 1;

    /**
     * The initial zoom level of this camera.
     */
    public var initialZoom:Float;

    /**
     * The zoom level of this camera.
     * 
     * A zoom level of `2` makes this camera
     * display at `2x` it's original resolution.
     */
    public var zoom:Float;

    /**
     * The background color of this camera.
     */
    public var bgColor(default, set):Color;

    /**
     * Makes a new `Camera` instance.
     * 
     * @param  x       The X coordinate of this camera on-screen (unaffected by zoom, uses native 1:1 resolution).
     * @param  y       The Y coordinate of this camera on-screen (unaffected by zoom, uses native 1:1 resolution).
     * @param  width   The width of this camera, in pixels (`0` means default value, which is the width of the game).
     * @param  height  The height of this camera, in pixels (`0` means default value, which is the height of the game).
     * @param  zoom    The initial zoom of this camera. A zoom level of `2` makes the camera display at `2x` it's resolution.
     */
    public function new(x:Float = 0, y:Float = 0, width:Int = 0, height:Int = 0, ?zoom:Float = 0) {
        super(x, y);
        @:bypassAccessor bgColor = new Color().copyFrom(GlobalCtx.cameras?.bgColor ?? Color.BLACK);

        if(width <= 0) width = GlobalCtx.width;
        if(height <= 0) height = GlobalCtx.height;
        if(zoom <= 0) zoom = defaultZoom;

        initialZoom = zoom;
        this.zoom = initialZoom;

        size.set(width, height);

        _buffer = new BitmapData(width, height, null, RENDER);
        _canvas = new Bitmap(_buffer);
    }

    /**
     * Sets the width and height of this camera to
     * any given values.
     * 
     * NOTE: This should be used instead of setting the `size` property
     * when resizing a camera, as setting size on it's own will
     * not update all of the camera's properties, which this function does.
     * 
     * @param  width   The new width of this camera, in pixels.
     * @param  height  The new height of this camera, in pixels.
     */
    public function setSize(width:Int, height:Int):Void {
        size.set(width, height);

        _buffer.dispose();
        _buffer = new BitmapData(width, height, null, RENDER);

        _canvas.bitmapData = _buffer;
    }

    /**
     * Clears the contents of this camera.
     */
    public function clear():Void {
        _buffer.activate();
        RenderingServer.backend.clear(Application.current.window);
        @:privateAccess {
            RenderingServer.backend.colorRectShader.useProgram();
            RenderingServer.backend.quadRenderer.drawColor(_vec.set(), _vec2.set(size.x, size.y), bgColor);
        }
        _buffer.deactivate();
    }

    public function drawPixels(frame:Frame, pixels:BitmapData, color:Color, position:Point, scale:Point, origin:Point, angle:Float, shader:Shader) {
        _buffer.activate();
        @:privateAccess {
            final shader = shader ?? RenderingServer.backend.defaultShader;
            shader.useProgram();
            
            RenderingServer.backend.quadRenderer.texture = pixels._data;
            RenderingServer.backend.quadRenderer.drawTexture(
                _vec.set(position.x, position.y),
                _vec2.set(pixels.size.x * scale.x, pixels.size.y * scale.y), color,
                _uv.set(frame.uv.x, frame.uv.y, frame.uv.width, frame.uv.height),
                _vec3.set(origin.x, origin.y), angle * MathEx.TO_RAD
            );
        }
        _buffer.deactivate();
    }

    /**
     * Draws this camera to the screen.
     */
    override function draw() {
        final sm = GlobalCtx.scaleMode;
        _canvas.x = globalPosition.x + sm.offset.x;
        _canvas.y = globalPosition.y + sm.offset.y;
        _canvas.scale.set(sm.scale.x, sm.scale.y);
        _canvas.draw();
    }

    /**
     * Destroys this camera and all
     * of it's values with it.
     * 
     * WARNING: Trying to use a destroyed camera could
     * cause an unwanted crash!
     */
    override function destroy() {
        _buffer.dispose();
        _canvas.dispose();
        super.destroy();
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private static var _vec:Vector2 = new Vector2();
    private static var _vec2:Vector2 = new Vector2();
    private static var _vec3:Vector2 = new Vector2();

    private static var _uv:Vector4 = new Vector4();

    private var _buffer:BitmapData;
    private var _canvas:Bitmap;

    @:noCompletion
    private function set_bgColor(newColor:Color):Color {
        bgColor.copyFrom(newColor);
        newColor = null;
        return bgColor;
    }
}