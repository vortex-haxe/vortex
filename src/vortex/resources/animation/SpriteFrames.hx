package vortex.resources.animation;

import haxe.xml.Access;
import vortex.utils.Assets;
import vortex.core.assets.Texture;
import vortex.core.assets.XmlAsset;
import vortex.math.Vector2;
import vortex.utils.SortUtil;
import vortex.utils.OrderedMap;
import vortex.utils.RefCounted;

using StringTools;

class SpriteFrames extends RefCounted {
	/**
	 * The texture that is used to render
	 * an animation onto a sprite.
	 */
	public var texture:Texture;

	/**
	 * The list of every animation.
	 */
	public var animations:OrderedMap<String, SpriteAnimation> = new OrderedMap();

	/**
	 * Returns a new `SpriteFrames`.
	 */
	public function new(texture:Texture) {
		this.texture = texture;
	}

	/**
	 * Parses a sparrow atlas and returns 
	 * a new `SpriteFrames` out of it.
	 * 
	 * @param texture  The texture to use for the sprite frames.
	 * @param xml      The sparrow atlas data.
	 * @param fps      The frames per second to use for each animation
	 */
	public static function fromSparrow(texture:TextureAsset, xml:XmlAsset, fps:Int):SpriteFrames {
		final key:String = (texture is String) ? '#_SPARROW_${cast texture}' : '#_SPARROW_${cast (texture, Texture).key.replace("#_TEXTURE_", "")}';
		if (!Assets._cache.exists(key)) {
			final texture:Texture = (texture is String) ? Assets.getTexture(cast texture) : cast texture;
			final xml:Access = cast(xml.getXml().firstElement());

			final frames:SpriteFrames = new SpriteFrames(texture);
			for (frame in xml.nodes.SubTexture) {
				final name:String = frame.att.name.substr(0, frame.att.name.length - 4);
				final trimmed:Bool = frame.has.frameX;

				if (!frames.animations.exists(name))
					frames.animations.set(name, {
						fps: fps,
						loop: false,
						frames: [],
						offset: new Vector2()
					});

				final animation = frames.animations.get(name);
				animation.frames.push({
					frameID: Std.parseInt(frame.att.name.substr(frame.att.name.length - 4, frame.att.name.length)),
					sourcePos: new Vector2(Std.parseFloat(frame.att.x), Std.parseFloat(frame.att.y)),
					offset: new Vector2(trimmed ? -Std.parseFloat(frame.att.frameX) : 0, trimmed ? -Std.parseFloat(frame.att.frameY) : 0),
					size: new Vector2(Std.parseFloat(frame.att.width), Std.parseFloat(frame.att.height))
				});
			}
			for (anim in frames.animations)
				anim.frames.sort((a1, a2) -> SortUtil.byValues(SortUtil.ASCENDING, a1.frameID, a2.frameID));

			Assets._cache.set(key, frames);
		}
		return cast Assets._cache.get(key);
	}

	/**
	 * Frees the animations from memory immediately.
	 */
	override function free() {
		super.free();
		for (key => asset in Assets._cache) {
			if (asset == this) {
				Assets._cache.remove(key);
				break;
			}
		}
		texture.unreference();
		for (anim in animations) {
			anim.offset = null;
			for (frame in anim.frames) {
				frame.sourcePos = null;
				frame.offset = null;
				frame.size = null;
			}
		}
	}
}

@:structInit
class SpriteAnimation {
	public var fps:Int;
	public var loop:Bool;
	public var frames:Array<SpriteFrame>;
	public var offset:Vector2;
}

@:structInit
class SpriteFrame {
	public var frameID:Int;
	public var sourcePos:Vector2;
	public var offset:Vector2;
	public var size:Vector2;
}
