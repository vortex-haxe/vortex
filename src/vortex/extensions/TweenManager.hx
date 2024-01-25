package vortex.extensions;

import vortex.nodes.Tween;
import vortex.utils.engine.Color;
import vortex.utils.math.MathUtil;
import vortex.utils.math.Rectangle.BaseRectangle;
import vortex.utils.math.Rectanglei.BaseRectanglei;
import vortex.utils.math.Vector2.BaseVector2;
import vortex.utils.math.Vector2i.BaseVector2i;
import vortex.utils.math.Vector3.BaseVector3;
import vortex.utils.math.Vector3i.BaseVector3i;
import vortex.utils.math.Vector4.BaseVector4;
import vortex.utils.math.Vector4i.BaseVector4i;

/**
 * Handles every tween you make in the background.
 */
@:access(vortex.nodes.Tween)
class TweenManager extends Extension {
	/**
	 * Returns whether or not a specified tween
	 * is set to automatically tick/update.
	 * 
	 * @param tween  The tween to check.
	 */
	public function hasTween(tween:Tween):Bool {
		return _tweens.contains(tween);
	}

	/**
	 * Adds a specified tween to the list of
	 * tweens that will automatically tick/update.
	 * 
	 * @param tween  The tween to add.
	 */
	public function attachTween(tween:Tween):Void {
		_tweens.push(tween);
	}

	/**
	 * Removes a specified tween from the list of
	 * tweens that will automatically tick/update.
	 * 
	 * @param tween  The tween to remove.
	 */
	public function detachTween(tween:Tween):Void {
		_tweens.remove(tween);
	}

	/**
	 * Updates every tween in the list.
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	override function tick(delta:Float) {
		for(tween in _tweens) {
			if(tween != null && !tween.disposed) {
				tween._delayTime = Math.min(tween._delayTime + delta, tween._delayDuration);
				if(tween._delayTime >= tween._delayDuration) {
					tween.tick(delta);
					tweenProperties(tween);
					if(!tween.running) {
						tween.finished.emit();
						detachTween(tween);
					}
				}
			}
		}
	}

	// -------- //
	// Privates //
	// -------- //
	private var _tweens:Array<Tween> = [];

	private function tweenProperties(t:Tween) {
		for(pt in t._propertyTweens) {
			if(pt != null) {
				final easedProg:Float = pt.params.ease(t.time / pt.params.duration);
				if(!Reflect.isObject(pt.fromValue)) {
					Reflect.setProperty(
						pt.obj, pt.params.property,
						MathUtil.lerp(pt.fromValue, pt.params.toValue, easedProg)
					);
				} else {
					switch(Type.typeof(pt.fromValue)) {
						case TClass(Color):
							final fc:Color = pt.fromValue;
							final tc:Color = pt.params.toValue;
							pt.obj.set(
								MathUtil.lerp(fc.r, tc.r, easedProg),
								MathUtil.lerp(fc.g, tc.g, easedProg),
								MathUtil.lerp(fc.b, tc.b, easedProg),
								MathUtil.lerp(fc.a, tc.a, easedProg),
							);

						case TClass(BaseRectangle):
							final fc:BaseRectangle = pt.fromValue;
							final tc:BaseRectangle = pt.params.toValue;
							pt.obj.set(
								MathUtil.lerp(fc.x, tc.x, easedProg),
								MathUtil.lerp(fc.y, tc.y, easedProg),
								MathUtil.lerp(fc.width, tc.width, easedProg),
								MathUtil.lerp(fc.height, tc.height, easedProg)
							);

						case TClass(BaseRectanglei):
							final fc:BaseRectanglei = pt.fromValue;
							final tc:BaseRectanglei = pt.params.toValue;
							pt.obj.set(
								Math.floor(MathUtil.lerp(fc.x, tc.x, easedProg)),
								Math.floor(MathUtil.lerp(fc.y, tc.y, easedProg)),
								Math.floor(MathUtil.lerp(fc.width, tc.width, easedProg)),
								Math.floor(MathUtil.lerp(fc.height, tc.height, easedProg))
							);

						case TClass(BaseVector2):
							final fc:BaseVector2 = pt.fromValue;
							final tc:BaseVector2 = pt.params.toValue;
							pt.obj.set(
								MathUtil.lerp(fc.x, tc.x, easedProg),
								MathUtil.lerp(fc.y, tc.y, easedProg)
							);

						case TClass(BaseVector2i):
							final fc:BaseVector2i = pt.fromValue;
							final tc:BaseVector2i = pt.params.toValue;
							pt.obj.set(
								Math.floor(MathUtil.lerp(fc.x, tc.x, easedProg)),
								Math.floor(MathUtil.lerp(fc.y, tc.y, easedProg))
							);

						case TClass(BaseVector3):
							final fc:BaseVector3 = pt.fromValue;
							final tc:BaseVector3 = pt.params.toValue;
							pt.obj.set(
								MathUtil.lerp(fc.x, tc.x, easedProg),
								MathUtil.lerp(fc.y, tc.y, easedProg),
								MathUtil.lerp(fc.z, tc.z, easedProg)
							);

						case TClass(BaseVector3i):
							final fc:BaseVector3i = pt.fromValue;
							final tc:BaseVector3i = pt.params.toValue;
							pt.obj.set(
								Math.floor(MathUtil.lerp(fc.x, tc.x, easedProg)),
								Math.floor(MathUtil.lerp(fc.y, tc.y, easedProg)),
								Math.floor(MathUtil.lerp(fc.z, tc.z, easedProg))
							);

						case TClass(BaseVector4):
							final fc:BaseVector4 = pt.fromValue;
							final tc:BaseVector4 = pt.params.toValue;
							pt.obj.set(
								MathUtil.lerp(fc.x, tc.x, easedProg),
								MathUtil.lerp(fc.y, tc.y, easedProg),
								MathUtil.lerp(fc.z, tc.z, easedProg),
								MathUtil.lerp(fc.w, tc.w, easedProg)
							);

						case TClass(BaseVector4i):
							final fc:BaseVector4i = pt.fromValue;
							final tc:BaseVector4i = pt.params.toValue;
							pt.obj.set(
								Math.floor(MathUtil.lerp(fc.x, tc.x, easedProg)),
								Math.floor(MathUtil.lerp(fc.y, tc.y, easedProg)),
								Math.floor(MathUtil.lerp(fc.z, tc.z, easedProg)),
								Math.floor(MathUtil.lerp(fc.w, tc.w, easedProg))
							);

						default:
					}
				}
				if(pt.params.onTick != null)
					pt.params.onTick(pt.params.toValue);
			}
		}
		for(ct in t._colorTweens) {
			if(ct != null) {
				final easedProg:Float = ct.params.ease(t.progress);
				final fc:Color = ct.params.fromColor;
				if(ct.obj != null) {
					ct.obj.modulate.set(
						MathUtil.lerp(fc.r, ct.params.toColor.r, easedProg),
						MathUtil.lerp(fc.g, ct.params.toColor.g, easedProg),
						MathUtil.lerp(fc.b, ct.params.toColor.b, easedProg),
						MathUtil.lerp(fc.a, ct.params.toColor.a, easedProg),
					);
				}
				if(ct.params.onTick != null)
					ct.params.onTick(ct.params.fromColor, ct.params.toColor);
			}
		}
	}
}