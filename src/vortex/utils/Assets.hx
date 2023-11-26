package vortex.utils;

import sys.io.File;
import sys.FileSystem;
import sdl.Image;
import vortex.core.Engine;
import vortex.core.assets.Texture;
import vortex.core.interfaces.IFreeable;

@:allow(vortex.resources.animation.SpriteFrames)
class Assets {
	/**
	 * Returns whether or not a specified asset path exists.
	 * 
	 * @param path  The asset path to check.
	 */
	public static function exists(path:String) {
		return FileSystem.exists(path);
	}

	/**
	 * Loads a texture from a given path and returns it.
	 * 
	 * @param path  The path to the texture to load.
	 */
	public static function getTexture(path:String):Texture {
		final key:String = '#_TEXTURE_$path';
		if (!_cache.exists(key)) {
			final renderer = Engine.tree.window._nativeRenderer;
			final native = Image.loadTexture(renderer, path);
			final tex = new Texture(native);
			tex.key = key;
			_cache.set(key, tex);
		}
		return cast _cache.get(key);
	}

	/**
	 * Returns the text contents of a specified asset.
	 * 
	 * @param path  The path to the text asset.
	 */
	public static function getText(path:String):String {
		return exists(path) ? File.getContent(path) : "";
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //
	private static var _cache:Map<String, IFreeable> = [];
}
