package vortex.core.assets;

import al.AL;
import cpp.Pointer;
import cpp.UInt32;
import vortex.utils.RefCounted;
import vortex.utils.typelimit.OneOfTwo;

typedef AudioStreamAsset = OneOfTwo<String, AudioStream>;

@:allow(vortex.utils.Assets)
class AudioStream extends RefCounted {
	/**
	 * The buffer ID/key of this audio stream that can be
	 * referred to later to get it from a cache of sorts.
	 */
	public var key:UInt32;

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //

	/**
	 * Frees this audio streams's properties from memory immediately.
	 */
	override function free() {
		super.free();
		AL.deleteBuffers(1, Pointer.addressOf(key));
		key = 0;
	}

	private function new() {
		this.key = 0;
	}
}
