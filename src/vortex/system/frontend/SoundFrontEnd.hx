package vortex.system.frontend;

import vortex.utilities.DestroyUtil;
import vortex.sound.Sound;
import vortex.Container.TypedContainer;

/**
 * Accessible via `GlobalCtx.sound`.
 */
class SoundFrontEnd {
    /**
     * The list of every sound in the game.
     */
    public var list:TypedContainer<Sound> = new TypedContainer();

    /**
     * A useful container for background music.
     */
    public var music:Sound;

    /**
     * Controls the volume multiplier of all sounds.
     */
    public var volume:Float = 1;

    /**
     * Controls whether or not all sounds will be muted.
     */
    public var muted:Bool = false;

    public function new() {}

    /**
	 * Load and play some looping background music.
	 *
	 * @param  sound   The sound asset you want to loop in the background.
	 * @param  volume  The volume of the music, ranges from 0 to 1.
	 * @param  looped  Whether or not to loop this music.
	 */
    public function playMusic(sound:SoundAsset, volume:Float = 1, looped:Bool = true):Void {
        if(music == null)
            music = new Sound();
        else
            music.stop();

        music.load(sound, looped);
        music.volume = volume;

        list.add(music);
        music.play();
    }

    /**
     * Returns a recycled or new sound instance.
     * 
     * @param  sound        The sound asset to use for this sound.
     * @param  volume       The volume of this sound, ranges from 0 to 1.
     * @param  looped       Whether or not this sound will loop.
     * @param  autoDestroy  Whether or not this sound will destroy itself after it finishes playing.
     * @param  autoPlay     Whether or not this sound will immediately start playing.
     */
    public function load(?sound:SoundAsset, volume:Float = 1, looped:Bool = false, autoDestroy:Bool = false, autoPlay:Bool = false):Sound {
        final snd:Sound = list.recycle(Sound);
        if(sound != null)
            snd.load(sound);
        
        snd.looped = looped;
        snd.autoDestroy = autoDestroy;

        if(autoPlay)
            snd.play();

        return snd;
    }

    /**
     * Returns a recycled or new sound instance.
     * This sound will always automatically play.
     * 
     * @param  sound        The sound asset to use for this sound.
     * @param  volume       The volume of this sound, ranges from 0 to 1.
     * @param  looped       Whether or not this sound will loop.
     * @param  autoDestroy  Whether or not this sound will destroy itself after it finishes playing.
     */
    public function play(?sound:SoundAsset, volume:Float = 1, looped:Bool = false, autoDestroy:Bool = false):Sound {
        return load(sound, volume, looped, autoDestroy, true);
    }

    /**
     * Updates all sounds.
     */
    public function update(delta:Float):Void {
        list.update(delta);
    }

    /**
     * Destroys all sounds.
     */
    public function destroy():Void {
        list = DestroyUtil.destroy(list);
    }
}