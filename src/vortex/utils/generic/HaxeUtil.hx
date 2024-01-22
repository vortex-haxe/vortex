package vortex.utils.generic;

import haxe.Constraints.IMap;

/**
 * A class with general utility functions
 * that don't already exist in Haxe.
 */
class HaxeUtil {
	/**
	 * Deep copy of anything using reflection (so don't hope for much performance)
	 * 
	 * @see https://gist.github.com/Asmageddon/4013485
	 * @author Asmageddon
	 */
	public static function copy<T:Dynamic>(v:T):T {
		if(!Reflect.isObject(v)) // simple type
			return v;

		if (Std.isOfType(v, IMap)) // map
			return untyped copyMap(v);

		switch(Type.typeof(v)) {
			case TClass(String):
				return v;

			case TClass(Array):
				var result = Type.createInstance(Type.getClass(v), []);
				untyped {
					for (ii in 0...v.length)
						result.push(copy(v[ii]));
				}
				return result;

			case TClass(List):
				// List would be copied just fine without this special case, but I want to avoid going recursive
				var result = Type.createInstance(Type.getClass(v), []);
				untyped {
					var iter:Iterator<Dynamic> = v.iterator();
					for (ii in iter)
						result.add(ii);
				}
				return result;

			default:
				if (Type.getClass(v) == null) { // anonymous object
					var obj:Dynamic = {};
					for (ff in Reflect.fields(v))
						Reflect.setField(obj, ff, copy(Reflect.field(v, ff)));
					
					return obj;
				} else { // class
					var obj = Type.createEmptyInstance(Type.getClass(v));
					for (ff in Reflect.fields(v))
						Reflect.setField(obj, ff, copy(Reflect.field(v, ff)));
					
					return obj;
				}
		}
		return null;
	}

	public static function copyMap<K:Dynamic, T:Dynamic>(inMap:Map<K, T>):Map<K, T> {
		var map:Map<K, T> = [];
		untyped {
			for (key in inMap.keys())
				map.set(key, copy(inMap.get(key)));
		}
		return map;
	}
}
