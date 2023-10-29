package lunar.core;

import sdl.Window.WindowPos;
import sdl.SDL;
import sdl.Image;
import sdl.Event;
import sdl.ttf.TTF;

import lunar.debug.Debug;
import lunar.utils.Color as LunarColor;

import lunar.display.Scene;

class Game {
    /**
     * The time between the current and last frame in seconds.
     */
    public static var deltaTime:Float = 0.0;

    /**
     * The root of the entire game, where all nodes
     * are located.
     */
    public static var tree:Tree;

    /**
     * The data for initially configuring the game.
     */
    public var config:GameConfig;

    /**
     * Puts a new window on-screen and starts up the game-loop.
     */
    public function start() {
        if(SDL.init(VIDEO) < 0) {
            Debug.error('SDL failed to initialize video! - ${SDL.getError()}');
            return;
        }
        if(SDL.init(EVENTS) < 0) {
            Debug.error('SDL failed to initialize events! - ${SDL.getError()}');
            return;
        }
        if(Image.init(EVERYTHING) == 0) {
            Debug.error('SDL image failed to initialize! - ${SDL.getError()}');
            return;
        }
        if(TTF.init() < 0) {
            Debug.error('SDL ttf failed to initialize! - ${SDL.getError()}');
            return;
        }
        Debug.init();

        tree = new Tree();
        tree.window = new Window(config.title, CENTERED, CENTERED, config.width, config.height);
        
        tree.currentScene = config.initialScene ?? new Scene();
        tree.currentScene.ready();
        
        running = tree.window.initialized;
        if(!running) return;

        final event:Event = SDL.createEventPtr();
        while(running) {
            SDL.pollEvent(event);

            switch(event.ref.type) {
                case QUIT:
                    running = false;

                default: // Stops haxe from complaining
            }

            final cc = config.clearColor;
            SDL.setRenderDrawColor(tree.window.renderer, Std.int(cc.r * 255), Std.int(cc.g * 255), Std.int(cc.b * 255), Std.int(cc.a * 255));
            SDL.renderClear(tree.window.renderer);
            SDL.renderPresent(tree.window.renderer);
            
            final curTime:Int = cast SDL.getPerformanceCounter();
            Game.deltaTime = ((curTime - lastTime) / (cast SDL.getPerformanceFrequency()));
            
            tree.update(Game.deltaTime);
            if(tree.currentScene != null) {
                tree.currentScene.update(deltaTime);
                tree.currentScene.draw();
            }
            tree.draw();

            lastTime = curTime;
            SDL.delay(Std.int(1000 / config.maxFPS));
        }
        stop();
    }
    
    /**
     * Immediately stops the game-loop and closes the window
     * attached to the game.
     */
    public function stop() {
        tree.window.closed = true;
        
        SDL.destroyWindow(tree.window.window);
        SDL.destroyRenderer(tree.window.renderer);

        TTF.quit();
        Image.quit();
        SDL.quit();
    }

    public function new() {}

    private var lastTime:Int = 0;
    private var running:Bool = false;
}

@:structInit
class GameConfig {
    public var title:String;
    public var width:Int;
    public var height:Int;
    public var clearColor:LunarColor = LunarColor.BLACK;
    public var maxFPS:Int = 60;
    public var initialScene:Scene = new Scene();
}