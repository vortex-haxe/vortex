package vortex.servers;

import cpp.RawPointer;
import cpp.Helpers;
import cpp.Star;
import cpp.UInt8;
import cpp.UInt32;
import cpp.UInt64;
import cpp.Int16;
import cpp.Pointer;

import stb.Image;

import dr.MP3;
import dr.WAV;
import stb.Vorbis;

import al.AL;

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

			final ext:String = filePath.substring(filePath.lastIndexOf(".") + 1).toLowerCase();
			
			var format:Int = 0;
			var sampleData:RawPointer<Int16> = null;
			
			switch(ext) {
				case "wav":
					var channels:UInt32 = 0;
					var sampleRate:UInt32 = 0;
					var totalFrameCount:UInt64 = 0;
					sampleData = WAV.openFileAndReadPCMFramesShort16(filePath, channels, sampleRate, totalFrameCount, null);

					if(sampleData != null) {
						format = channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;
						AudioServer.backend.sendDataToBuffer(aud.buffer, format, cast sampleData, totalFrameCount, sampleRate);
					
						if(sampleData != null)
							WAV.free(cast sampleData, null);
					} else
						Debug.error('Audio file at ${filePath} failed to load: Sample data is null');
			
				case "ogg":
					var channels:Int = 0;
					var sampleRate:Int = 0;
					var totalFrameCount:Int = Vorbis.decodeFileName(filePath, channels, sampleRate, cast sampleData);		
					
					if(sampleData != null) {
						format = channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;
						AudioServer.backend.sendDataToBuffer(aud.buffer, format, cast sampleData, totalFrameCount, sampleRate);
						Helpers.free(sampleData);
					} else
						Debug.error('Audio file at ${filePath} failed to load: Sample data is null');
						
				case "mp3":
					var config:cpp.Pointer<DrMP3Config> = null;
					untyped __cpp__('
						drmp3_config config_but_good;
						{0} = &config_but_good;
					', config);

					var totalFrameCount:DrMP3UInt64 = 0;
					sampleData = MP3.openFileAndReadPCMFramesShort16(filePath, config, totalFrameCount, null);
			
					if(sampleData != null) {
						format = config.ref.channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;
						AudioServer.backend.sendDataToBuffer(aud.buffer, format, cast sampleData, totalFrameCount, config.ref.sampleRate);
						MP3.free(sampleData, null);
					} else
						Debug.error('Audio file at ${filePath} failed to load: Sample data is null');
			}
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