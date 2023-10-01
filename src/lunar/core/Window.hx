package lunar.core;

import sdl.SDL;
import sdl.Renderer;
import sdl.Window.WindowPos;
import sdl.Window as SDLWindow;
import sdl.Window.WindowInitFlags;

import lunar.debug.Debug;

@:allow(lunar.core.Game)
class Window {
    /**
     * The data for configuring this window.
     */
    public var config:WindowConfig;

    /**
     * Whether or not this window has been closed.
     */
    public var closed:Bool = false;

    /**
     * Whether or not this window has been initialized.
     */
    public var initialized:Bool = false;

    public function new() {}

    public function init() {
        if(config == null) {
            Debug.error('The window configuration has not been set yet!');
            return false;
        }
        if(initialized == (initialized = true))
            return false;

        window = SDL.createWindow(config.title, config.x, config.y, config.width, config.height, WindowInitFlags.RESIZABLE);
        if(window == null) {
            Debug.error('The window failed to initialize! - ${SDL.getError()}');
            return false;
        }

        renderer = SDL.createRenderer(window, -1, RenderFlags.ACCELERATED);
        if(renderer == null) {
            Debug.error('The renderer failed to initialize! - ${SDL.getError()}');
            return false;
        }

        Debug.log('Window successfully initialized!');
        return true;
    }

    public function update(delta:Float) {
        
    }

    private var window:SDLWindow;
    private var renderer:Renderer;
}

@:structInit
class WindowConfig {
    public var title:String;
    public var width:Int;
    public var height:Int;
    public var x:Int = WindowPos.CENTERED;
    public var y:Int = WindowPos.CENTERED;
    public var clearColor:lunar.utils.Color;
}