package vortex.system.frontend;

import canvas.utils.Assets;

import canvas.graphics.BitmapData;
import vortex.graphics.Graphic;

/**
 * Accessible via `GlobalCtx.bitmap`.
 */
@:access(canvas.utils.Assets)
class BitmapFrontEnd {
    public function new() {}

    public function clear():Void {
        for(graphic in _cache) {
            if(graphic != null) {
                Assets.bitmapCache.removeItem(graphic.bitmap);
                graphic.destroy();
            }
        }
        _cache.clear();
    }

    /**
	 * Gets key from bitmap cache for specified BitmapData
	 *
	 * @param	bmd	BitmapData to find in cache
	 * @return	BitmapData's key or null if there isn't such BitmapData in cache
	 */
	public function findKeyForBitmap(bmd:BitmapData):String {
        for(key in _cache.keys()) {
            final obj = _cache.get(key);
            if(obj != null && obj.bitmap == bmd)
                return key;
        }
        return null;
    }

    /**
	 * Creates string key for further caching.
	 *
	 * @param  systemKey  The first string key to use as a base for a new key. It's usually a key from canvas.utils.Assets (`"assets/image.png"`).
	 * @param  userKey    The second string key to use as a base for a new key. It's usually a key provided by the user
	 */
	public function generateKey(systemKey:String, userKey:String):String {
		var key:String = userKey;
		if(key == null)
			key = systemKey;

		if(key == null)
			key = getUniqueKey(key);

		return key;
	}

	/**
	 * Gets unique key for bitmap cache
	 *
	 * @param  baseKey  key's prefix
	 */
	public function getUniqueKey(?baseKey:String):String {
		if(baseKey == null)
			baseKey = "pixels";

		if(!checkCache(baseKey))
			return baseKey;

		var i:Int = _lastUniqueKeyIndex;
		var uniqueKey:String;
		do {
			i++;
			uniqueKey = baseKey + i;
		}
		while(checkCache(uniqueKey));

		_lastUniqueKeyIndex = i;
		return uniqueKey;
	}

    public function checkCache(key:String):Bool {
        return _cache.get(key) != null;
    }

    /**
     * Returns a graphic of a given key from the cache.
     * 
     * @param  key  The key of the graphic to fetch.
     */
    public function get(key:String):Graphic {
        return _cache.get(key);
    }

    public function add(graphic:GraphicAsset, ?key:String):Graphic {
        if(graphic is Graphic)
            return graphic;
        else if(graphic is BitmapData)
            return Graphic.fromBitmapData(cast graphic, key);

        return Graphic.fromAssetKey(Std.string(graphic), key);
    }

    public function addGraphic(graphic:Graphic):Graphic {
        _cache.set(graphic.key, graphic);
        return graphic;
    }

    /**
     * Destroys all of the graphics in cache.
     */
    public function destroy():Void {
        for(graphic in _cache) {
            if(graphic != null)
                graphic.destroy();
        }
        _cache.clear();
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private var _lastUniqueKeyIndex:Int = 0;
    private var _cache:Map<String, Graphic> = [];
}