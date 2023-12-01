package vortex.utils;

import cpp.Pointer;
import cpp.RawPointer;
import cpp.Int16;
import cpp.UInt32;
import cpp.UInt64;
import sys.io.File;
import sys.FileSystem;
import sdl.Image;
import dr.Wav as DrWav;
import stb.Vorbis;
import al.AL;
import vortex.core.Engine;
import vortex.core.assets.Texture;
import vortex.core.assets.AudioStream;
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
	 * Loads a audio stream from a given path and returns it.
	 * 
	 * @param path  The path to the audio stream to load.
	 */
	public static function getAudioStream(path:String):AudioStream {
		final key:String = '#_SOUND_$path';
		if (!_cache.exists(key)) {
			final stream:AudioStream = new AudioStream();
			if(exists(path)) {
				AL.genBuffers(1, Pointer.addressOf(stream.key));
	
				var format:Int = 0;
				var extension:String = path.substring(path.lastIndexOf('.') + 1).toLowerCase();
	
				switch (extension) {
					case 'wav':
						var channels:UInt32 = 0;
						var sampleRate:UInt32 = 0;
						var totalFrameCount:cpp.UInt64 = 0;
						var sampleData:RawPointer<cpp.Int16> = DrWav.openFileAndReadPCMFramesShort16(path, channels, sampleRate, totalFrameCount, null);
	
						if (sampleData == null)
							Debug.error('Failed to load WAV audio from ${path}. - Sample data is null');
						else {
							format = channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;
							AL.bufferData(stream.key, format, cast sampleData, untyped __cpp__('{0} * (unsigned long)(4)', totalFrameCount), cast sampleRate);
						}
	
						DrWav.free(cast sampleData, null);
	
					case 'ogg':
						var sampleData:RawPointer<cpp.Int16> = null;
						var sampleRate:Int = 0;
						var channels:Int = 0;
	
						var totalFrameCount:Int = Vorbis.decodeFileName(path, channels, sampleRate, sampleData);
	
						format = channels > 1 ? AL.FORMAT_STEREO16 : AL.FORMAT_MONO16;
	
						AL.bufferData(stream.key, format, cast sampleData, totalFrameCount * 4, sampleRate);
						untyped __cpp__("free({0})", sampleData);
	
					default:
						Debug.warn('Format ${extension.toUpperCase()} is not currently supported for audio players!');
				}
			}
			_cache.set(key, stream);
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
