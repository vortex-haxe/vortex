package vortex.nodes.tween;

import vortex.utils.generic.Signal;
import vortex.backend.Engine;
import vortex.extensions.TweenManager;
import vortex.utils.generic.HaxeUtil;
import vortex.utils.engine.Color;

typedef EaseCallback = Float->Float;

typedef PropertyTweenParams = {
	var ?property:String;
	var toValue:Dynamic;
	var duration:Float;
	var ?ease:EaseCallback;
	var ?onTick:Dynamic->Void;
}

typedef PropertyTween = {
	var obj:Dynamic;
	var fromValue:Dynamic;
	var params:PropertyTweenParams;
}

typedef ColorTween = {
	var ?obj:Node;
	var params:ColorTweenParams;
}

typedef ColorTweenParams = {
	var fromColor:Color;
	var toColor:Color;
	var duration:Float;
	var ?ease:EaseCallback;
	var ?onTick:Color->Color->Void;
}

/**
 * A simple class for tweening properties of objects, structures and maps.
 * 
 * You can tween multiple objects and properties with just one tween, like so:
 * ```haxe
 * var tween = new Tween();
 * tween.property(node.position, {property: "y", value: 20, duration: 5, ease: Ease.CUBE_IN});
 * tween.property(node.scale, {property: "x", value: 2, duration: 10, ease: Ease.CUBE_OUT});
 * tween.start();
 * ```
 * 
 * Once you've set up what properties you wish to tween, just
 * call `start()` and it will start tweening!
 */
@:access(vortex.extensions.TweenManager)
class Tween extends Object {
	/**
	 * How long this tween has been running for in seconds.
	 * 
	 * Stops counting once it is finished.
	 */
	public var time:Float = 0;

	/**
	 * The total duration of this tween in seconds.
	 * 
	 * This value will always be `0` until this tween
	 * has been started successfully.
	 */
	public var duration:Float = 0;

	/**
	 * A value from `0` to `1` indicating
	 * how much progress this tween has made.
	 */
	public var progress(get, never):Float;

	/**
	 * Whether or not this tween is running.
	 */
	public var running(get, never):Bool;

	/**
	 * The signal that gets emitted when this tween finishes.
	 */
	public var finished:Signal<Void->Void> = new Signal();

	/**
	 * Makes a new `Tween`.
	 */
	public function new() {
		super();
	}

	/**
	 * Starts this tween.
	 * 
	 * If the tween has already started, then it will
	 * go back to the beginning.
	 * 
	 * The last call of `delay()` will also take effect.
	 */
	public function start() {
		final mgr:TweenManager = Engine.extensions.get(TweenManager);
		if(mgr.hasTween(this)) {
			time = _delayTime = 0;
			return;
		}
		mgr.attachTween(this);

		// Calculate total tween duration
		for(pt in _propertyTweens) {
			if(pt != null && pt.params.duration > duration)
				duration = pt.params.duration;
		}
		for(ct in _colorTweens) {
			if(ct != null && ct.params.duration > duration)
				duration = ct.params.duration;
		}
	}
	
	/**
	 * Stops this tween.
	 */
	public function stop() {
		final mgr:TweenManager = Engine.extensions.get(TweenManager);
		if(!mgr.hasTween(this)) {
			Debug.error('Cannot stop a tween that hasn\'t started yet!');
			return;
		}
		mgr.detachTween(this);
	}

	/**
	 * Tweens a specified property of a specified object/structure/map.
	 * 
	 * Defining no ease in `params` will result in a linear tween.
	 * 
	 * @param  obj     The object/structure/map to tween.
	 * @param  params  Basic data such as the property to tween, the tween's duration, etc.
	 */
	public function property(obj:Dynamic, params:PropertyTweenParams):Tween {
		if(obj == null) {
			Debug.error('Cannot tween a null object!');
			return this;
		}
		if(params == null) {
			Debug.error('Cannot tween an object without any params!');
			return this;
		}
		if(params.ease == null)
			params.ease = Ease.LINEAR;

		_propertyTweens.push({
			obj: obj,
			fromValue: HaxeUtil.copy((params.property != null) ? Reflect.getProperty(obj, params.property) : obj),
			params: params
		});
		return this;
	}

	/**
	 * Tweens one color to another color.
	 * 
	 * @param obj     An optional object to apply the new color to.
	 * @param params  Basic data such as the from color, the to color, the tween's duration, etc.
	 */
	public function color(?obj:Node, params:ColorTweenParams):Tween {
		if(params == null) {
			Debug.error('Cannot tween an object without any params!');
			return this;
		}
		if(params.ease == null)
			params.ease = Ease.LINEAR;

		params.fromColor = new Color().copyFrom(params.fromColor);
		_colorTweens.push({
			obj: obj,
			params: params
		});
		return this;
	}

	/**
	 * Delays this tween from ticking after
	 * `start()` is called.
	 * 
	 * @param seconds  The amount of time to wait before ticking.
	 */
	public function delay(seconds:Float) {
		_delayDuration = seconds;
	}

	/**
	 * Updates this tween internally.
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	override function tick(delta:Float) {
		time = Math.min(time + delta, duration);
	}

	/**
	 * Disposes of this tween and removes it's
	 * properties from memory.
	 */
	override function dispose() {
		if(!disposed) {
			_propertyTweens = null;
			_colorTweens = null;
		}
		super.dispose();
	}

	// -------- //
	// Privates //
	// -------- //
	private var _delayTime:Float = 0;
	private var _delayDuration:Float = 0;
	private var _propertyTweens:Array<PropertyTween> = [];
	private var _colorTweens:Array<ColorTween> = [];

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
	private inline function get_running():Bool {
		return time < duration;
	}
}