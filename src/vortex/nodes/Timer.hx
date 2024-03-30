package vortex.nodes;

import vortex.backend.Engine;
import vortex.extensions.TimerManager;
import vortex.utils.generic.Signal;

typedef TimerParams = {
	var duration:Float;

	/**
	 * The amount of times this timer repeats.
	 * 0 means indefinitely.
	 */
	var ?repeats:Int;
}

/**
 * A simple class for emitting a timeout signal
 * after a certain amount of time.
 */
class Timer extends Object {
	/**
	 * How long this timer has been running for in seconds.
	 * 
	 * Stops counting once it is finished.
	 */
	public var time:Float = 0;

	/**
	 * The duration of this timer in seconds.
	 */
	public var duration:Float = 0;

	/**
	 * A value from `0` to `1` indicating
	 * how much progress this timer has made.
	 */
	public var progress(get, never):Float;

	/**
	 * Whether or not this timer is finished running.
	 */
	public var finished(get, never):Bool;

	/**
	 * How many times this timer has repeat. Starts from 1.
	 */
	public var runs:Int = 1;

	/**
	 * The amount of times this timer will repeat.
	 */
	public var repeats:Int = 1;

	/**
	 * The signal that gets ran when this timer finishes.
	 */
	public var timeout:Signal<Void->Void> = new Signal();
	 
	/**
	 * Makes a new `Timer`.
	 */
	public function new() {
		super();
	}

	/**
	 * Starts this timer.
	 * 
	 * If the timer has already started, then it will
	 * go back to the beginning.
	 */
	public function start(params:TimerParams) {
		duration = params.duration;
		repeats = params.repeats ?? 1;

		final mgr:TimerManager = Engine.extensions.get(TimerManager);
		if(mgr.hasTimer(this)) {
			time = 0;
			runs = 1;
			return;
		}
		mgr.attachTimer(this);
	}

	/**
	 * Updates this timer internally.
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	override function tick(delta:Float) {
		time = Math.min(time + delta, duration);
	}
	
	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private inline function get_progress():Float {
		if(time == 0 && duration == 0) // Avoid division by 0
			return 0;

		return Math.min(time / duration, 1);
	}

	@:noCompletion
	private inline function get_finished():Bool {
		return (time >= duration) && runs >= repeats;
	}
}