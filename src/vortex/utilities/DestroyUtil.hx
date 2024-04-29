package vortex.utilities;

import canvas.utils.AssetCache.IDisposable;
import vortex.utilities.Pool.IPooled;

/**
 * A helper class for managing/destroying objects.
 */
class DestroyUtil {
    /**
     * Destroys a given `IDestroyable` object.
     * This will always return `null`.
     * 
     * @param  obj  The object to destroy.
     */
    public static function destroy<T:IDestroyable>(obj:T):Null<T> {
        if(obj != null)
            obj.destroy();

        return null;
    }

    /**
     * Destroys a given array filled with `IDestroyable` objects.
     * This will always return `null`.
     * 
     * @param  arr  The array to destroy.
     */
    public static function destroyArray<T:IDestroyable>(arr:Array<T>):Null<Array<T>> {
        if(arr != null) {
            for(d in arr)
                d.destroy();

            arr.resize(0);
        }
        return null;
    }
    
    /**
     * Disposes a given `IDisposable` object.
     * This will always return `null`.
     * 
     * @param  obj  The object to dispose.
     */
    public static function dispose<T:IDisposable>(obj:T):Null<T> {
        if(obj != null)
            obj.dispose();

        return null;
    }

    /**
     * Disposes a given array filled with `IDisposable` objects.
     * This will always return `null`.
     * 
     * @param  arr  The array to dispose.
     */
    public static function disposeArray<T:IDisposable>(arr:Array<T>):Null<Array<T>> {
        if(arr != null) {
            for(d in arr)
                d.dispose();

            arr.resize(0);
        }
        return null;
    }

    /**
     * Checks if the given object isn't in a pool, and
     * puts it back into it's pool if so.
     * 
     * This will always return `null`.
     * 
     * @param  obj  The object to destroy.
     */
    public static function put<T:IPooled>(obj:T):Null<T> {
        if(obj != null)
            obj.put();

        return null;
    }

    /**
     * Puts all objects in a given array filled
     * with `IPooled` objects back into their pools.
     * 
     * This will always return `null`.
     * 
     * @param  arr  The array to destroy.
     */
    public static function putArray<T:IPooled>(arr:Array<T>):Null<T> {
        if(arr != null) {
            for(d in arr)
                d.put();

            arr.resize(0);
        }
        return null;
    }
}

interface IDestroyable {
    public function destroy():Void;
}