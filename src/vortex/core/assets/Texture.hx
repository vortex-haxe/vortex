package vortex.core.assets;

import sdl.SDL;
import sdl.Texture as NativeTexture;

import vortex.math.Vector2;
import vortex.utils.RefCounted;

/**
 * A simple class containing basic data for a texture.
 */
@:allow(vortex.nodes.display.Sprite)
@:allow(vortex.utils.Assets)
class Texture extends RefCounted {
	/**
	 * The width and height of this texture in pixels.
	 */
	public var size:Vector2;

	//##==-------------------------------------------------==##//
	//##==----- Don't modify these parts below unless -----==##//
	//##==-- you are here to fix a bug or add a feature. --==##//
	//##==-------------------------------------------------==##//

	/**
	 * Frees this textures's properties from memory immediately.
	 */
	override function free() {
		super.free();

		SDL.destroyTexture(_nativeTexture);
		_nativeTexture = null;
	}

	private function new(nativeTexture:NativeTexture) {
		this._nativeTexture = nativeTexture;

		var _size:Point = SDL.getTextureSize(nativeTexture);
		this.size = new Vector2(_size.x, _size.y);
	}

	private var _nativeTexture:NativeTexture;
}