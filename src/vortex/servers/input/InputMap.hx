package vortex.servers.input;

import vortex.utils.engine.KeyCode;
import vortex.utils.engine.KeyMod;

typedef InputAction = Array<InputType>;

enum MouseButton {
	NONE;
	LEFT;
	MIDDLE;
	RIGHT;
}

enum InputType {
	KEYBOARD_PRESS(key:KeyCode);
	KEYBOARD_RELEASE(key:KeyCode);
	MOUSE_PRESS(button:MouseButton);
	MOUSE_RELEASE(button:MouseButton);
	MOUSE_MOVE(button:MouseButton, x:Int, y:Int, xRel:Int, yRel:Int);
}

/**
 * A map of action names to input actions.
 */
class InputMap {
	/**
	 * Adds a bunch of useful default input actions
	 * to the input map.
	 */
	public static function init():Void {
		// Directional inputs
		InputMap.addAction("ui_up", [
			KEYBOARD_PRESS(W),
			KEYBOARD_PRESS(UP)
		]);
		InputMap.addAction("ui_down", [
			KEYBOARD_PRESS(S),
			KEYBOARD_PRESS(DOWN)
		]);
		InputMap.addAction("ui_left", [
			KEYBOARD_PRESS(A),
			KEYBOARD_PRESS(LEFT)
		]);
		InputMap.addAction("ui_right", [
			KEYBOARD_PRESS(D),
			KEYBOARD_PRESS(RIGHT)
		]);
		
		// Menu inputs
		InputMap.addAction("ui_cancel", [
			KEYBOARD_PRESS(ESCAPE),
			KEYBOARD_PRESS(BACKSPACE)
		]);
		InputMap.addAction("ui_accept", [
			KEYBOARD_PRESS(ENTER),
			KEYBOARD_PRESS(SPACE)
		]);
	}

	/**
	 * Returns an action from the input map.
	 * 
	 * @param name  The name of the action.
	 */
	public static function getAction(name:String):InputAction {
		return _actions.get(name);
	}

	/**
	 * Adds an action to the input map.
	 * 
	 * @param name    The name of this action.
	 * @param action  The action to add to the input map.
	 */
	public static function addAction(name:String, action:InputAction) {
		_actions.set(name, action);
	}

	/**
	 * Removes an action from the input map.
	 * 
	 * @param name    The name of this action.
	 * @param action  The action to remove from the input map.
	 */
	public static function removeAction(name:String, action:InputAction) {
		if(_actions.get(name) == null) {
			Debug.warn('Input action "${name}" doesn\'t exist!');
			return;
		}
		_actions.remove(name);
	}

	// -------- //
	// Privates //
	// -------- //
	private static var _actions:Map<String, InputAction> = [];
}