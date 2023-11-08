package vortex.utils;

import vortex.core.interfaces.IFreeable;

class RefCounted implements IFreeable {
	/**
	 * How many references this object has.
	 */
	public var refs(default, set):Int = 0;

	/**
	 * Increases the reference counter.
	 */
	public function reference() {
		if (refs < 1)
			return;
		@:bypassAccessor refs++;
	}

	/**
	 * Decreases the reference counter.
	 */
	public function unreference() {
		if (refs > 0)
			@:bypassAccessor refs--;
		if (refs == 0)
			free();
	}

	/**
	 * Frees this object's properties from memory immediately.
	 */
	public function free() {
		@:bypassAccessor refs = -1;
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //

	@:noCompletion
	private function set_refs(value:Int):Int {
		return value;
	}
}
