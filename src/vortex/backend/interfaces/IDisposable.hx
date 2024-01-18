package vortex.backend.interfaces;

interface IDisposable {
    /**
     * Whether or not this object has been
     * disposed.
     */
    public var disposed:Bool;

    /**
     * Disposes of this object and removes it's
     * properties from memory.
     */
    public function dispose():Void;
}