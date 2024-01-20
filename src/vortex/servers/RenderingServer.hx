package vortex.servers;

import vortex.backend.Application;
import vortex.servers.rendering.*;
import vortex.utils.engine.Color;
import vortex.utils.math.Rectanglei;

enum RenderingBackend {
	/**
	 * The OpenGL rendering backend.
	 * Supports shaders and older GPUs and may run better than the SDL backend.
	 */
	OPENGL_BACKEND;

	/**
	 * The Vulkan rendering backend.
	 * Supports new GPUs better and may run better than SDL and OpenGL.
	 * 
	 * TODO: implement me after 1.0.0!
	 */
	VULKAN_BACKEND;

	/**
	 * The SDL rendering backend.
	 * This is a fallback renderer and lacks shader support.
	 * 
	 * TODO: implement me!
	 */
	SDL_BACKEND;
}

class IRenderingBackendImpl {
	/**
	 * Initializes this rendering backend.
	 */
	public static function init():Void {}

	/**
	 * Sets the values of the current viewport rectangle.
	 */
	public static function setViewportRect():Void {}

	/**
	 * Clears whatever is on-screen currently.
	 */
	public static function clear():Void {}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present():Void {}

	/**
	 * Disposes of this rendering backend and removes it's
	 * properties from memory.
	 */
	public static function dispose():Void {}
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
	public static var backend:RenderingBackend = OPENGL_BACKEND;

	/**
	 * The default color displayed on an empty window.
	 * 
	 * This is defined in your `project.cfg` file.
	 */
	public static var clearColor:Color;

	/**
	 * Initializes the rendering server.
	 */
	public static function init():Void {
		// Initialize basic stuff
		clearColor = new Color().copyFrom(Application.self.meta.engine.clear_color);
		
		// Initialize the actual backend
		switch(backend) {
			case OPENGL_BACKEND: OpenGLBackend.init();
			case VULKAN_BACKEND: VulkanBackend.init();
			case SDL_BACKEND:    SDLBackend.init();
		}
	}

	/**
	 * Sets the values of the current viewport rectangle.
	 */
	public static function setViewportRect(rect:Rectanglei):Void {
		switch(backend) {
			case OPENGL_BACKEND: OpenGLBackend.setViewportRect(rect);
			case VULKAN_BACKEND: VulkanBackend.setViewportRect(rect);
			case SDL_BACKEND:    SDLBackend.setViewportRect(rect);
		}
	}

	/**
	 * Clears whatever is on-screen currently.
	 */
	public static function clear():Void {
		switch(backend) {
			case OPENGL_BACKEND: OpenGLBackend.clear();
			case VULKAN_BACKEND: VulkanBackend.clear();
			case SDL_BACKEND:    SDLBackend.clear();
		}
	}
 
	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	public static function present():Void {
		switch(backend) {
			case OPENGL_BACKEND: OpenGLBackend.present();
			case VULKAN_BACKEND: VulkanBackend.present();
			case SDL_BACKEND:    SDLBackend.present();
		}
	}

	/**
	 * Disposes of this rendering server and removes it's
	 * properties from memory.
	 */
	public static function dispose():Void {
		switch(backend) {
			case OPENGL_BACKEND: OpenGLBackend.dispose();
			case VULKAN_BACKEND: VulkanBackend.dispose();
			case SDL_BACKEND:    SDLBackend.dispose();
		}
	}
}