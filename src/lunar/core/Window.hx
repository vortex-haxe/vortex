package lunar.core;

import sdl.SDL;
import sdl.Renderer;
import sdl.Window.WindowPos;
import sdl.Window as SDLWindow;
import sdl.Window.WindowInitFlags;

import lunar.core.Basic;
import lunar.debug.Debug;

@:allow(lunar.core.Game)
class Window extends Basic {
    /**
     * Whether or not this window has been closed.
     */
    public var closed:Bool = false;

    /**
     * Whether or not this window has been initialized.
     */
    public var initialized:Bool = false;

    /**
     * The X position of this window in pixels.
     */
    public var x(get, set):Int;

    /**
     * The Y position of this window in pixels.
     */
    public var y(get, set):Int;

    /**
     * The width of this window in pixels.
     */
    public var width(get, set):Int;

    /**
     * The height of this window in pixels.
     */
    public var height(get, set):Int;

    /**
     * The text that shows up in the window's title bar.
     */
    public var title(get, set):String;

    public function new(title:String, x:Int = CENTERED, y:Int = CENTERED, width:Int = 1, height:Int = 1) {
        super();
        if(initialized == (initialized = true))
            return;

        window = SDL.createWindow(title, x, y, width, height, WindowInitFlags.RESIZABLE);
        if(window == null) {
            Debug.error('The window failed to initialize! - ${SDL.getError()}');
            initialized = false;
            return;
        }
        
        renderer = SDL.createRenderer(window, -1, RenderFlags.ACCELERATED);
        if(renderer == null) {
            Debug.error('The renderer failed to initialize! - ${SDL.getError()}');
            initialized = false;
            return;
        }
    }

    //##==-- Privates --==##//

    private var window:SDLWindow;
    private var renderer:Renderer;

    @:noCompletion
    private inline function get_x():Int {
        return SDL.getWindowPosition(window).x;
    }
    
    @:noCompletion
    private inline function set_x(value:Int):Int {
        SDL.setWindowPosition(window, value, y);
        return value;
    }

    @:noCompletion
    private inline function get_y():Int {
        return SDL.getWindowPosition(window).y;
    }
    
    @:noCompletion
    private inline function set_y(value:Int):Int {
        SDL.setWindowPosition(window, x, value);
        return value;
    }

    @:noCompletion
    private inline function get_width():Int {
        return SDL.getWindowSize(window).x;
    }
    
    @:noCompletion
    private inline function set_width(value:Int):Int {
        SDL.setWindowSize(window, value, height);
        return value;
    }

    @:noCompletion
    private inline function get_height():Int {
        return SDL.getWindowSize(window).y;
    }
    
    @:noCompletion
    private inline function set_height(value:Int):Int {
        SDL.setWindowSize(window, width, value);
        return value;
    }

    @:noCompletion
    private inline function get_title():String {
        return cast SDL.getWindowTitle(window);
    }

    @:noCompletion
    private inline function set_title(value:String):String {
        SDL.setWindowTitle(window, value);
        return value;
    }
}