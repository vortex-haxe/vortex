package vortex.nodes.display;

import sdl.SDL;
import sdl.Renderer.RendererFlip;
import vortex.core.Engine;
import vortex.core.assets.Texture;
import vortex.math.Vector2;
import vortex.math.Rectangle;

class Sprite extends Node2D {
	/**
	 * The default filter for any new sprite created.
	 */
	public static var defaultFilter:TextureScaleMode = LINEAR;

	/**
	 * The texture that this sprite renders.
	 */
	public var texture(default, set):Texture;

	/**
	 * The rotation origin of this sprite.
	 * 
	 * - `0` (X) = Left side of the texture.
	 * - `0` (Y) = Top of the texture.
	 * 
	 * - `0.5` (X) = Half of the texture's width.
	 * - `0.5` (Y) = Half of the texture's height
	 * 
	 * - `1` (X) = Right side of the texture.
	 * - `1` (Y) = Bottom of the texture.
	 */
	public var origin:Vector2;

	/**
	 * The filter this sprite has when scaled up or down.
	 * 
	 * `NEAREST` is best for pixel art sprites, and
	 * `LINEAR` is usually fine for higher quality sprites.
	 */
	public var filter:TextureScaleMode = defaultFilter;

	/**
	 * Returns a new `Sprite`.
	 */
	public function new() {
		super();
		origin = new Vector2(0.5, 0.5);
	}

	/**
	 * Draws this sprite to the screen.
	 */
	override function draw() {
		if (texture == null)
			return;

		_rect.set(0, 0, texture.size.x, texture.size.y);
		_rect2.set(position.x, position.y, texture.size.x * Math.abs(scale.x), texture.size.y * Math.abs(scale.y));
		_vector.set(origin.x * _rect2.width, origin.y * _rect2.height);
		_rect2.subtract(_vector.x, _vector.y);

		var flip:RendererFlip = NONE;
		if (scale.x < 0)
			flip |= HORIZONTAL;
		if (scale.y < 0)
			flip |= VERTICAL;

		SDL.setTextureScaleMode(texture._nativeTexture, filter);
		SDL.renderCopyExF(
			_window._nativeRenderer, 
			texture._nativeTexture, 
			_rect._recti, _rect2._rect, 
			rotationDegrees, _vector._point, 
			flip
		);
	}

	/**
	 * Frees every property of this sprite from memory immediately.
	 * 
	 * Can cause crashes if this sprite is used after it is freed.
	 */
	override function free() {
		super.free();
		texture.unreference();
		texture = null;
		origin = null;
	}

	// ##==-------------------------------------------------==## //
	// ##==----- Don't modify these parts below unless -----==## //
	// ##==-- you are here to fix a bug or add a feature. --==## //
	// ##==-------------------------------------------------==## //
	private static var _vector:Vector2 = new Vector2();
	private static var _rect:Rectangle = new Rectangle();
	private static var _rect2:Rectangle = new Rectangle();

	private var _window:Window = Engine.tree.window;

	@:noCompletion
	private function set_texture(newTexture:Texture):Texture {
		if (texture == newTexture)
			return texture;

		if (texture != null)
			texture.unreference();

		return texture = newTexture;
	}
}
