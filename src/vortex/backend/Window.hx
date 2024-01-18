package vortex.backend;

#if (!macro && !eval && cpp)
import sdl.Types.WindowInitFlags;
import sdl.SDL;
import sdl.Types.Window as NativeWindow;
import sdl.Types.GlContext;
#end

import vortex.backend.interfaces.IDisposable;
import vortex.utils.math.Vector2i;

class Window implements IDisposable {
	/**
     * Whether or not this object has been
     * disposed.
     */
    public var disposed:Bool = false;

    /**
     * The X and Y coordinates of this window
     * on the screen.
     */
    public var position:Vector2i;

    /**
     * The width and height of this window
     * in pixels.
     */
    public var size:Vector2i;

    /**
     * The initial width and height of this window
     * in pixels.
     */
    public var initialSize(default, null):Vector2i;

    /**
     * Makes a new `Window`.
     */
    public function new(title:String, position:Vector2i, size:Vector2i) {
        @:bypassAccessor this.position = position;
        @:bypassAccessor this.size = size;
        initialSize = new Vector2i().copyFrom(size);

        #if (!macro && !eval && cpp)
        var wFlags:WindowInitFlags = OPENGL;
        if(Application.self.meta.window.resizable)
            wFlags |= RESIZABLE;

        _nativeWindow = SDL.createWindow(title, position.x, position.y, size.x, size.y, wFlags);
        _glContext = SDL.glCreateContext(_nativeWindow);
        
        SDL.glMakeCurrent(_nativeWindow, _glContext);
        SDL.glSetSwapInterval(0);

        @:privateAccess {
            this.position._onChange = (x:Int, y:Int) -> {
                SDL.setWindowPosition(_nativeWindow, x, y);
            };
            this.size._onChange = (x:Int, y:Int) -> {
                SDL.setWindowSize(_nativeWindow, x, y);
            };
        }
        #end
    }

     /**
      * Disposes of this object and removes it's
      * properties from memory.
      */
    public function dispose():Void {
        if(disposed == (disposed = true))
            return;

        #if (!macro && !eval && cpp)
        SDL.glDeleteContext(_glContext);
        SDL.destroyWindow(_nativeWindow);
        #end
    }

    /**
     * A shortcut function to `dispose()`.
     */
    public inline function close():Void {
        dispose();
    }

    // ------------------ //
    // Internal Variables //
    // ------------------ //
    #if (!macro && !eval && cpp)
    private var _nativeWindow:NativeWindow;
    private var _glContext:GlContext;
    #end
}