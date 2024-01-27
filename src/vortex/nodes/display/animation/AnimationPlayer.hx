package vortex.nodes.display.animation;

import vortex.resources.SpriteFrames.AnimationFrame;

import vortex.utils.generic.Signal;
import vortex.utils.generic.SortUtil;
import vortex.utils.math.Vector2;
import vortex.utils.math.MathUtil;

typedef AnimationData = {
	var frames:Array<AnimationFrame>;
	var fps:Float;
	var loop:Bool;
	var offset:Vector2;
}

/**
 * A basic animation player that can play
 * animation data attached to an `AnimatedSprite`.
 */
class AnimationPlayer {
	/**
	 * The data of the currently playing animation.
	 * 
	 * ⚠ **WARNING**: This can be `null`!
	 */
	public var curAnim:AnimationData;

	/**
	 * The name of the currently playing animation.
	 * 
	 * ⚠ **WARNING**: This can be `null`!
	 */
	public var name:String;

	/**
	 * Whether or not the current animation is playing.
	 */
	public var playing:Bool = false;

	/**
	 * The signal that gets emitted when the current animation
	 * has finished playing.
	 */
	public var finished:Signal<Void->Void> = new Signal();

	/**
	 * Whether or not the current animation is reversed.
	 */
	public var reversed:Bool = false;

	/**
	 * The current frame index of the animation.
	 */
	public var frame(default, set):Int = 0;

	/**
         * Defines how fast the animations are played.
         */
	public var rate:Float = 1.0;

	/**
	 * Makes a new `AnimationPlayer`.
	 */
	public function new(parent:AnimatedSprite) {
		this.parent = parent;
	}

	/**
	 * Adds an animation based on specified frame indices.
	 * 
	 * @param name    The name of the animation.
	 * @param frames  The frame indices for the animation.
	 * @param fps     The frames per second this animation should play at.
	 * @param loop    Whether or not this animation should loop.
	 * @param offset  The X and Y position offset for this animation. Defaults to `Vector2.ZERO`.
	 */
	public function add(name:String, frames:Array<Int>, ?fps:Float = 30, ?loop:Bool = false, ?offset:Vector2) {
		if(offset == null)
			offset = Vector2.ZERO;
		
		_data.set(name, {frames: [], fps: fps, loop: loop, offset: offset});
		final anim:AnimationData = _data.get(name);

		if(frames != null) {
			for(i in frames)
				anim.frames.push(parent.frames.frames[i]);
		}
	}

	/**
	 * Adds an animation based on frames that
	 * start with a specified `prefix`.
	 * 
	 * @param name    The name of the animation.
	 * @param prefix  The prefix to get frames from (Case-sensitive).
	 * @param fps     The frames per second this animation should play at.
	 * @param loop    Whether or not this animation should loop.
	 * @param offset  The X and Y position offset for this animation. Defaults to `Vector2.ZERO`.
	 */
	public function addByPrefix(name:String, prefix:String, ?fps:Float = 30, ?loop:Bool = false, ?offset:Vector2) {
		if(offset == null)
			offset = Vector2.ZERO;
		
		_data.set(name, {frames: [], fps: fps, loop: loop, offset: offset});
		final anim:AnimationData = _data.get(name);

		for(pFrame in parent.frames.frames) {
			final aName:String = pFrame.name.substring(0, pFrame.name.length - 4);
			if(aName == prefix)
				anim.frames.push(pFrame);
		}

		anim.frames.sort((a:AnimationFrame, b:AnimationFrame) -> {
			final aID:Int = Std.parseInt(a.name.substring(a.name.length - 4, a.name.length));
			final bID:Int = Std.parseInt(b.name.substring(b.name.length - 4, b.name.length));
			return SortUtil.byValues(SortUtil.ASCENDING, aID, bID);
		});
	}

	/**
	 * Similar to `addByPrefix`, but it only uses frames
	 * whose indices match those specified in the `indices` list.
	 * 
	 * @param name     The name of the animation.
	 * @param prefix   The prefix to get frames from.
	 * @param indices  The frame indexes for the animation.
	 * @param fps      The frames per second this animation should play at.
	 * @param loop     Whether or not this animation should loop.
	 * @param offset   The X and Y position offset for this animation. Defaults to `Vector2.ZERO`.
	 */
	public function addByIndices(name:String, prefix:String, indices:Array<Int>, ?fps:Float = 30, ?loop:Bool = false, ?offset:Vector2) {
		if(offset == null)
			offset = Vector2.ZERO;
		
		_data.set(name, {frames: [], fps: fps, loop: loop, offset: offset});
		final anim:AnimationData = _data.get(name);

		final allFrames:Array<AnimationFrame> = [];
		for(pFrame in parent.frames.frames) {
			final aName:String = pFrame.name.substring(0, pFrame.name.length - 4);
			if(aName == prefix)
				allFrames.push(pFrame);
		}

		for(num in indices)
			anim.frames.push(allFrames[num]);
		
		anim.frames.sort((a:AnimationFrame, b:AnimationFrame) -> {
			final aID:Int = Std.parseInt(a.name.substring(a.name.length - 4, a.name.length));
			final bID:Int = Std.parseInt(b.name.substring(b.name.length - 4, b.name.length));
			return SortUtil.byValues(SortUtil.ASCENDING, aID, bID);
		});
	}

	/**
	 * Removes a specified animation.
	 * 
	 * @param name  The animation to remove.
	 */
	public function remove(name:String) {
		if(_data.exists(name)) {
			if(this.name == name) {
				this.name = null;
				this.curAnim = null;
			}
			_data.set(name, null);
			_data.remove(name);
		} else
			Debug.error('Cannot remove non-existent animation: ${name}!');
	}

	/**
	 * Plays a specified animation.
	 * 
	 * @param name     The name of the animation to play
	 * @param restart  Whether or not this animation should jump to the specified `frame` when playing.
	 * @param frame    The frame to start the animation on. (Default is 0)
	 * @param reverse  Whether or not to play the animation in reverse.
	 */
	public function play(name:String, ?restart:Bool = false, ?frame:Int = 0, ?reverse:Bool = false) {
		if(!_data.exists(name)) {
			Debug.warn('Animation called "${name}" doesn\'t exist!');
			return;
		}
		if(this.name != name || !playing || restart) {
			this.name = name;
			this.reversed = reverse;

			if(!playing || restart)
				this.frame = frame;

			curAnim = _data.get(name);
			_frameDelay = 1 / curAnim.fps;
			playing = true;
		}
	}

	/**
	 * Allows the animation to step up a frame.
	 * 
	 * @param delta  The time between the last frame in seconds.
	 */
	public function tick(delta:Float) {
		if(curAnim == null)
			return;
		
		_frameTimer += delta * rate;
		if(_frameTimer >= _frameDelay && (playing || curAnim.loop)) {
			final boundFunc = (curAnim.loop) ? MathUtil.wrap : MathUtil.boundInt;
			final oldFrame = frame;
			
			if(reversed) {
				frame = boundFunc(frame - 1, 0, curAnim.frames.length - 1);
				playing = (frame != 0);
			} else {
				frame = boundFunc(frame + 1, 0, curAnim.frames.length - 1);
				playing = (frame < curAnim.frames.length - 1);
			}
			
			if(!playing && oldFrame != frame)
				finished.emit();
		}
	}

	// -------- //
	// Privates //
	// -------- //
	private var parent:AnimatedSprite;
	private var _data:Map<String, AnimationData> = [];
	private var _frameTimer:Float = 0;
	private var _frameDelay:Float = 0;

	// ----------------- //
	// Getters & Setters //
	// ----------------- //
	@:noCompletion
	private inline function set_frame(newFrame:Int):Int {
		_frameTimer = 0;
		return frame = newFrame;
	}
}
