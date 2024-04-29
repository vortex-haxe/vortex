package vortex.utilities.typelimit;

typedef StateConstructor = Void->State;

/**
 * A utility type that allows methods to accept multiple types
 * when dealing with states.
 * 
 * ## Examples:
 * You can pass the state's contructor in directly:
 * ```haxe
 * GlobalCtx.switchState(PlayState.new);
 * ```
 * You can use short lambas (arrow functions) that return a newly created instance:
 * ```haxe
 * var levelID = 1;
 * GlobalCtx.switchState(() -> new PlayState(levelID));
 * ```
 * You can do things the long way, and use an anonymous function:
 * ```haxe
 * GlobalCtx.switchState(function() {return new PlayState();});
 * ```
 * Lastly, you can pass in an instance directly:
 * ```haxe
 * GlobalCtx.switchState(new PlayState());
 * ```
 */
abstract NextState(Dynamic) {
	@:from
	public static function fromState(state:State):NextState {
		return cast state;
	}

	@:from
	public static function fromMaker(func:() -> State):NextState {
		return cast func;
	}

	public function createInstance():State {
		if (isInstance())
			return cast this;
		else if (isClass())
			return Type.createInstance(this, []);
		else
			return cast this();
	}

	public function getConstructor():() -> State {
		if (isInstance())
			return () -> cast Type.createInstance(Type.getClass(this), []);
		else if (isClass())
			return () -> cast Type.createInstance(this, []);
		else
			return cast this;
	}

    // --------------- //
    // [ Private API ] //
    // --------------- //

    @:noCompletion
    private inline function isInstance():Bool {
		return this is State;
	}

	@:noCompletion
    private inline function isClass():Bool {
		return this is Class;
	}
}
