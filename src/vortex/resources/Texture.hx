package vortex.resources;

import vortex.servers.RenderingServer;
import vortex.servers.RenderingServer.ITextureData;

import vortex.utils.math.Vector2i;

// ! TODO: stb_image is slow at loading images, replace with
// ! other image loading libraries later!

/**
 * A simple texture class including basic data such as
 * width, height, pixels, etc.
 */
class Texture extends Resource {
	private var textureData:ITextureData = null;

	/**
	 * The file path to the image that this texture used.
	 * 
	 * Blank if this texture wasn't loaded from a file.
	 */
	public var filePath:String = "";

	/**
	 * The width and height of the texture in pixels.
	 */
	public var size:Vector2i = Vector2i.ZERO;

	/**
	 * The amount of channels in this texture.
	 */
	public var numChannels:Int = 0;

	/**
	 * Makes a new `Texture`.
	 */
	public function new() {
		super();
	}

	override function dispose() {
		if(!disposed && textureData != null) {
			RenderingServer.backend.disposeTexture(textureData);
		}
		disposed = true;
	}
}