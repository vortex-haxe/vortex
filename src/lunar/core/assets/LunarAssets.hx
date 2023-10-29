package lunar.core.assets;

import lunar.utils.typelimit.OneOfTwo;

typedef GraphicAsset = OneOfTwo<Graphic, String>;
typedef XMLAsset = OneOfTwo<Xml, String>;