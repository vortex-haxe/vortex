package vortex.servers;

import sdl.Types.MouseButton as NativeMouseButton;

import vortex.backend.Application;

import vortex.servers.input.InputMap;

import vortex.utils.engine.KeyCode;
import vortex.utils.engine.KeyMod;
import vortex.utils.generic.Signal;

enum InputState {
	JUST_PRESSED;
	PRESSED;
	JUST_RELEASED;
	RELEASED;
}

/**
 * A simple class for handling keyboard and mouse input.
 */
class InputServer {
	public static final onInput:Signal<InputType->Void> = new Signal();

	/**
	 * Initializes the input server.
	 */
	public static function init():Void {
		InputMap.init();

		final window = Application.self.window;

		// Keyboard
		window.onKeyPress.connect((key:KeyCode, mod:KeyMod) -> {
			if(keyStates.get(key) != JUST_PRESSED && keyStates.get(key) != PRESSED) {
				keyStates.set(key, JUST_PRESSED);
				onInput.emit(KEYBOARD_PRESS(key));
			}
		});
		window.onKeyRelease.connect((key:KeyCode, mod:KeyMod) -> {
			if(keyStates.get(key) != JUST_RELEASED && keyStates.get(key) != RELEASED) {
				keyStates.set(key, JUST_RELEASED);
				onInput.emit(KEYBOARD_RELEASE(key));
			}
		});
		
		// Mouse
		window.onMouseMove.connect((button:NativeMouseButton, x:Int, y:Int, xRel:Int, yRel:Int) -> {
			mouseMovements.set(button, JUST_PRESSED);
			onInput.emit(MOUSE_MOVE(toVortexMouseButton(button), x, y, xRel, yRel));
		});
		window.onMouseClick.connect((button:NativeMouseButton) -> {
			if(mouseStates.get(button) != JUST_PRESSED && mouseStates.get(button) != PRESSED) {
				mouseStates.set(button, JUST_PRESSED);
				onInput.emit(MOUSE_PRESS(toVortexMouseButton(button)));
			}
		});
		window.onMouseRelease.connect((button:NativeMouseButton) -> {
			if(mouseStates.get(button) != JUST_RELEASED && mouseStates.get(button) != RELEASED) {
				mouseStates.set(button, JUST_RELEASED);
				onInput.emit(MOUSE_RELEASE(toVortexMouseButton(button)));
			}
		});
	}

	/**
	 * Returns whether or not an input type has a matching
	 * state of the one specified.
	 * 
	 * @param input  The input to check.
	 * @param state  The state to check.
	 */
	public static function inputMatchesState(input:InputType, state:InputState):Bool {
		switch(input) {
			case KEYBOARD_PRESS(key):
				if((keyStates.get(key) ?? RELEASED) == state)
					return true;

			case KEYBOARD_RELEASE(key):
				if((keyStates.get(key) ?? RELEASED) == state)
					return true;

			case MOUSE_MOVE(button, x, y, xRel, yRel):
				if((mouseMovements.get(toNativeMouseButton(button)) ?? RELEASED) == state)
					return true;

			case MOUSE_PRESS(button):
				if((mouseStates.get(toNativeMouseButton(button)) ?? RELEASED) == state)
					return true;

			case MOUSE_RELEASE(button):
				if((mouseStates.get(toNativeMouseButton(button)) ?? RELEASED) == state)
					return true;
		}
		return false;
	}

	/**
	 * Returns whether or not a specified action was just pressed.
	 * 
	 * @param action  The action to check.
	 */
	public static function isActionJustPressed(action:String):Bool {
		final action:InputAction = InputMap.getAction(action);
		if(action == null) {
			Debug.error('Input action called "${action}" doesn\'t exist!');
			return false;
		}
		for(input in action) {
			if(inputMatchesState(input, JUST_PRESSED))
				return true;
		}
		return false;
	}

	/**
	 * Returns whether or not a specified action is pressed.
	 * 
	 * @param action  The action to check.
	 */
	public static function isActionPressed(action:String):Bool {
		final action:InputAction = InputMap.getAction(action);
		if(action == null) {
			Debug.error('Input action called "${action}" doesn\'t exist!');
			return false;
		}
		for(input in action) {
			if(inputMatchesState(input, JUST_PRESSED) || inputMatchesState(input, PRESSED))
				return true;
		}
		return false;
	}

	/**
	 * Returns whether or not a specified action is released.
	 * 
	 * @param action  The action to check.
	 */
	public static function isActionReleased(action:String):Bool {
		return !isActionPressed(action);
	}

	/**
	 * Returns whether or not a specified action was just released.
	 * 
	 * @param action  The action to check.
	 */
	public static function isActionJustReleased(action:String):Bool {
		final action:InputAction = InputMap.getAction(action);
		if(action == null) {
			Debug.error('Input action called "${action}" doesn\'t exist!');
			return false;
		}
		for(input in action) {
			if(inputMatchesState(input, JUST_RELEASED) || inputMatchesState(input, RELEASED))
				return true;
		}
		return false;
	}

	/**
	 * Goes through each key/mouse state and sets
	 * them to be held down if they are currently just pressed.
	 */
	public static function updateStates():Void {
		for(key => state in keyStates) {
			switch(state) {
				case JUST_PRESSED:
					keyStates.set(key, PRESSED);
				
				case JUST_RELEASED:
					keyStates.set(key, RELEASED);

				default:
			}
		}
		for(key => state in mouseStates) {
			switch(state) {
				case JUST_PRESSED:
					mouseStates.set(key, PRESSED);
				
				case JUST_RELEASED:
					mouseStates.set(key, RELEASED);

				default:
			}
		}
		for(key => state in mouseMovements) {
			if(state == JUST_PRESSED)
				mouseMovements.set(key, RELEASED);
		}
	}

	// -------- //
	// Privates //
	// -------- //
	private static var keyStates:Map<KeyCode, InputState> = [];
	private static var mouseStates:Map<NativeMouseButton, InputState> = [];
	private static var mouseMovements:Map<NativeMouseButton, InputState> = [];

	private static function toNativeMouseButton(vButton:MouseButton):NativeMouseButton {
		return switch(vButton) {
			case MouseButton.LEFT: LEFT;
			case MouseButton.MIDDLE: MIDDLE;
			case MouseButton.RIGHT: RIGHT;
			default: 0;
		}
	}

	private static function toVortexMouseButton(nButton:NativeMouseButton):MouseButton {
		return switch(nButton) {
			case NativeMouseButton.LEFT: LEFT;
			case NativeMouseButton.MIDDLE: MIDDLE;
			case NativeMouseButton.RIGHT: RIGHT;
			default: NONE;
		}
	}
}