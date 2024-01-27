package vortex.servers;

/**
 * A simple class for handling key and mouse input.
 */
class InputServer {
	public static function addAction(name:String, action:InputAction) {
		if(_actions.get(name) == null)
			_actions.set(name, []);

		if(_actions.get(name) != null) {
			Debug.warn('Input action "${name}" was already added!');
			return;
		}
		_actions.get(name).push(action);
	}

	// -------- //
	// Privates //
	// -------- //
	private static var _actions:Map<String, Array<InputAction>> = [];
}

/**
 * A generic input action.
 */
class InputAction {
	
}