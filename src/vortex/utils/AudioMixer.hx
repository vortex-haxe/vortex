package vortex.utils;

import al.AL;
import al.ALC;

import vortex.math.Vector3;

class AudioMixer {
	public static var device:Device;
	public static var context:Context;

	public static var position(default, set):Vector3;
	public static var velocity(default, set):Vector3;
	public static var orientation(default, set):Array<Single>;

	public static var gain(default, set):Single;

	/**
	 * Initializes the global audio mixer, allowing audio
	 * to play through OpenAL.
	 * 
	 * Returns a boolean indicating the success of this initialization.
	 */
	public static function init():Bool {
		var defaultDevice:String = ALC.getString(null, ALC.DEFAULT_DEVICE_SPECIFIER);
		device = ALC.openDevice(defaultDevice);

		if (device == null) {
			Debug.error('Failed to open an OpenAL device.');
			return false;
		}

		context = ALC.createContext(device, null);
		if (!ALC.makeContextCurrent(context)) {
			Debug.error('Failed to create an OpenAL context.');
			return false;
		}

		final error:Int = AL.getError();
		if (error != AL.NO_ERROR) {
			Debug.error('Failed to make the OpenAL context current. Error: ${error}');
			return false;
		}

		position = new Vector3(0, 0, 0);
		velocity = new Vector3(0, 0, 0);

		orientation = [
			1, 0, 0,
			0, 1, 0,
		];

		gain = 1.0;
		return true;
	}

	/**
	 * Deallocates everything related to OpenAL from memory.
	 */
	public static function quit():Void {
		ALC.makeContextCurrent(null);
		ALC.destroyContext(context);
		ALC.closeDevice(device);

		device = null;
		context = null;
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //
	@:noCompletion
	private static function set_position(value:Vector3):Vector3 {
		AL.listener3f(AL.POSITION, value.x, value.y, value.z);
		return value;
	}
	
	@:noCompletion
	private static function set_velocity(value:Vector3):Vector3 {
		AL.listener3f(AL.VELOCITY, value.x, value.y, value.z);
		return value;
	}
	
	@:noCompletion
	private static function set_orientation(value:Array<Single>):Array<Single> {
		AL.listenerfv(AL.ORIENTATION, cpp.Pointer.arrayElem(value, 0));
		return value;
	}
	
	@:noCompletion
	private static function set_gain(value:Single):Single {
		AL.listenerf(AL.GAIN, value);
		return value;
	}
}