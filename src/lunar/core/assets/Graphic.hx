package lunar.core.assets;

import sdl.SDL;
import sdl.Texture;

import lunar.core.interfaces.IDestroyable;

/**
 * A safe container for a bitmap texture.
 */
class Graphic implements IDestroyable {
	/**
	 * Whether or not any new graphic should
	 * persist in memory.
	 */
	public static var defaultPersist:Bool = false;

	/**
	 * The width of this graphic in pixels.
	 */
	public var width(get, never):Int;

	/**
	 * The height of this graphic in pixels.
	 */
	public var height(get, never):Int;

	/**
	 * Indicates how many times this graphic has been used.
	 * 
	 * Destroys this graphic if set to `0`.
	 */
	public var useCount(default, set):Int = 0;

	/**
	 * Whether or not this graphic will stay
	 * in memory unless manually destroyed.
	 */
	public var persist:Bool = defaultPersist;

	public function new(texture:Texture) {
		this._texture = texture;
		this._size = SDL.getTextureSize(texture);
	}

	/**
	 * Destroys this graphic and makes it
	 * immediately unusable.
	 */
	public function destroy() {
		SDL.destroyTexture(_texture);
		_texture = null;
		_size = null;
	}

	//##==-- Privates --==##//
	private var _texture:Texture;
	private var _size:Point;

	@:noCompletion
	private inline function get_width():Int {
		return _size.x;
	}

	@:noCompletion
	private inline function get_height():Int {
		return _size.y;
	}

	@:noCompletion
	private inline function set_useCount(value:Int):Int {
		if(value < 1 && !persist)
			destroy();

		return useCount = value;
	}
}