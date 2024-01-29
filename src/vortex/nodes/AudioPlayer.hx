package vortex.nodes;

import vortex.servers.AudioServer;
import vortex.servers.AudioServer.IAudioSourceData;
import vortex.resources.AudioStream;
import vortex.utils.math.MathUtil;

/**
 * A simple class that can play audio streams.
 */
class AudioPlayer extends Node {
	/**
	 * The audio stream that will be played.
	 */
	public var stream(default, set):AudioStream;

	/**
	 * The current time of the audio in seconds.
	 */
	public var time(get, set):Float;

	/**
	 * Whether or not the stream is playing.
	 */
	public var playing(get, set):Bool;

	/**
	 * Whether or not the stream is looping.
	 */
	public var looping(get, set):Bool;

	/**
	 * The gain/volume of this audio player.
	 * 
	 * This is a linear value from 0 to 1.
	 */
	public var gain(get, set):Float;

	/**
	 * The pitch of this audio player.
	 * 
	 * This is a linear value, 1 being default.
	 */
	public var pitch(get, set):Float;

	/**
	 * Makes a new `AudioPlayer`.
	 */
	public function new() {
		super();
		source = AudioServer.backend.createAudioSource();
	}

	/**
	 * Plays the audio stream.
	 */
	public function play(fromTime:Float = 0.0):Void {
		playing = true;
		time = fromTime;
	}

	/**
	 * Resumes the audio stream.
	 */
	public function resume():Void {
		playing = true;
	}

	/**
	 * Pauses the audio stream.
	 */
	public function pause():Void {
		playing = false;
	}

	/**
	 * Stops the audio stream.
	 */
	public function stop():Void {
		AudioServer.backend.stopSourcePlaying(source);
	}

	/**
	 * Disposes of this audio player and removes it's
	 * properties from memory.
	 */
	override function dispose():Void {
		if(!disposed) {
			stop();
			
			if(stream != null)
				stream.unreference();

			if(source != null)
				AudioServer.backend.disposeAudioSource(source);
		}
		super.dispose();
	}

	// -------- //
	// Privates //
	// -------- //
	private var source:IAudioSourceData;

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private function get_time():Float {
		return AudioServer.backend.getSourceTime(source);
	}

	@:noCompletion
	private function set_time(newTime:Float):Float {
		AudioServer.backend.setSourceTime(source, newTime);
		return newTime;
	}

	@:noCompletion
	private function get_playing():Bool {
		return AudioServer.backend.getSourcePlaying(source);
	}

	@:noCompletion
	private function set_playing(newPlaying:Bool):Bool {
		AudioServer.backend.setSourcePlaying(source, newPlaying);
		return newPlaying;
	}

	@:noCompletion
	private function get_looping():Bool {
		return AudioServer.backend.getSourceLooping(source);
	}

	@:noCompletion
	private function set_looping(newLooping:Bool):Bool {
		AudioServer.backend.setSourceLooping(source, newLooping);
		return newLooping;
	}

	@:noCompletion
	private function get_gain():Float {
		return AudioServer.backend.getSourceGain(source);
	}

	@:noCompletion
	private function set_gain(newGain:Float):Float {
		AudioServer.backend.setSourceGain(source, MathUtil.bound(newGain, 0, 1));
		return newGain;
	}

	@:noCompletion
	private function get_pitch():Float {
		return AudioServer.backend.getSourcePitch(source);
	}

	@:noCompletion
	private function set_pitch(newPitch:Float):Float {
		AudioServer.backend.setSourcePitch(source, newPitch);
		return newPitch;
	}

	@:noCompletion
	private inline function set_stream(newStream:AudioStream):AudioStream {
		if(stream != null)
			stream.unreference();

		if(newStream != null) {
			newStream.reference();
			@:privateAccess
			AudioServer.backend.sendBufferToSource(source, newStream.buffer);
		}

		return stream = newStream;
	}
}