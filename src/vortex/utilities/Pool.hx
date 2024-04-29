package vortex.utilities;

import vortex.utilities.DestroyUtil.IDestroyable;

/**
 * Helper type that allows the `Pool` constructor to take
 * a function parameter and a `Class<T>` parameter.
 */
abstract PoolFactory<T:IDestroyable>(() -> T) {
    @:from
    public static inline function fromClass<T:IDestroyable>(classRef:Class<T>):PoolFactory<T> {
        return fromFunction(() -> Type.createInstance(classRef, []));
    }

    @:from
    public static inline function fromFunction<T:IDestroyable>(func:() -> T):PoolFactory<T> {
        return cast func;
    }

    @:allow(vortex.utilities.Pool)
    inline function getFunction():() -> T {
        return this;
    }
}

/**
 * A generic container that facilitates pooling and recycling of objects.
 * 
 * WARNING: Pooled objects must have parameter-less constructors: function new()
 */
class Pool<T:IDestroyable> implements IPool<T> {
    /**
     * The amount of objects currently in this pool.
     */
    public var length(get, never):Int;

    /**
     * Creates a pool of the specified type
     * 
     * @param   constructor  A function that takes no args and creates an instance,
     *                       example: `Rect.new.bind(0, 0, 0, 0)`
     */
    public function new(constructor:PoolFactory<T>) {
        _constructor = constructor.getFunction();
    }

    /**
     * Returns an item from this pool.
     */
    public function get():T {
        final obj:T = (_count == 0) ? _constructor() : _pool[--_count];
        return obj;
    }

    /**
     * Puts a given item back into this pool.
     * 
     * @param  obj  The object to put back into the pool. 
     */
    public function put(obj:T):Void {
        if(obj != null) {
            var i:Int = _pool.indexOf(obj);
            if (i == -1 || i >= _count)
                putHelper(obj);
        }
    }

    /**
     * Pre-allocates a given amount of this pool's
     * allowed item into this pool.
     * 
     * @param  numObjects  The amount of objects to allocate.
     */
    public function preAllocate(numObjects:Int):Void {
        while(numObjects-- > 0)
            _pool[_count++] = _constructor();
    }

    public function clear():Array<T> {
        _count = 0;
        var oldPool = _pool;
        _pool = [];
        return oldPool;
    }

    // --------------- //
    // [ Private API ] //
    // --------------- //

    private var _pool:Array<T> = [];
    private var _constructor:() -> T;

    /**
     * Objects aren't actually removed from the array in order to improve performance.
     * _count keeps track of the valid, accessible pool objects.
     */
    private var _count:Int = 0;

    private function putUnsafe(obj:T):Void {
        if(obj != null)
            putHelper(obj);
    }

    private function putHelper(obj:T) {
        obj.destroy();
        _pool[_count++] = obj;
    }

    @:noCompletion
    private inline function get_length():Int {
        return _count;
    }
}

interface IPooled extends IDestroyable {
    function put():Void;
}

interface IPool<T:IDestroyable> {
    function preAllocate(numObjects:Int):Void;
    function clear():Array<T>;
}
