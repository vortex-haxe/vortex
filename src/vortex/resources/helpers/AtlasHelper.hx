package vortex.resources.helpers;

import sys.io.File;
import sys.FileSystem;

import haxe.io.Path;
import haxe.xml.Access;

import vortex.resources.helpers.TypeDefs;
import vortex.utils.math.Vector2;

/**
 * A simple helper class to easily parse certain types of atlases
 * such as Sparrow and Packer into a usable `SpriteFrames` resource.
 */
class AtlasHelper {
	/**
	 * Makes a new `SpriteFrames` resource from Sparrow
	 * spritesheet data.
	 * 
	 * @param texture  The texture to attach to the sprite frames (Path or Texture instance).
	 * @param xml      The Sparrow XML data to load and parse (Path or XML data).
	 */
	public static function loadSparrow(texture:TextureResource, xml:XmlResource):SpriteFrames {
		final frames:SpriteFrames = new SpriteFrames(null);

		// Load the texture
		if(texture is String)
			frames.texture = Texture.loadFromFile(cast texture);
		else
			frames.texture = cast texture;

		// Load the XML data
		var data:Access = null;
		if(xml is String)
			data = cast Xml.parse(FileSystem.exists(xml) ? File.getContent(xml) : xml).firstElement();
		else {
			final x:Xml = cast xml;
			data = cast((x.nodeType == Element) ? x : x.firstElement());
		}

		// Parse the XML data into a valid resource
		for(sub in data.nodes.SubTexture) {
			final ro_tat_ay:Bool = (sub.has.rotated && sub.att.rotated.toLowerCase() == "true");
			final offsetX:Float = (sub.has.frameX ? -Std.parseFloat(sub.att.frameX) : 0);
			final offsetY:Float = (sub.has.frameY ? -Std.parseFloat(sub.att.frameY) : 0);
			final sizeX:Float = sub.has.width ? Std.parseFloat(sub.att.width) : 0;
			final sizeY:Float = sub.has.height ? Std.parseFloat(sub.att.height) : 0;
			frames.frames.push({
				name: sub.att.name,
				position: new Vector2(
					sub.has.x ? Std.parseFloat(sub.att.x) : 0,
					sub.has.y ? Std.parseFloat(sub.att.y) : 0
				),
				offset: new Vector2(
					offsetX,
					offsetY
				),
				size: new Vector2(
					sizeX,
					sizeY
				),
				marginSize: new Vector2(
					sub.has.frameWidth ? Std.parseFloat(sub.att.frameWidth) : sizeX,
					sub.has.frameHeight ? Std.parseFloat(sub.att.frameHeight) : sizeY
				),
				angle: ro_tat_ay ? Math.PI * -0.5 : 0.0
			});
		}

		return frames;
	}
}