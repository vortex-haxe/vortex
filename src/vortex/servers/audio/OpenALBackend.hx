package vortex.servers.audio;

import cpp.UInt32;
import cpp.UInt64;
import cpp.Helpers;
import cpp.Pointer;

import al.AL;
import al.ALC;

import vortex.servers.AudioServer.IMixerData;
import vortex.servers.AudioServer.IAudioSourceData;
import vortex.servers.AudioServer.IAudioBufferData;
import vortex.servers.AudioServer.MixerBackend;

import vortex.utils.math.Vector3;

class OpenALMixerData implements IMixerData {
	public var device:Any;
	public var context:Any;

	public function new(device:Device, context:Context) {
		this.device = device;
		this.context = context;
	}
}

class OpenALAudioSourceData implements IAudioSourceData {
	public var source:Any = 0;
	public function new() {}
}

class OpenALAudioBufferData implements IAudioBufferData {
	public var buffer:Any = 0;
	public function new() {}
}

class OpenALBackend extends MixerBackend {
	/**
	 * Initializes this mixer.
	 */
	override function init():Void {
		final defaultDevice:String = ALC.getString(null, ALC.DEFAULT_DEVICE_SPECIFIER);
		final device:Device = ALC.openDevice(defaultDevice);

		if(device == null) {
			Debug.error('Failed to open an OpenAL device.');
			return;
		}
		final context:Context = ALC.createContext(device, null);
		if(!ALC.makeContextCurrent(context)) {
			Debug.error('Failed to create OpenAL context.');
			return;
		}

		final error:Int = AL.getError();
		if(error != AL.NO_ERROR) {
			Debug.error('Failed to make OpenAL context current: ${error}');
			return;
		}
		position = new Vector3(0, 0, 0);
		velocity = new Vector3(0, 0, 0);

		orientation = [
			1, 0, 0,
			0, 1, 0,
		];
		gain = 1.0;

		data = new OpenALMixerData(device, context);
	}

	/**
	 * Gets the current time of a given audio source in seconds.
	 */
	override function getSourceTime(source:IAudioSourceData):Float {
		var _time:Single = 0;

		if(source.source != 0) 
			AL.getSourcef(source.source, AL.SEC_OFFSET, Pointer.addressOf(_time));

		return _time;
	}

	/**
	 * Sets the current time of an audio source to a given value.
	 */
	override function setSourceTime(source:IAudioSourceData, newTime:Float):Void {
		if(source.source != 0) 
			AL.sourcef(source.source, AL.SEC_OFFSET, newTime);
	}

	/**
	 * Gets the current gain/volume of a given audio source.
	 * 
	 * This will return a float value from 0 to 1.
	 */
	override function getSourceGain(source:IAudioSourceData):Float {
		var _gain:Single = 0;

		if(source.source != 0) 
			AL.getSourcef(source.source, AL.GAIN, Pointer.addressOf(_gain));

		return _gain;
	}

	/**
	 * Sets the current gain of an audio source to a given value.
	 */
	override function setSourceGain(source:IAudioSourceData, newGain:Float):Void {
		if(source.source != 0) 
			AL.sourcef(source.source, AL.SEC_OFFSET, newGain);
	}

	/**
	 * Gets the current pitch of a given audio source.
	 * 
	 * This will return a float value from 0 to 1.
	 */
	override function getSourcePitch(source:IAudioSourceData):Float {
		var _pitch:Single = 0;

		if(source.source != 0) 
			AL.getSourcef(source.source, AL.PITCH, Pointer.addressOf(_pitch));

		return _pitch;
	}

	/**
	 * Sets the current pitch of an audio source to a given value.
	 */
	override function setSourcePitch(source:IAudioSourceData, newPitch:Float):Void {
		if(source.source != 0) 
			AL.sourcef(source.source, AL.PITCH, newPitch);
	}

	/**
	 * Returns whether or not a given audio source is set to loop.
	 */
	override function getSourceLooping(source:IAudioSourceData):Bool {
		var state:Int = 0;

		if (source.source != 0) 
			AL.getSourcei(source.source, AL.LOOPING, Pointer.addressOf(state));

		return state == AL.TRUE;
	}

	/**
	 * Toggles looping of an audio source with a given boolean value.
	 */
	override function setSourceLooping(source:IAudioSourceData, newLooping:Bool):Void {
		if (source.source != 0) 
			AL.sourcei(source.source, AL.LOOPING, newLooping ? AL.TRUE : AL.FALSE);
	}

	/**
	 * Returns whether or not a given audio source is playing.
	 */
	override function getSourcePlaying(source:IAudioSourceData):Bool {
		var state:Int = 0;

		if (source.source != 0) 
			AL.getSourcei(source.source, AL.PLAYING, Pointer.addressOf(state));

		return state == AL.TRUE;
	}

	/**
	 * Pauses/unpauses an audio source with a given boolean value.
	 */
	override function setSourcePlaying(source:IAudioSourceData, newPlaying:Bool):Void {
		if (source.source != 0) {
			if (newPlaying)
				AL.sourcePlay(source.source);
			else
				AL.sourcePause(source.source);
		}
	}

	/**
	 * Stops an audio source from playing.
	 */
	override function stopSourcePlaying(source:IAudioSourceData) {
		if (source.source != 0)
			AL.sourceStop(source.source);
	}

	/**
	 * Sends buffer data to a given audio source.
	 */
	override function sendBufferToSource(source:IAudioSourceData, buffer:IAudioBufferData):Void {
		AL.sourcei(source.source, AL.BUFFER, buffer.buffer);
	}

	/**
	 * Sends sample data, total frame count, and sample rate
	 * data to a given buffer.
	 */
	override function sendDataToBuffer(buffer:IAudioBufferData, format:Int, sampleData:Pointer<cpp.Void>, totalFrameCount:UInt64, sampleRate:UInt32):Void {
		AL.bufferData(buffer.buffer, format, sampleData, untyped __cpp__("{0} * (unsigned long)(4)", totalFrameCount), sampleRate);
	}

	/**
	 * Creates a new audio source.
	 */
	override function createAudioSource():OpenALAudioSourceData {
		final alSource = new OpenALAudioSourceData();
		var value:UInt32 = 0;
		AL.genSources(1, Helpers.tempPointer(value));
		alSource.source = value;
		return alSource;
	}

	/**
	 * Creates a new audio buffer.
	 */
	override function createAudioBuffer():OpenALAudioBufferData {
		final alBuffer = new OpenALAudioBufferData();
		var value:UInt32 = 0;
		AL.genBuffers(1, Helpers.tempPointer(value));
		alBuffer.buffer = value;
		return alBuffer;
	}

	/**
	 * Disposes of given audio source data and removes it's
	 * properties from memory.
	 */
	override function disposeAudioSource(data:IAudioSourceData):Void {
		// Helpers.tempPointer is used because regular cpp.Pointer just doesn't work
		// :3   - swordcube
		AL.deleteSources(1, Helpers.tempPointer(data.source));
	}

	/**
	 * Disposes of given audio buffer data and removes it's
	 * properties from memory.
	 */
	override function disposeAudioBuffer(data:IAudioBufferData):Void {
		AL.deleteBuffers(1, Helpers.tempPointer(data.buffer));
	}

	override function dispose():Void {
		ALC.makeContextCurrent(null);
		ALC.destroyContext(data.context);
		ALC.closeDevice(data.device);
		data.device = null;
		data.context = null;
	}

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	override function set_position(newPos:Vector3):Vector3 {
		AL.listener3f(AL.POSITION, newPos.x, newPos.y, newPos.z);
		return position = newPos;
	}

	override function set_velocity(newVel:Vector3):Vector3 {
		AL.listener3f(AL.VELOCITY, newVel.x, newVel.y, newVel.z);
		return velocity = newVel;
	}
	
	override function set_orientation(newOri:Array<Single>):Array<Single> {
		AL.listenerfv(AL.ORIENTATION, Pointer.arrayElem(newOri, 0));
		return orientation = newOri;
	}

	override function set_gain(newGain:Single):Single {
		AL.listenerf(AL.GAIN, newGain);
		return gain = newGain;
	}
}