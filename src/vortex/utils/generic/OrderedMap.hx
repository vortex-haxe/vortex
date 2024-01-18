package vortex.utils;

/**
 * A class similar to Haxe's built in `Map` class,
 * except the keys and values are ordered, and are stored in arrays.
 * 
 * These maps **CANNOT** be constructed with `[]`.
 */
@:forward
@:transitive
abstract OrderedMap<T1, T2>(OrderedMapImpl<T1, T2>) from OrderedMapImpl<T1, T2> to OrderedMapImpl<T1, T2> {
	/**
	 * Returns a new `OrderedMap`.
	 */
	public function new() {
		this = new OrderedMapImpl<T1, T2>();
	}

	/**
	 * Returns the current mapping of `key`.
	 * 
	 * If no such mapping exists, `null` is returned.
	 * 
	 * If `key` is `null`, `null` will be returned.
	 */
	@:op([]) public inline function get(key:T1):Null<T2> {
		return this.get(key);
	}

	/**
	 * Maps `key` to `value`.
	 * 
	 * If `key` already has a mapping, the previous value is removed.
	 * 
	 * If `key` is null, Nothing will be set.
	 */
	@:op([]) public inline function set(key:T1, value:T2):Void {
		return this.set(key, value);
	}
}

class OrderedMapImpl<T1, T2> {
	/**
	 * Returns a new `OrderedMapImpl`.
	 */
	public function new() {}

	/**
	 * Returns whether or not a mapping of `key` exists in this map.
	 */
	public function exists(key:T1):Bool {
		return _keys.indexOf(key) != -1;
	}

	/**
	 * Returns the current mapping of `key`.
	 * 
	 * If no such mapping exists, `null` is returned.
	 * 
	 * If `key` is `null`, `null` will be returned.
	 */
	public function get(key:T1):Null<T2> {
		if (key == null)
			return null;
		return _values[_keys.indexOf(key)];
	}

	/**
	 * Maps `key` to `value`.
	 * 
	 * If `key` already has a mapping, the previous value is removed.
	 * 
	 * If `key` is null, Nothing will be set.
	 */
	public function set(key:T1, value:T2):Void {
		if (key == null)
			return;

		if (!_keys.contains(key)) {
			_keys.push(key);
			_values.push(value);
		} else {
			final idx:Int = _keys.indexOf(key);
			_values[idx] = value;
		}
	}

	/**
	 * Removes the mapping of `key` and returns true if such a mapping existed,
	 * false otherwise.
	 * 
	 * If `key` is `null`, `false` is returned.
	 */
	public function remove(key:T1):Bool {
		if (key == null)
			return false;

		final idx:Int = _keys.indexOf(key);
		if (idx != -1) {
			_keys.splice(idx, 1);
			_values.splice(idx, 1);
		}
		return idx != -1;
	}

	/**
	 * Returns the keys of this `OrderedMap`.
	 */
	public function keys():Array<T1> {
		return _keys;
	}

	/**
	 * Returns the values of this `OrderedMap`.
	 */
	public function values():Array<T2> {
		return _values;
	}

	/**
	 * Clears this `OrderedMap`'s keys and values.
	 */
	public function clear():Void {
		_keys = [];
		_values = [];
	}

	/**
	 * Returns a human-readable version of this `OrderedMap`.
	 */
	public function toString():String {
		var len:Int = _keys.length;
		var str:String = "[";
		for (i in 0...len)
			str += Std.string(_keys[i]) + " => " + Std.string(_values[i]) + (i != len - 1 ? ", " : "");

		return str + "]";
	}

	public inline function iterator():Iterator<T2> {
		return new OrderedMapIterator(this);
	}

	public inline function keyValueIterator():KeyValueIterator<T1, T2> {
		return new OrderedMapKeyValueIterator(this);
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //
	@:noCompletion
	private var _keys:Array<T1> = [];

	@:noCompletion
	private var _values:Array<T2> = [];
}

private class OrderedMapIterator<V> {
	private var map:OrderedMapImpl<Dynamic, V>;
	private var index:Int = 0;

	public inline function new(omap:OrderedMapImpl<Dynamic, V>) {
		map = omap;
	}

	public inline function hasNext():Bool {
		@:privateAccess
		return index < map._keys.length;
	}

	public inline function next():V {
		@:privateAccess
		return map.get(map._keys[index++]);
	}
}

private class OrderedMapKeyValueIterator<K, V> {
	private var map:OrderedMapImpl<K, V>;
	private var index:Int = 0;

	public inline function new(omap:OrderedMapImpl<K, V>) {
		map = omap;
	}

	public inline function hasNext():Bool {
		@:privateAccess
		return index < map._keys.length;
	}

	public inline function next():{key:K, value:V} {
		@:privateAccess
		final key:K = map._keys[index++];
		return {key: key, value: map.get(key)};
	}
}
