package vortex.servers.rendering;

import sdl.Types.PixelFormat;
import sdl.Types.Surface;
import vortex.utils.math.AngleUtil;
import vortex.backend.Window;
import vortex.utils.math.Rectanglei;
import sdl.Types.TextureAccess;
import sdl.Types.PixelFormatEnum;
import cpp.UInt8;
import cpp.RawPointer;
import vortex.utils.math.Vector2i;
import sdl.Types.Texture;
import vortex.resources.Shader;
import sdl.SDL;
import vortex.backend.Application;
import sdl.Types.Renderer;
import sdl.Types.SDL_Renderer;
import vortex.utils.math.Vector4;
import vortex.utils.engine.Color;
import vortex.resources.SpriteFrames.AnimationFrame;
import vortex.utils.math.Vector2;
import vortex.utils.math.Matrix4x4;
import vortex.servers.RenderingServer;

class SDLTextureData implements ITextureData {
	public var texture:Any;
	
	public var size:Vector2i;
	public var channels:Int;
	public var mipmaps:Bool;
	public var wrapping:TextureWrapping;
	public var filter:TextureFilter;

	// boilerplate lol!!!!
	public function new(texture:Texture, size:Vector2i, channels:Int, mipmaps:Bool,
			wrapping:TextureWrapping, filter:TextureFilter) {
		this.texture = texture;
		this.size = size;
		this.channels = channels;
		this.mipmaps = mipmaps;
		this.wrapping = wrapping;
		this.filter = filter;
	}
}

class SDLQuadRenderer implements IQuadRenderer {
	public var texture:ITextureData;
	public var shader:IShaderData;
	public var projection:Matrix4x4;

	private var renderer:Renderer;

	private var sourceRectangle:sdl.Types.Rectangle;
	private var destinationRectangle:sdl.Types.FRectangle;
	private var originPoint:sdl.Types.FPoint;
	private var vec2:Vector2;

	public function new(renderer:Renderer) {
		this.renderer = renderer;

		sourceRectangle = sdl.Types.Rectangle.create(0, 0, 0, 0);
		destinationRectangle = sdl.Types.FRectangle.create(0.0, 0.0, 0.0, 0.0);
		originPoint = sdl.Types.FPoint.create(0.0, 0.0);
		vec2 = new Vector2();
	}

	public function drawColor(position:Vector2, size:Vector2, color:Color):Void {

	}

	public function drawTexture(position:Vector2, size:Vector2, modulate:Color, sourceRect:Vector4, origin:Vector2, angle:Float):Void {
		// mmm, yummy code!
		sourceRectangle.x = Math.floor(sourceRect.x);
		sourceRectangle.y = Math.floor(sourceRect.y);
		sourceRectangle.w = Math.floor(sourceRect.z);
		sourceRectangle.h = Math.floor(sourceRect.w);

		// yipee!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 隲
		// _trans.translate(_vec3.set(position.x + (-origin.x * _vec2.x), position.y + (-origin.y * _vec2.y), 0.0));
		vec2.set((sourceRect.z - sourceRect.x) * size.x, (sourceRect.w - sourceRect.y) * size.y);

		destinationRectangle.x = position.x + (-origin.x * vec2.x);
		destinationRectangle.y = position.y + (-origin.y * vec2.y);
		destinationRectangle.w = size.x;
		destinationRectangle.h = size.y;

		// that is actually pretty simple i think
		originPoint.x = size.x * origin.x;
		originPoint.y = size.y * origin.y;

		// todo: optimize rotations and shit (not doing rn cuz i wanna get this working lol!!!!)
		SDL.setTextureColorMod(texture.texture, Math.floor(modulate.r * 255), Math.floor(modulate.g * 255), Math.floor(modulate.b * 255));
		SDL.setTextureAlphaMod(texture.texture, Math.floor(modulate.a * 255));

		SDL.renderCopyExF(renderer, texture.texture, sourceRectangle, destinationRectangle, angle * AngleUtil.TO_DEGREES, originPoint);
	}

	public function drawFrame(position:Vector2, frame:AnimationFrame, size:Vector2, scale:Vector2, modulate:Color, sourceRect:Vector4, origin:Vector2, angle:Float):Void {
		
	}

	public function dispose():Void {
		// Nothing
	}
}

/**
 * The SDL rendering backend.
 * 
 * TODO: implement me!
 */
@:access(vortex.backend.Window)
class SDLBackend extends RenderingBackend {
	private var sdlRenderer:Renderer;

	/**
	 * Initializes this rendering backend.
	 */
	override function init():Void {
		// Just for the record, shaders literally do nothing in this backend so this is just done to prevent crashing.
		// Lol.
		defaultShader = new Shader("", "");
		
		sdlRenderer = Application.self.window._nativeWindow.context;

		// for fills and shit ig
		SDL.setRenderDrawBlendMode(sdlRenderer, BLEND);

		quadRenderer = new SDLQuadRenderer(sdlRenderer);
	}

	/**
	 * Sets the values of the current viewport rectangle.
	 */
	override function setViewportRect(rect:Rectanglei):Void {
		SDL.renderSetViewport(sdlRenderer, sdl.Types.Rectangle.create(rect.x, rect.y, rect.width, rect.height));
	}

	/**
	 * Clears whatever is on-screen currently.
	 */
	override function clear(window:Window):Void {
		SDL.renderClear(sdlRenderer);
		quadRenderer.drawColor(Vector2i.ZERO, window.initialSize, RenderingServer.clearColor);
	}

	/**
	 * Presents/renders whatever is on-screen currently.
	 */
	override function present(window:Window):Void {
		DisplayServer.backend.present(window._nativeWindow);
	}

	/**
	 * TODO: Implement this!
	 */
	override function createTexture(width:Int, height:Int, data:RawPointer<UInt8>, channels:Int = 4, mipmaps:Bool = true,
			wrapping:TextureWrapping = REPEAT, filter:TextureFilter = LINEAR):ITextureData {
		// var format:PixelFormatEnum = channels == 4 ? PixelFormatEnum.RGBA32 : PixelFormatEnum.RGB24;
		
		// var texture:Texture = SDL.createTexture(sdlRenderer, untyped __cpp__('SDL_PIXELFORMAT_RGBA32'),
		// 	TextureAccess.STATIC, width, height);
		// SDL.updateTextureRaw(texture, null, data, width * channels);

		var texture:Texture = null;

		// If somebody can explain why THE FUCK THIS DOESN'T WORK
		// I will be extremely happy.

		// This is because THIS SOLUTION AND THE ONE ABOVE IT (commented out)
		// ARE USED BY DIFFERENT SDL2 EXAMPLES AND JUST DON'T FUCKING WORK????
		// :sob:
		
		untyped __cpp__("
			{0} = SDL_CreateTexture({1}, {2} == 4 ? SDL_PIXELFORMAT_RGBA32 : SDL_PIXELFORMAT_RGB24,
				SDL_TEXTUREACCESS_STREAMING, {3}, {4});
			
			int pitch;
			void *pixels;
			SDL_LockTexture({0}, NULL, &pixels, &pitch);

			memcpy(pixels, {5}, pitch * {4});

			SDL_UnlockTexture({0});

			pixels = NULL;
			pitch = 0;

			// SDL_UpdateTexture({0}, NULL, (const void*) {5}, {3} * {2});
		", texture, sdlRenderer, channels, width, height, data);

		// var surface:Surface = SDL.createRGBSurfaceWithFormatFromRaw(data, width, height, channels * 8, channels * width, format);
		// var texture:Texture = SDL.createTextureFromSurface(sdlRenderer, surface);
		// SDL.freeSurface(surface);

		var textureData:SDLTextureData = new SDLTextureData(texture, new Vector2i(width, height), channels, mipmaps,
				wrapping, filter);
		return textureData;
	}
}