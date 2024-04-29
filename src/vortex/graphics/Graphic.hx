package vortex.graphics;

import canvas.utils.Assets;
import canvas.graphics.BitmapData;

import vortex.graphics.frames.ImageFrame;

import vortex.utilities.DestroyUtil;
import vortex.utilities.interfaces.ICacheable;
import vortex.utilities.typelimit.OneOfThree;

typedef GraphicAsset = OneOfThree<String, BitmapData, Graphic>;

/**
 * A safe wrapper for `BitmapData` rendering.
 */
class Graphic implements ICacheable {
    /**
     * The key used for caching in the `BitmapFrontEnd`.
     */
    public var key:String;

    /**
     * The cached `BitmapData` object.
     */
    public var bitmap:BitmapData;

    /**
     * The width of this graphic, in pixels.
     */
    public var width(default, null):Int;

    /**
     * The height of this graphic, in pixels.
     */
    public var height(default, null):Int;

    /**
     * The image frame of this graphic.
     */
    public var imageFrame(get, null):ImageFrame;

    /**
     * Makes and returns a new `Graphic` from a
     * given `canvas.utils.Assets` key string.
     * 
     * @param  source  The Canvas2D asset key string (e.g. `"assets/img.png"`). 
     * @param  key     The key of this graphic in the cache.
     * @param  cache   Whether or not to put this graphic into the cache.
     */
    public static function fromAssetKey(source:String, ?key:String, ?cache:Bool = true):Graphic {
        var bitmap:BitmapData = null;
		if(!cache) {
			bitmap = Assets.getBitmapData(source);
			if (bitmap == null)
				return null;

			return new Graphic(bitmap, key);
		}
		var key:String = GlobalCtx.bitmap.generateKey(source, key);
		var graphic:Graphic = GlobalCtx.bitmap.get(key);

		if(graphic != null)
			return graphic;

		bitmap = Assets.getBitmapData(source);
		if(bitmap == null)
			return null;

		graphic = new Graphic(bitmap, key);
		GlobalCtx.bitmap.addGraphic(graphic);

		return graphic;
    }

    /**
     * Makes and returns a new `Graphic` from given `BitmapData`.
     * 
     * @param  source  The bitmap data to make this graphic from. 
     * @param  key     The key of this graphic in the cache.
     * @param  cache   Whether or not to put this graphic into the cache.
     */
    public static function fromBitmapData(source:BitmapData, ?key:String, ?cache:Bool = true):Graphic {
        if(!cache)
            return new Graphic(source, key);
        
        var _key:String = GlobalCtx.bitmap.findKeyForBitmap(source);
		var graphic:Graphic = null;

		if(_key != null)
			graphic = GlobalCtx.bitmap.get(_key);

		_key = GlobalCtx.bitmap.generateKey(_key, key);
		graphic = GlobalCtx.bitmap.get(_key);
		if(graphic != null)
			return graphic;

        graphic = new Graphic(source, _key);
        GlobalCtx.bitmap.addGraphic(graphic);

        return graphic;
    }

    /**
     * Destroys this graphic and all of it's values.
     */
    public function destroy():Void {
        bitmap = DestroyUtil.dispose(bitmap);
        key = null;
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private function new(bitmap:BitmapData, key:String) {
        this.bitmap = bitmap;
        this.key = key;

        width = bitmap.size.x;
        height = bitmap.size.y;
    }

    @:noCompletion
    private function get_imageFrame():ImageFrame {
        if(imageFrame == null)
            imageFrame = ImageFrame.fromGraphic(this);

        return imageFrame;
    }
}