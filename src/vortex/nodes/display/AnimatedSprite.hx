package vortex.nodes.display;

import sdl.SDL;
import sdl.Renderer.RendererFlip;
import vortex.core.Engine;
import vortex.math.Vector2;
import vortex.math.Rectangle;
import vortex.utils.MathUtil;
import vortex.resources.animation.SpriteFrames;

class AnimatedSprite extends Node2D {
	/**
	 * The default filter for any new animated sprite created.
	 */
	public static var defaultFilter:TextureScaleMode = LINEAR;

	/**
	 * A list of animations that this sprite
	 * can display.
	 */
	public var spriteFrames:SpriteFrames;

	/**
	 * The name of the animation to display from
	 * the sprite frames.
	 */
	public var animation:String;

	/**
	 * The frame index of the currently
	 * displaying animation.
	 */
	public var frame:Int = 0;

	/**
	 * Whether or not the currently displaying
	 * animation should stay on it's current frame
	 * or cycle through every one.
	 */
	public var playing:Bool = false;

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
	 * Returns a new `AnimatedSprite`.
	 */
	public function new() {
		super();
		origin = new Vector2(0.5, 0.5);
	}

	/**
	 * Sets the currently displaying animation
	 * to any animation specified.
	 * 
	 * Set `frame` to `0` to make this animation
	 * start from it's first frame!
	 * 
	 * @param animation  The new animation to play.
	 */
	public function play(?animation:String) {
		playing = true;

		if (animation != null)
			this.animation = animation;

		var animation:SpriteAnimation = spriteFrames.animations.get(this.animation);
		if (animation == null)
			animation = spriteFrames.animations.values()[0];

		if (frame == animation.frames.length - 1)
			frame = 0;

		_animTimer = 0.0;
	}

	/**
	 * Stops the currently displaying animation.
	 * 
	 * Call `play()` with no arguments to resume it.
	 */
	public function stop() {
		this.playing = false;
	}

	/**
	 * Updates this sprite's animation.
	 */
	override function update(delta:Float) {
		if (spriteFrames == null || spriteFrames.animations == null)
			return;

		var animation:SpriteAnimation = spriteFrames.animations.get(animation);
		if (animation == null)
			animation = spriteFrames.animations.values()[0];

		if (animation == null || !playing || animation.frames.length < 2)
			return;

		_animTimer += delta;
		if (_animTimer > (1.0 / animation.fps)) {
			_animTimer = 0.0;
			if (animation.loop)
				frame = MathUtil.wrap(frame + 1, 0, animation.frames.length - 1);
			else
				frame = MathUtil.boundInt(frame + 1, 0, animation.frames.length - 1);
		}
	}

	/**
	 * Draws this sprite to the screen.
	 */
	override function draw() {
		if (spriteFrames == null || spriteFrames.texture == null || spriteFrames.animations == null)
			return;

		var animation:SpriteAnimation = spriteFrames.animations.get(animation);
		if (animation == null)
			animation = spriteFrames.animations.values()[0];

		if (animation == null || animation.frames.length == 0)
			return;

		final frame:SpriteFrame = animation.frames[frame];

		_vector.set(
			origin.x * (animation.frames[0].size.x * Math.abs(scale.x)), 
			origin.y * (animation.frames[0].size.y * Math.abs(scale.y))
		);
		_rect.set(
			frame.sourcePos.x, frame.sourcePos.y, 
			frame.size.x, frame.size.y
		);
		_rect2.set(
			position.x - _vector.x, 
			position.y - _vector.y, 
			_rect.width * Math.abs(scale.x), 
			_rect.height * Math.abs(scale.y)
		);

		final cosMult:Float = MathUtil.fastCos(rotation);
		final sinMult:Float = MathUtil.fastSin(rotation);

		_rect2.add(
			(frame.offset.x * Math.abs(scale.x)) * cosMult + (frame.offset.y * Math.abs(scale.y)) * -sinMult,
			(frame.offset.x * Math.abs(scale.x)) * sinMult + (frame.offset.y * Math.abs(scale.y)) * cosMult
		);

		var flip:RendererFlip = NONE;
		if (scale.x < 0)
			flip |= HORIZONTAL;
		if (scale.y < 0)
			flip |= VERTICAL;

		SDL.setTextureScaleMode(spriteFrames.texture._nativeTexture, filter);
		SDL.renderCopyExF(
			_window._nativeRenderer, 
			spriteFrames.texture._nativeTexture, 
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
	private var _animTimer:Float = 0.0;
}
