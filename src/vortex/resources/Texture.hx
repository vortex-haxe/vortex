package vortex.resources;

import cpp.Star;
import cpp.UInt8;
import cpp.UInt32;
import cpp.Pointer;

import glad.Glad;
import stb.Image;

import vortex.utils.engine.RefCounted;
import vortex.utils.math.Vector2i;

// ! stb_image is slow at loading images, replace with
// ! other image loading libraries later!

/**
 * A simple texture class including basic data such as
 * width, height, pixels, etc.
 */
class Texture extends RefCounted {
	private var _glID:UInt32;

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
	 * The pixels in this texture.
	 */
	public var pixels:Star<UInt8>;

	/**
	 * Makes a new `Texture`.
	 */
	public function new() {
		super();
		Glad.genTextures(1, Pointer.addressOf(_glID));
		Glad.bindTexture(Glad.TEXTURE_2D, _glID);
	}

	/**
	 * Makes a new `Texture` and loads data from an image
	 * located at the specified file path.
	 * 
	 * @param filePath  The path to the image to load.
	 */
	public static function loadFromFile(filePath:String) {
		final tex = new Texture();
		tex.filePath = filePath;
		
		var width:Int = 0;
		var height:Int = 0;
		tex.pixels = Image.load(filePath, Pointer.addressOf(width), Pointer.addressOf(height), Pointer.addressOf(tex.numChannels), 0);
		tex.size.set(width, height);
		
		if (tex.pixels != 0) {
			var imageFormat = (tex.numChannels == 4) ? Glad.RGBA : Glad.RGB;
			Glad.texImage2D(Glad.TEXTURE_2D, 0, imageFormat, width, height, 0, imageFormat, Glad.UNSIGNED_BYTE, tex.pixels);
			Glad.generateMipmap(Glad.TEXTURE_2D);

			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_S, Glad.REPEAT);
			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_WRAP_T, Glad.REPEAT);
			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MIN_FILTER, Glad.LINEAR);
			Glad.texParameteri(Glad.TEXTURE_2D, Glad.TEXTURE_MAG_FILTER, Glad.LINEAR);
		} else {
			Debug.error('Image at ${filePath} failed to load: ${Image.failureReason()}');
			return tex;
		}
		return tex;
	}
	
	override function dispose() {
		if(!disposed) {
			Image.freeImage(pixels);
			Glad.deleteTextures(1, Pointer.addressOf(_glID));
		}
		super.dispose();
	}
}