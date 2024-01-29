package vortex.servers.audio;

import cpp.Helpers;
import cpp.Pointer;
import cpp.UInt32;

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
		var device:Device = ALC.openDevice(defaultDevice);

		if(device == null) {
			Debug.error('Failed to open an OpenAL device.');
			return;
		}
		var context:Context = ALC.createContext(device, null);
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
	 * Creates a new audio source.
	 */
	override function createAudioSource():OpenALAudioSourceData {
		final alSource = new OpenALAudioSourceData();
		AL.genSources(1, Helpers.tempPointer(alSource.source));
		return alSource;
	}

	/**
	 * Creates a new audio buffer.
	 */
	override function createAudioBuffer():OpenALAudioBufferData {
		final alBuffer = new OpenALAudioBufferData();
		AL.genBuffers(1, Helpers.tempPointer(alBuffer.buffer));
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