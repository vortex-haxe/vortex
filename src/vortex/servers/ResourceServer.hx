package vortex.servers;

import cpp.Star;
import cpp.UInt8;
import cpp.Pointer;

import stb.Image;

import vortex.resources.Texture;
import vortex.resources.AudioStream;
import vortex.utils.engine.RefCounted;

/**
 * A class to easily obtain resources such as textures and sound.
 */
@:access(vortex.resources.Texture)
@:access(vortex.resources.AudioStream)
class ResourceServer {
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
			
			var pixels:Star<UInt8> = Image.load(filePath, Pointer.addressOf(tex.size.x), Pointer.addressOf(tex.size.y), Pointer.addressOf(tex.numChannels), 0);
			
			if (pixels != 0)
				tex.textureData = RenderingServer.backend.createTexture(tex.size.x, tex.size.y, cast pixels, tex.numChannels);
			else
				Debug.error('Image at ${filePath} failed to load: ${Image.failureReason()}');
			
			Image.freeImage(pixels);
			_cache.set(key, tex);
		}
		return cast _cache.get(key);
	}

	/**
	 * Makes a new `AudioStream` and loads data from an audio file
	 * located at the specified file path.
	 * 
	 * @param filePath  The path to the audio file to load.
	 */
	public static function loadAudioStream(filePath:String):AudioStream {
		final key:String = '#_AUDIO_STREAM_${filePath}';
		if(_cache.get(key) == null) {
			final aud = new AudioStream();
			aud.filePath = filePath;
			aud.buffer = AudioServer.backend.createAudioBuffer();

			_cache.set(key, aud);
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