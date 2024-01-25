package vortex.extensions;

import vortex.nodes.Timer;

/**
 * Handles every timer you make in the background.
 */
@:access(vortex.nodes.Timer)
class TimerManager extends Extension {
	/**
	 * Returns whether or not a specified timer
	 * is set to automatically tick/update.
	 * 
	 * @param timer  The timer to check.
	 */
	public function hasTimer(timer:Timer):Bool {
		return _timers.contains(timer);
	}

	/**
	 * Adds a specified timer to the list of
	 * timers that will automatically tick/update.
	 * 
	 * @param timer  The timer to add.
	 */
	public function attachTimer(timer:Timer):Void {
		_timers.push(timer);
	}

	/**
	 * Removes a specified timer from the list of
	 * timers that will automatically tick/update.
	 * 
	 * @param timer  The timer to remove.
	 */
	public function detachTimer(timer:Timer):Void {
		_timers.remove(timer);
	}

	/**
	 * Updates every timer in the list.
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	override function tick(delta:Float) {
		for(timer in _timers) {
			if(timer != null && !timer.disposed) {
				timer.tick(delta);
				if(timer.time >= timer.duration && (timer.repeats < 1 || timer.runs < (timer.repeats + 1))) {
					timer.timeout.emit();
					timer.runs++;
					timer.time = 0;
				}
			}
		}
	}

	// -------- //
	// Privates //
	// -------- //
	private var _timers:Array<Timer> = [];
}