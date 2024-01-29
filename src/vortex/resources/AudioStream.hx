package vortex.resources;

import vortex.servers.AudioServer.IAudioBufferData;
import vortex.servers.AudioServer;

// TODO: Add length

/**
 * A simple audio stream class including
 * file path and audio data.
 */
class AudioStream extends Resource {
	private var buffer:IAudioBufferData = null;

	/**
	 * The file path to the audio that this stream uses.
	 * 
	 * Blank if this stream wasn't loaded from a file.
	 */
	public var filePath:String = "";

	/**
	 * Makes a new `AudioStream`.
	 */
	public function new() {
		super();
	}

	override function dispose() {
		if(!disposed && buffer != null) {
			AudioServer.backend.disposeAudioBuffer(buffer);
		}
		disposed = true;
	}
}