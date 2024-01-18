package vortex.servers;

import vortex.servers.rendering.*;
import vortex.utils.math.Rectanglei;

enum RenderingBackend {
    /**
     * The OpenGL rendering backend.
     * Supports shaders and older GPUs and may run better than the SDL backend.
     */
    OPENGL;

    /**
     * The Vulkan rendering backend.
     * Supports new GPUs better and may run better than SDL and OpenGL.
     * 
     * TODO: implement me after 1.0.0!
     */
    VULKAN;

    /**
     * The SDL rendering backend.
     * This is a fallback renderer and lacks shader support.
     * 
     * TODO: implement me!
     */
    SDL;
}

extern interface IRenderingBackendImpl {
    /**
     * Initializes this rendering backend.
     */
    public static function init():Void;

    /**
     * Sets the values of the current viewport rectangle.
     */
    public static function setViewportRect():Void;

    /**
     * Clears whatever is on-screen currently.
     */
    public static function clear():Void;

    /**
     * Presents/renders whatever is on-screen currently.
     */
    public static function present():Void;
}

class RenderingServer {
    /**
     * The current rendering backend for every window.
     * 
     * Changing it after Vortex has already initialized
     * could break/crash it!
     * 
     * Change it before `super()` is called in your Main class.
     * 
     * - `OPENGL` - The standard backend, supports shaders and works on basically any GPU.
     * - `VULKAN` - The modern backend, supports shaders and runs better, but doesn't work on older GPUs.
     * - `SDL` - The limited backend, doesn't support shaders but works on basically any GPU. 
     */
    public static var backend:RenderingBackend = OPENGL;

    /**
     * Initializes the rendering server.
     */
    public static function init():Void {
        switch(backend) {
            case OPENGL: OpenGLBackend.init();
            case VULKAN: VulkanBackend.init();
            case SDL:    SDLBackend.init();
        }
    }

    /**
     * Sets the values of the current viewport rectangle.
     */
    public static function setViewportRect(rect:Rectanglei):Void {
        switch(backend) {
            case OPENGL: OpenGLBackend.setViewportRect(rect);
            case VULKAN: VulkanBackend.setViewportRect(rect);
            case SDL:    SDLBackend.setViewportRect(rect);
        }
    }

    /**
     * Clears whatever is on-screen currently.
     */
    public static function clear():Void {
        switch(backend) {
            case OPENGL: OpenGLBackend.clear();
            case VULKAN: VulkanBackend.clear();
            case SDL:    SDLBackend.clear();
        }
    }
 
    /**
     * Presents/renders whatever is on-screen currently.
     */
    public static function present():Void {
        switch(backend) {
            case OPENGL: OpenGLBackend.present();
            case VULKAN: VulkanBackend.present();
            case SDL:    SDLBackend.present();
        }
    }
}