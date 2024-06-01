package vortex.sound;

import canvas.utils.Assets;
import canvas.media.Sound as NativeSound;

import vortex.utilities.DestroyUtil;
import vortex.utilities.typelimit.OneOfThree;

typedef SoundAsset = OneOfThree<String, NativeSound, Class<NativeSound>>;

/**
 * This is the general sound object, used for music and sound effects.
 */
class Sound extends Basic {
    /**
     * The current playback time of this sound, in seconds.
     */
    public var time(get, set):Float;

    /**
     * The length of this sound, in seconds.
     */
    public var length(get, never):Float;

    /**
     * Controls whether or not this sound will loop.
     */
    public var looped(default, set):Bool = false;

    /**
     * Controls whether or not this sound is playing.
     */
    public var playing(get, set):Bool;

    /**
     * The current volume of this sound, ranges from 0 to 1.
     */
    public var volume(default, set):Float = 1;

    /**
     * Controls whether or not this sound will destroy itself
     * as soon as it finishes playing..
     */
    public var autoDestroy:Bool = false;

    /**
     * The function that gets called when this sound finishes playing.
     */
    public var onComplete:Void->Void = null;

    /**
     * Makes a new `Sound` instance and initializes
     * all of the variables for it.
     * 
     * It will NOT be ready to play by default, you must call `load()` first!
     * 
     * NOTE: You should use `GlobalCtx.sound.load()` instead of
     * constructing a sound directly!
     */
    public function new() {
        super();
        reset();
    }

    /**
     * Resets the values of this sound to defaults.
     */
    public function reset():Void {
        destroy();
        _realVolume = volume * GlobalCtx.sound.volume;
    }

    /**
     * Updates this sound.
     */
    override function update(delta:Float):Void {
        final finished:Bool = time >= length || (_lastTime != time && time < _lastTime);
        if(finished) {
            stop();
            if(onComplete != null)
                onComplete();

            if(autoDestroy)
                destroy();
        }
        _realVolume = (GlobalCtx.sound.muted) ? 0 : volume * GlobalCtx.sound.volume;
        _lastTime = time;
    }

    /**
     * Loads a given sound asset into this sound, along with
     * setting a few other values.
     * 
     * @param  sound        The sound asset to load into this sound.
     * @param  looped       Whether or not this sound will loop.
     * @param  autoDestroy  Whether or not this sound will destroy itself when it finishes playing.
     * @param  onComplete   An optional function that gets called when this sound finishes playing.
     */
    public function load(sound:SoundAsset, looped:Bool = false, autoDestroy:Bool = false, ?onComplete:Void->Void):Sound {
        if(sound is Sound)
			_nativeSound = sound;

		else if(sound is Class)
			_nativeSound = Type.createInstance(sound, []);
        
		else if(sound is String) {
			if(Assets.exists(sound))
				_nativeSound = NativeSound.fromFile(sound);
			else
				GlobalCtx.log.error('Could not find a Sound asset with an ID of \'$sound\'.');
		}
        _nativeSound.gain = _realVolume;
        return init(looped, autoDestroy, onComplete);
    }

    /**
     * Plays this sound.
     * 
     * @param  forceRestart  Whether or not to always restart this sound.
     * @param  startTime     The time to start this sound at, in seconds.
     */
    public function play(forceRestart:Bool = false, startTime:Float = 0):Sound {
		if(!playing)
            resume();
		else
			return this;
        
		if(forceRestart)
			time = startTime;
        
		return this;
    }

    /**
     * Pauses this sound.
     */
    public function pause():Void {
        if(_nativeSound != null)
            _nativeSound.playing = false;
    }

    /**
     * Resumes this sound.
     */
    public function resume():Void {
        if(_nativeSound != null)
            _nativeSound.playing = true;
    }

    /**
     * Stops this sound.
     */
    public function stop():Void {
        if(_nativeSound != null) {
            _nativeSound.playing = false;
            _nativeSound.time = 0;
        }
    }

    /**
     * Returns the volume sound multiplied by the global volume.
     * 
     * For example, if the global volume is about half (`0.5`), and
     * this sound's volume is `1`, this would return `0.5`.
     * 
     * If the global volume is about half (`0.5`), and this sound's
     * volume is `0.3`, this would return `0.15`.
     */
    public function getRealVolume():Float {
        return _realVolume;
    }

    /**
     * Destroys this sound and all
     * of it's values with it.
     * 
     * WARNING: Trying to use a destroyed sound could
     * cause an unwanted crash!
     */
    override function destroy():Void {
        stop();
        _nativeSound = DestroyUtil.dispose(_nativeSound);
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private var _lastTime:Float = 0;
    private var _realVolume(default, set):Float = 1;
    private var _nativeSound:NativeSound;

    @:noCompletion
    private function init(looped:Bool = false, autoDestroy:Bool = false, ?onComplete:Void->Void):Sound {
		this.looped = looped;
		this.autoDestroy = autoDestroy;
		this.onComplete = onComplete;
		return this;
	}

    @:noCompletion
    private function get_time():Float {
        return _nativeSound?.time ?? 0;
    }

    @:noCompletion
    private function set_time(newTime:Float):Float {
        if(_nativeSound != null)
            _nativeSound.time = newTime;

        return newTime;
    }

    @:noCompletion
    private function get_length():Float {
        @:privateAccess
        return _nativeSound?._buffer.length ?? 0;
    }

    @:noCompletion
    private function set_looped(newLoop:Bool):Bool {
        if(_nativeSound != null)
            _nativeSound.looping = newLoop;
        
        return looped = newLoop;
    }

    @:noCompletion
    private function get_playing():Bool {
        return _nativeSound?.playing ?? false;
    }

    @:noCompletion
    private function set_playing(newPlaying:Bool):Bool {
        if(_nativeSound != null)
            _nativeSound.playing = newPlaying;

        return newPlaying;
    }

    @:noCompletion
    private function set__realVolume(newVolume:Float):Float {
        _realVolume = newVolume;

        if(_nativeSound != null)
            _nativeSound.gain = _realVolume;

        return _realVolume;
    }

    @:noCompletion
    private function set_volume(newVolume:Float):Float {
        _realVolume = newVolume * GlobalCtx.sound.volume;
        return volume = newVolume;
    }
}