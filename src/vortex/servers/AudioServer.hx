package vortex.servers;

import cpp.Pointer;
import cpp.UInt32;
import cpp.UInt64;

import vortex.servers.audio.OpenALBackend;
import vortex.utils.math.Vector3;

// I don't currently plan on using anything other
// than OpenAL right now but might aswell make it easier
// on the people who want to use something else

interface IMixerData {
    public var device:Any;
    public var context:Any;
}

interface IAudioSourceData {
	public var source:Any;
}

interface IAudioBufferData {
	public var buffer:Any;
}

/**
 * A template audio mixer backend class.
 */
class MixerBackend {
	/**
	 * The container for the audio device and context.
	 */
	public var data:IMixerData;

	/**
	 * The 3D position of all audio that passes
	 * through this mixer.
	 */
	public var position(default, set):Vector3;

	/**
	 * TODO: Document me!
	 */
	public var velocity(default, set):Vector3;

	/**
	 * TODO: Document me!
	 */
	public var orientation(default, set):Array<Single>;

	/**
	 * A value from 0 to 1 determining how loud
	 * all audio that passes through this mixer can be.
	 */
	public var gain(default, set):Single;

	/**
	 * Makes a new mixer.
	 */
	public function new() {}

	/**
	 * Initializes this mixer.
	 */
	public function init():Void {}

	/**
	 * Gets the current time of a given audio source in seconds.
	 */
	public function getSourceTime(source:IAudioSourceData):Float {
		return 0;
	}

	/**
	 * Sets the current time of an audio source to a given value.
	 */
	public function setSourceTime(source:IAudioSourceData, newTime:Float):Void {}

	/**
	 * Gets the current gain/volume of a given audio source.
	 * 
	 * This will return a float value from 0 to 1.
	 */
	public function getSourceGain(source:IAudioSourceData):Float {
		return 0;
	}

	/**
	 * Sets the current gain of an audio source to a given value.
	 */
	public function setSourceGain(source:IAudioSourceData, newGain:Float):Void {}

	/**
	 * Gets the current pitch of a given audio source.
	 * 
	 * This will return a float value from 0 to 1.
	 */
	public function getSourcePitch(source:IAudioSourceData):Float {
		return 0;
	}

	/**
	 * Sets the current pitch of an audio source to a given value.
	 */
	public function setSourcePitch(source:IAudioSourceData, newPitch:Float):Void {}

	/**
	 * Returns whether or not a given audio source is set to loop.
	 */
	public function getSourceLooping(source:IAudioSourceData):Bool {
		return false;
	}

	/**
	 * Toggles looping of an audio source with a given boolean value.
	 */
	public function setSourceLooping(source:IAudioSourceData, newLooping:Bool):Void {}

	/**
	 * Returns whether or not a given audio source is playing.
	 */
	public function getSourcePlaying(source:IAudioSourceData):Bool {
		return false;
	}

	/**
	 * Pauses/unpauses an audio source with a given boolean value.
	 */
	public function setSourcePlaying(source:IAudioSourceData, newPlaying:Bool):Void {}

	/**
	 * Stops an audio source from playing.
	 */
	public function stopSourcePlaying(source:IAudioSourceData):Void {}

	/**
	 * Sends buffer data to a given audio source.
	 */
	public function sendBufferToSource(source:IAudioSourceData, buffer:IAudioBufferData):Void {}

	/**
	 * Sends sample data, total frame count, and sample rate
	 * data to a given buffer.
	 */
	public function sendDataToBuffer(buffer:IAudioBufferData, format:Int, sampleData:Pointer<cpp.Void>, totalFrameCount:UInt64, sampleRate:UInt32):Void {}

	/**
	 * Creates a new audio source.
	 */
	public function createAudioSource():IAudioSourceData {
		return null;
	}

	/**
	 * Creates a new audio buffer.
	 */
	public function createAudioBuffer():IAudioBufferData {
		return null;
	}

	/**
	 * Disposes of given audio source data and removes it's
	 * properties from memory.
	 */
	public function disposeAudioSource(data:IAudioSourceData):Void {}

	/**
	 * Disposes of given audio buffer data and removes it's
	 * properties from memory.
	 */
	public function disposeAudioBuffer(data:IAudioBufferData):Void {}

	/**
	 * Disposes of this mixer and removes it's
	 * properties from memory.
	 */
	public function dispose():Void {}

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private function set_position(newPos:Vector3):Vector3 {
		return position = newPos;
	}

	@:noCompletion
	private function set_velocity(newVel:Vector3):Vector3 {
		return velocity = newVel;
	}

	@:noCompletion
	private function set_orientation(newOri:Array<Single>):Array<Single> {
		return orientation = newOri;
	}

	@:noCompletion
	private function set_gain(newGain:Single):Single {
		return gain = newGain;
	}
}

/**
 * The class responsible for handling audio playback.
 */
class AudioServer {
	/**
	 * The 3D position of all audio.
	 */
	public static var position(get, set):Vector3;

	/**
	 * TODO: Document me!
	 */
	public static var velocity(get, set):Vector3;

	/**
	 * TODO: Document me!
	 */
	public static var orientation(get, set):Array<Single>;

	/**
	 * A value from 0 to 1 determining how loud all audio can be.
	 */
	public static var gain(get, set):Single;

	/**
	 * The current audio mixer backend.
	 */
	public static var backend:MixerBackend = new OpenALBackend();

	/**
	 * Initializes this audio server.
	 */
	public static function init():Void {
		backend.init();
	}

	/**
	 * Disposes of this audio server and removes it's
	 * objects from memory.
	 */
	public static function dispose():Void {
        backend.dispose();
        backend = null;
    }

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private static function get_position():Vector3 {
		return backend.position;
	}

	@:noCompletion
	private static function set_position(newPos:Vector3):Vector3 {
		return backend.position = newPos;
	}

	@:noCompletion
	private static function get_velocity():Vector3 {
		return backend.velocity;
	}

	@:noCompletion
	private static function set_velocity(newVel:Vector3):Vector3 {
		return backend.velocity = newVel;
	}

	@:noCompletion
	private static function get_orientation():Array<Single> {
		return backend.orientation;
	}

	@:noCompletion
	private static function set_orientation(newOri:Array<Single>):Array<Single> {
		return backend.orientation = newOri;
	}

	@:noCompletion
	private static function get_gain():Single {
		return backend.gain;
	}

	@:noCompletion
	private static function set_gain(newGain:Single):Single {
		return backend.gain = newGain;
	}
}