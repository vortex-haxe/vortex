package lunar.display;

import lunar.core.Object;

class Group<T:Object> extends Object {
	/**
	 * The objects within this group.
	 */
	public var members(default, never):Array<T> = [];

	/**
	 * Adds an object to this group.
	 * 
	 * @return The object that was added.
	 */
	public function add(obj:T):T {
		final idx:Int = members.indexOf(obj);
		if(idx != -1)
			return obj;

		members.push(obj);
		return obj;
	}

	/**
	 * Removes an object from this group.
	 * 
	 * @return The object that was removed.
	 */
	public function remove(obj:T):T {
		final idx:Int = members.indexOf(obj);
		if(idx == -1)
			return obj;

		members.remove(obj);
		return obj;
	}

	/**
	 * Updates each object within this group.
	 */
	override function update(delta:Float) {
		for(obj in members) {
			if(obj != null && obj.active)
				obj.update(delta);
		}
	}

	/**
	 * Draws each object within this group.
	 */
	override function draw() {
		for(obj in members) {
			if(obj != null && obj.visible)
				obj.draw();
		}
	}
}