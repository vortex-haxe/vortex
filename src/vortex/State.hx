package vortex;

/**
 * This is the basic "state" system.
 * Each state contains all of your objects.
 * 
 * In a simple game you may have a `MenuState` and a `PlayState`.
 * These are essentially a fancy `Container` with extra functionality.
 */
class State extends Container {
    public function new() {
        super(0);
    }

    /**
     * This is the function that gets called
     * when the game has successfully switched states.
     * 
     * Initialize your objects here instead of the
     * constructor, as weird things may happen if you do!
     */
    public function ready():Void {}
}