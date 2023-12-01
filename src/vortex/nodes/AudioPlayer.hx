package vortex.nodes;

import cpp.Pointer;
import cpp.UInt32;
import al.AL;
import vortex.core.assets.AudioStream;
import vortex.math.Vector3;
import vortex.utils.Assets;

class AudioPlayer extends Node {
	/**
	 * The currently playing audio stream.
	 */
	public var stream(default, set):AudioStream;

	/**
	 * Indicates whether or not the audio is set to loop.
	 */
	public var looping(default, set):Bool;

	/**
	 * The pitch of the audio.
	 * `1.0` is default pitch.
	 */
	public var pitch(default, set):Float;

	/**
	 * The volume of the audio.
	 * `1.0` is max volume.
	 */
	public var volume(default, set):Float;

	/**
	 * The current playback time of the audio in seconds.
	 */
	public var time(get, set):Float;

	/**
	 * Indicates whether the audio is currently playing.
	 */
	public var playing(get, set):Bool;

	/**
	 * The position of the audio player in 3D space.
	 */
	public var position(default, set):Vector3;

	/**
	 * The velocity of the audio player in 3D space.
	 */
	public var velocity(default, set):Vector3;

	public function new() {
		super();
		AL.genSources(1, Pointer.addressOf(source));

		this.position = new Vector3(1, 0, 0);
		this.velocity = new Vector3(0, 0, 0);
		this.looping = false;
		this.volume = 1.0;
		this.pitch = 1.0;
	}

	public function play(resetTime:Bool = false):AudioPlayer {
		if (parent == null) {
			Debug.error("Audio players must be added to a node before they can be played!");
			return this;
		}
		if (resetTime)
			time = 0;

		if (source != 0)
			AL.sourcePlay(source);

		return this;
	}

	public function stop(resetTime:Bool = false):AudioPlayer {
		if (parent == null) {
			Debug.error("Audio players must be added to a node before they can be stopped!");
			return this;
		}
		if (source != 0)
			AL.sourceStop(source);

		if (resetTime)
			time = 0;

		return this;
	}

	public function pause():AudioPlayer {
		if (parent == null) {
			Debug.error("Audio players must be added to a node before they can be paused!");
			return this;
		}
		if (source != 0)
			AL.sourcePause(source);

		return this;
	}

	/**
	 * Frees every property of this audio player from memory immediately.
	 * 
	 * Can cause crashes if this audio player is used after it is freed.
	 */
	override function free():Void {
		stop();
		if (source != 0) {
			AL.deleteSources(1, Pointer.addressOf(source));
			source = 0;
		}
		if (stream != null && stream.key != 0)
			stream.unreference();
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //
	private var source:UInt32 = 0;
	private var _time:Single = 0;

	@:noCompletion
	private function set_stream(value:AudioStream):AudioStream {
		if (stream == value)
			return stream;

		if (stream != null)
			stream.unreference();
		
		value.reference();
		AL.sourcei(source, AL.BUFFER, value.key);
		return stream = value;
	}

	@:noCompletion
	private function set_looping(value:Bool):Bool {
		if (source != 0)
			AL.sourcei(source, AL.LOOPING, value ? AL.TRUE : AL.FALSE);

		return looping = value;
	}

	@:noCompletion
	private function set_pitch(value:Float):Float {
		if (source != 0)
			AL.sourcef(source, AL.PITCH, value);

		return pitch = value;
	}

	@:noCompletion
	private function set_volume(value:Float):Float {
		if (source != 0)
			AL.sourcef(source, AL.GAIN, value);

		return volume = value;
	}

	@:noCompletion
	private function get_time():Float {
		if (source != 0)
			AL.getSourcef(source, AL.SEC_OFFSET, Pointer.addressOf(_time));

		return _time;
	}

	@:noCompletion
	private function set_time(value:Float):Float {
		if (source != 0)
			AL.sourcef(source, AL.SEC_OFFSET, value);

		return value;
	}

	@:noCompletion
	private function get_playing():Bool {
		var state:Int = 0;

		if (source != 0)
			AL.getSourcei(source, AL.SOURCE_STATE, Pointer.addressOf(state));

		return (state == AL.PLAYING);
	}

	@:noCompletion
	private function set_playing(value:Bool):Bool {
		if (value)
			play();
		else
			pause();

		return value;
	}

	@:noCompletion
	private function set_position(value:Vector3):Vector3 {
		AL.source3f(source, AL.POSITION, value.x, value.y, value.z);
		return position = value;
	}

	@:noCompletion
	private function set_velocity(value:Vector3):Vector3 {
		AL.source3f(source, AL.VELOCITY, value.x, value.y, value.z);
		return velocity = value;
	}
}
