package vortex.servers;

import cpp.Star;
import cpp.UInt8;
import cpp.Pointer;

import glad.Glad;
import stb.Image;

import vortex.backend.interfaces.IServer;
import vortex.resources.Texture;
import vortex.utils.engine.RefCounted;

/**
 * A class to easily obtain resources such as textures and sound.
 */
@:access(vortex.resources.Texture)
class ResourceServer extends IServer {
	/**
	 * Initializes this resource server.
	 */
	public static function init():Void {
		// TODO: load placeholder for missing textures
	}

	/**
	 * Makes a new `Texture` and loads data from an image
	 * located at the specified file path.
	 * 
	 * @param filePath  The path to the image to load.
	 */
	public static function loadImage(filePath:String):Texture {
		final key:String = '#_TEXTURE_${filePath}';
		if(_cache.get(key) == null) {
			final tex = new Texture();
			tex.filePath = filePath;
			
			var width:Int = 0;
			var height:Int = 0;
			var pixels:Star<UInt8> = Image.load(filePath, Pointer.addressOf(width), Pointer.addressOf(height), Pointer.addressOf(tex.numChannels), 0);
			tex.size.set(width, height);
			
			if (pixels != 0) {
				tex.textureData = RenderingServer.createTexture(width, height, cast pixels, tex.numChannels);
			} else
				Debug.error('Image at ${filePath} failed to load: ${Image.failureReason()}');
			
			Image.freeImage(pixels);
			_cache.set(key, tex);
		}
		return cast _cache.get(key);
	}

	/**
	 * Removes all disposed resources from cache.
	 */
	public static function removeDisposed():Void {
		for(key => resource in _cache) {
			if(resource == null || resource.disposed)
				_cache.remove(key);
		}
	}

	/**
	 * Disposes of this resource server and removes it's
	 * properties from memory.
	 */
	public static function dispose():Void {
		for(resource in _cache) {
			if(resource != null && !resource.disposed)
				resource.dispose();
		}
		_cache = null;
	}

	// -------- //
	// Privates //
	// -------- //
	private static var _cache:Map<String, RefCounted> = [];
}