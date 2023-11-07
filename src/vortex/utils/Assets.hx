package vortex.utils;

import sdl.Image;
import vortex.core.Engine;
import vortex.core.assets.Texture;
import vortex.core.interfaces.IFreeable;

class Assets {
	/**
	 * Loads a texture from a given path and returns it.
	 * 
	 * @param path  The path to the texture to load.
	 */
	public static function getTexture(path:String):Texture {
		final key:String = '#_TEXTURE_$path';
		if(!_cache.exists(path)) {
			final renderer = Engine.tree.window._nativeRenderer;
			final native = Image.loadTexture(renderer, path);
			_cache.set(key, new Texture(native));
		}
		return cast _cache.get(key);
	}

	//##==-------------------------------------------------==##//
	//##==----- Don't modify these parts below unless -----==##//
	//##==-- you are here to fix a bug or add a feature. --==##//
	//##==-------------------------------------------------==##//

	private static var _cache:Map<String, IFreeable> = [];
}