package vortex.core.assets;

import vortex.utils.Assets;
import vortex.utils.typelimit.OneOfTwo;

abstract XmlAsset(OneOfTwo<Xml, String>) from Xml from String {
	public function getXml() {
		if ((this is String)) {
			final str:String = cast this;
			if (Assets.exists(str))
				return fromPath(str);

			return fromXmlString(str);
		}

		return cast(this, Xml);
	}

	static inline function fromPath<T>(path:String):Xml {
		return fromXmlString(Assets.getText(path));
	}

	static inline function fromXmlString<T>(data:String):Xml {
		return Xml.parse(data);
	}
}
