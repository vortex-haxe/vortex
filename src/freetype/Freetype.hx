package freetype;

import cpp.Star;
import cpp.ConstStar;
import cpp.ConstCharStar;
import cpp.Pointer;
import cpp.RawPointer;

typedef FTErr = Int;

@:include("freetype/fttypes.h")
@:native("FT_Generic")
extern class FreetypeGeneric {}

@:include("freetype/freetype.h")
@:native("FT_LibraryRec_")
extern class FreetypeLibRec {}

typedef FreetypeLib = RawPointer<FreetypeLibRec>;

@:include("freetype/ftimage.h")
@:native("FT_Vector")
@:structAccess
extern class FreetypeVector {
    @:native("x")
    var x:cpp.UInt64;
    @:native("y")
    var y:cpp.UInt64;
}

@:include("freetype/fttypes.h")
@:native("FT_Matrix")
extern class FreetypeMatrix {
    @:native("xx")
    var xx:cpp.UInt64;
    @:native("xy")
    var xy:cpp.UInt64;
    @:native("yx")
    var yx:cpp.UInt64;
    @:native("yy")
    var yy:cpp.UInt64;
}

@:include("freetype/ftimage.h")
@:native("FT_BBox")
extern class FreetypeBBox {
    @:native("xMin")
    var xMin:cpp.UInt64;
    @:native("yMin")
    var yMin:cpp.UInt64;
    @:native("xMax")
    var xMax:cpp.UInt64;
    @:native("yMax")
    var yMax:cpp.UInt64;
}

@:include("freetype/ftimage.h")
@:native("FT_Bitmap")
@:structAccess
extern class FreetypeBitmap {
    @:native("rows")
    var rows:cpp.UInt32;
    @:native("width")
    var width:cpp.UInt32;
    @:native("pitch")
    var pitch:Int;
    @:native("buffer")
    var buffer:RawPointer<cpp.UInt8>;
    @:native("num_grays")
    var numGrays:cpp.UInt16;
    @:native("pixel_mode")
    var pixelMode:cpp.UInt8;
    @:native("palette_mode")
    var paletteMode:cpp.UInt8;
    @:native("palette")
    var palette:RawPointer<cpp.Void>;
}

@:include("freetype/freetype.h")
@:native("FT_Bitmap_Size")
extern class FreetypeBitmapSize {
    @:native("width")
    var width:cpp.Int16;
    @:native("height")
    var height:cpp.Int16;

    @:native("size")
    var size:cpp.UInt64;

    @:native("x_ppem")
    var xPpem:cpp.UInt64;
    @:native("y_ppem")
    var yPpem:cpp.UInt64;
}

@:include("freetype/freetype.h")
@:native("FT_Size_Metrics")
extern class FreetypeSizeMetrics {
    @:native("x_ppem")
    var xPpem:cpp.UInt16;
    @:native("y_ppem")
    var yPpem:cpp.UInt16;

    @:native("x_scale")
    var xScale:cpp.UInt64;
    @:native("y_scale")
    var yScale:cpp.UInt64;

    @:native("ascender")
    var ascender:cpp.Int64;
    @:native("descender")
    var descender:cpp.Int64;
    @:native("height")
    var height:cpp.Int64;
    @:native("max_advance")
    var maxAdvance:cpp.Int64;
}

@:include("freetype/fttypes.h")
@:native("FT_Size_Internal")
extern class FreetypeSizeInternal {}

@:include("freetype/freetype.h")
@:native("FT_Size")
extern class FreetypeSize {
    @:native("face")
    var face:FreetypeFace;
    @:native("generic")
    var generic:FreetypeGeneric;
    @:native("metrics")
    var metrics:FreetypeSizeMetrics;
    @:native("internal")
    var internal:FreetypeSizeInternal;
}

@:include("freetype/freetype.h")
@:native("FT_FaceRec_")
@:structAccess
extern class FreetypeFaceRec {
    @:native("num_faces")
    var numFaces:cpp.Int64;
    @:native("face_index")
    var faceIndex:cpp.Int64;

    @:native("face_flags")
    var faceFlags:cpp.Int64;
    @:native("style_flags")
    var styleFlags:cpp.Int64;

    @:native("num_glyphs")
    var numGlyphs:cpp.Int64;

    @:native("family_name")
    var familyName:RawPointer<cpp.Char>;
    @:native("style_name")
    var styleName:RawPointer<cpp.Char>;

    @:native("num_fixed_sizes")
    var numFixedSizes:Int;
    @:native("available_sizes")
    var availableAizes:RawPointer<FreetypeBitmapSize>;

    @:native("num_charmaps")
    var numCharmaps:Int;
    @:native("charmaps")
    var charmaps:RawPointer<FreetypeCharMap>;

    @:native("generic")
    var generic:FreetypeGeneric;

    @:native("bbox")
    var bbox:FreetypeBBox;

    @:native("units_per_EM")
    var unitsPerEM:cpp.UInt16;
    @:native("ascender")
    var ascender:cpp.Int16;
    @:native("descender")
    var descender:cpp.Int16;
    @:native("height")
    var height:cpp.Int16;

    @:native("max_advance_width")
    var maxAdvanceWidth:cpp.Int16;
    @:native("max_advance_height")
    var maxAdvanceHeight:cpp.Int16;

    @:native("underline_position")
    var underlinePosition:cpp.Int16;
    @:native("underline_thickness")
    var underlineThickness:cpp.Int16;

    @:native("glyph")
    var glyph:FreetypeGlyphSlot;
    @:native("size")
    var size:FreetypeSize;
    @:native("charmap")
    var charmap:FreetypeCharMap;
}

typedef FreetypeFace = RawPointer<FreetypeFaceRec>;

@:include("freetype/freetype.h")
@:native("FT_Glyph_Metrics")
extern class FreetypeGlyphMetrics {
    @:native("width")
    var width:cpp.UInt64;
    @:native("height")
    var height:cpp.UInt64;

    @:native("horiBearingX")
    var horiBearingX:cpp.UInt64;
    @:native("horiBearingY")
    var horiBearingY:cpp.UInt64;
    @:native("horiAdvance")
    var horiAdvance:cpp.UInt64;

    @:native("vertBearingX")
    var vertBearingX:cpp.UInt64;
    @:native("vertBearingY")
    var vertBearingY:cpp.UInt64;
    @:native("vertAdvance")
    var vertAdvance:cpp.UInt64;
}

@:include("freetype/ftimage.h")
@:native("FT_Glyph_Format")
extern enum abstract FreetypeGlyphFormat(cpp.UInt32) {
    @:native("FT_GLYPH_FORMAT_NONE")
    var NONE;
    @:native("FT_GLYPH_FORMAT_COMPOSITE")
    var COMPOSITE;
    @:native("FT_GLYPH_FORMAT_BITMAP")
    var BITMAP;
    @:native("FT_GLYPH_FORMAT_OUTLINE")
    var OUTLINE;
    @:native("FT_GLYPH_FORMAT_PLOTTER")
    var PLOTTER;
    @:native("FT_GLYPH_FORMAT_SVG")
    var SVG;
}

@:include("freetype/ftimage.h")
@:native("FT_Outline")
extern class FreetypeOutline {
    @:native("n_contours")
    var numContours:cpp.Int16;
    @:native("n_points")
    var numPoints:cpp.Int16;

    @:native("points")
    var points:RawPointer<FreetypeVector>;
    @:native("tags")
    var tags:cpp.CastCharStar;
    @:native("contours")
    var contours:RawPointer<cpp.Int16>;

    @:native("flags")
    var flags:Int;
}

@:include("freetype/freetype.h")
@:native("FT_SubGlyph")
extern class FreetypeSubGlyph {}

@:include("freetype/freetype.h")
@:native("FT_Slot_Internal")
extern class FreetypeSlotInternal {}

@:include("freetype/freetype.h")
@:native("FT_GlyphSlot")
extern class FreetypeGlyphSlot {
    @:native("library")
    var library:FreetypeLib;
    @:native("face")
    var face:FreetypeFace;
    @:native("next")
    var next:FreetypeGlyphSlot;
    @:native("glyph_index")
    var glyphIndex:cpp.UInt32;
    @:native("generic")
    var generic:FreetypeGeneric;

    @:native("metrics")
    var metrics:FreetypeGlyphMetrics;
    @:native("linearHoriAdvance")
    var linearHoriAdvance:cpp.UInt64;
    @:native("linearVertAdvance")
    var linearVertAdvance:cpp.UInt64;
    @:native("advance")
    var advance:FreetypeVector;

    @:native("format")
    var format:FreetypeGlyphFormat;

    @:native("bitmap")
    var bitmap:FreetypeBitmap;
    @:native("bitmap_left")
    var bitmapLeft:Int;
    @:native("bitmap_top")
    var bitmapTop:Int;

    @:native("outline")
    var outline:FreetypeOutline;

    @:native("num_subglyphs")
    var numSubglyphs:cpp.UInt32;
    @:native("subglyphs")
    var subglyphs:FreetypeSubGlyph;

    @:native("control_data")
    var controlData:RawPointer<cpp.Void>;
    @:native("control_len")
    var controlLength:cpp.Int64;

    @:native("lsb_delta")
    var lsbDelta:cpp.Int64;
    @:native("rsb_delta")
    var rsbDelta:cpp.Int64;

    @:native("other")
    var other:RawPointer<cpp.Void>;

    @:native("internal")
    var internal:FreetypeSlotInternal;
}

@:include("freetype/freetype.h")
@:native("FT_Size_Request_Type")
extern enum abstract SizeRequestType(cpp.UInt32) {
    @:native("FT_SIZE_REQUEST_TYPE_NOMINAL")
    var NOMINAL;
    @:native("FT_SIZE_REQUEST_TYPE_REAL_DIM")
    var REAL_DIM;
    @:native("FT_SIZE_REQUEST_TYPE_BBOX")
    var BBOX;
    @:native("FT_SIZE_REQUEST_TYPE_CELL")
    var CELL;
    @:native("FT_SIZE_REQUEST_TYPE_SCALES")
    var SCALES;
    @:native("FT_SIZE_REQUEST_TYPE_MAX")
    var MAX;
}

@:include("freetype/freetype.h")
@:native("FT_Size_Request")
extern class FreetypeSizeRequest {
    @:native("type")
    var type:SizeRequestType;
    @:native("width")
    var width:cpp.Int64;
    @:native("height")
    var height:cpp.Int64;
    @:native("horiResolution")
    var horiResolution:cpp.UInt32;
    @:native("vertResolution")
    var vertResolution:cpp.UInt32;
}

@:include("freetype/freetype.h")
@:native("FT_Render_Mode")
extern enum abstract FreetypeRenderMode(cpp.UInt32) to cpp.UInt32 {
    @:native("FT_RENDER_MODE_NORMAL")
    var NORMAL;
    @:native("FT_RENDER_MODE_LIGHT")
    var LIGHT;
    @:native("FT_RENDER_MODE_MONO")
    var MONO;
    @:native("FT_RENDER_MODE_LCD")
    var LCD;
    @:native("FT_RENDER_MODE_LCD_V")
    var LCD_V;
    @:native("FT_RENDER_MODE_SDF")
    var SDF;
    @:native("FT_RENDER_MODE_MAX")
    var MAX;
}

@:include("freetype/freetype.h")
@:native("FT_CharMap")
extern class FreetypeCharMap {
    @:native("face")
    var face:FreetypeFace;
    // @:native("encoding")
    // var encoding:FreetypeEncoding;
    @:native("platformID")
    var platformID:cpp.UInt16;
    @:native("encodingID")
    var encodingID:cpp.UInt16;
}

@:include("freetype/freetype.h")
@:native("FT_Parameter")
extern class FreetypeParameter {
    @:native("tag")
    var tag:cpp.UInt64;
    @:native("data")
    var data:Any;
}

@:include("freetype/freetype.h")
@:buildXml("<include name='${haxelib:vortex}/include.xml'/>")
extern class Freetype {
	@:native("FT_LOAD_DEFAULT")
	static final LOAD_DEFAULT:cpp.UInt32;
	@:native("FT_LOAD_NO_SCALE")
	static final LOAD_NO_SCALE:cpp.UInt32;
	@:native("FT_LOAD_NO_HINTING")
	static final LOAD_NO_HINTING:cpp.UInt32;
	@:native("FT_LOAD_RENDER")
	static final LOAD_RENDER:cpp.UInt32;
	@:native("FT_LOAD_NO_BITMAP")
	static final LOAD_NO_BITMAP:cpp.UInt32;
	@:native("FT_LOAD_VERTICAL_LAYOUT")
	static final LOAD_VERTICAL_LAYOUT:cpp.UInt32;
	@:native("FT_LOAD_FORCE_AUTOHINT")
	static final LOAD_FORCE_AUTOHINT:cpp.UInt32;
	@:native("FT_LOAD_CROP_BITMAP")
	static final LOAD_CROP_BITMAP:cpp.UInt32;
	@:native("FT_LOAD_PEDANTIC")
	static final LOAD_PEDANTIC:cpp.UInt32;
	@:native("FT_LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH")
	static final LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH:cpp.UInt32;
	@:native("FT_LOAD_NO_RECURSE")
	static final LOAD_NO_RECURSE:cpp.UInt32;
	@:native("FT_LOAD_IGNORE_TRANSFORM")
	static final LOAD_IGNORE_TRANSFORM:cpp.UInt32;
	@:native("FT_LOAD_MONOCHROME")
	static final LOAD_MONOCHROME:cpp.UInt32;
	@:native("FT_LOAD_LINEAR_DESIGN")
	static final LOAD_LINEAR_DESIGN:cpp.UInt32;
	@:native("FT_LOAD_SBITS_ONLY")
	static final LOAD_SBITS_ONLY:cpp.UInt32;
	@:native("FT_LOAD_NO_AUTOHINT")
	static final LOAD_NO_AUTOHINT:cpp.UInt32;
	@:native("FT_LOAD_COLOR")
	static final LOAD_COLOR:cpp.UInt32;
	@:native("FT_LOAD_COMPUTE_METRICS")
	static final LOAD_COMPUTE_METRICS:cpp.UInt32;
	@:native("FT_LOAD_BITMAP_METRICS_ONLY")
	static final LOAD_BITMAP_METRICS_ONLY:cpp.UInt32;

    @:native("FT_LOAD_TARGET_")
    static function LOAD_TARGET(x:cpp.UInt32):cpp.UInt32;

    @:native("FT_Init_FreeType")
    static function init(lib:RawPointer<FreetypeLib>):FTErr;

    @:native("FT_Done_FreeType")
    static function done(lib:FreetypeLib):FTErr;

    @:native("FT_New_Face")
    static function newFace(lib:FreetypeLib, filePath:ConstCharStar, index:cpp.Int32, facePtr:RawPointer<FreetypeFace>):FTErr;

    @:native("FT_New_Memory_Face")
    static function newMemoryFace(lib:FreetypeLib, bytes:ConstStar<cpp.Int8>, size:cpp.Int32, index:cpp.Int32, facePtr:RawPointer<FreetypeFace>):FTErr;

    // TODO: FT_Open_Face, FT_Attach_Stream & FT_Open_Args

    @:native("FT_Attach_File")
    static function attachFile(face:FreetypeFace, filePath:ConstCharStar):FTErr;

    @:native("FT_Reference_Face")
    static function referenceFace(face:FreetypeFace):FTErr;

    @:native("FT_Done_Face")
    static function doneFace(face:FreetypeFace):FTErr;

    @:native("FT_Select_Size")
    static function selectSize(face:FreetypeFace, strikeIndex:Int):FTErr;

    @:native("FT_Request_Size")
    static function requestSize(face:FreetypeFace, request:FreetypeSizeRequest):FTErr;

    @:native("FT_Set_Char_Size")
    static function setCharSize(face:FreetypeFace, width:cpp.Int64, height:cpp.Int64, horiRes:cpp.UInt32, vertRes:cpp.UInt32):FTErr;

    @:native("FT_Set_Pixel_Sizes")
    static function setPixelSizes(face:FreetypeFace, pixelWidth:cpp.UInt32, pixelHeight:cpp.UInt32):FTErr;

    @:native("FT_Load_Glyph")
    static function loadGlyph(face:FreetypeFace, glyphIndex:cpp.UInt32, loadFlags:cpp.UInt32):FTErr;

    @:native("FT_Load_Char")
    static function loadChar(face:FreetypeFace, charCode:cpp.UInt64, loadFlags:cpp.UInt32):FTErr;

    @:native("FT_Set_Transform")
    static function setTransform(face:FreetypeFace, matrix:RawPointer<FreetypeMatrix>, delta:RawPointer<FreetypeVector>):Void;

    @:native("FT_Get_Transform")
    static function getTransform(face:FreetypeFace, matrix:RawPointer<FreetypeMatrix>, delta:RawPointer<FreetypeVector>):Void;

    @:native("FT_Render_Glyph")
    static function renderGlpyh(slot:FreetypeGlyphSlot, renderMode:FreetypeRenderMode):FTErr;

    @:native("FT_Get_Kerning")
    static function getKerning(face:FreetypeFace, leftGlyph:cpp.UInt32, rightGlyph:cpp.UInt32, kernMode:cpp.UInt32, kerning:RawPointer<FreetypeVector>):FTErr;

    @:native("FT_Get_Track_Kerning")
    static function getTrackKerning(face:FreetypeFace, pointSize:cpp.Int64, degree:Int, kerning:RawPointer<cpp.Int64>):FTErr;

    // TODO: FT_Select_Charmap  & FT_Encoding

    @:native("FT_Set_Charmap")
    static function setCharmap(face:FreetypeFace, charMap:FreetypeCharMap):FTErr;

    @:native("FT_Get_Charmap_Index")
    static function getCharmapIndex(charMap:FreetypeCharMap):Int;

    @:native("FT_Get_Char_Index")
    static function getCharIndex(face:FreetypeFace, charCode:cpp.UInt64):cpp.UInt32;

    @:native("FT_Get_First_Char")
    static function getFirstChar(face:FreetypeFace, agIndex:RawPointer<cpp.UInt32>):cpp.UInt64;

    @:native("FT_Get_Next_Char")
    static function getNextChar(face:FreetypeFace, charCode:cpp.UInt64, agIndex:RawPointer<cpp.UInt32>):cpp.UInt64;

    @:native("FT_Face_Properties")
    static function faceProperties(face:FreetypeFace, numProperties:cpp.UInt32, properties:RawPointer<FreetypeParameter>):FTErr;

    @:native("FT_Get_Name_Index")
    static function getNameIndex(face:FreetypeFace, glyphName:cpp.ConstCharStar):cpp.Int32;

    inline static function getGlyphName(face:FreetypeFace, glyphIndex:cpp.UInt32, buffer:Any, bufferMax:cpp.UInt32):FTErr {
        return untyped __cpp__("FT_Get_Glyph_Name({0}, {1}, {2}, {3})", face, glyphIndex, buffer, bufferMax);
    }

    @:native("FT_Get_Postscript_Name")
    static function getPostscriptName(face:FreetypeFace):cpp.ConstCharStar;

    @:native("FT_Get_SubGlyph_Info")
    static function getSubglyphInfo(glyph:FreetypeGlyphSlot, subIndex:cpp.UInt32, pIndex:RawPointer<Int>, pFlags:RawPointer<cpp.UInt32>, pArg1:RawPointer<Int>, pArg2:RawPointer<Int>, pTransform:RawPointer<FreetypeMatrix>):FTErr;

    @:native("FT_Get_FSType_Flags")
    static function getFSTypeFlags(face:FreetypeFace):cpp.UInt16;

    @:native("FT_Face_GetCharVariantIndex")
    static function faceGetCharVariantIndex(face:FreetypeFace, charCode:cpp.UInt64, variantSelector:cpp.UInt64):cpp.UInt32;

    @:native("FT_Face_GetCharVariantIsDefault")
    static function faceGetCharVariantIsDefault(face:FreetypeFace, charCode:cpp.UInt64, variantSelector:cpp.UInt64):Int;

    @:native("FT_Face_GetVariantSelectors")
    static function faceGetVariantSelectors(face:FreetypeFace):RawPointer<cpp.Int32>;

    @:native("FT_Face_GetVariantsOfChar")
    static function faceGetVariantsOfChar(face:FreetypeFace, charCode:cpp.UInt64):RawPointer<cpp.UInt32>;

    @:native("FT_Face_GetCharsOfVariant")
    static function faceGetCharsOfVariant(face:FreetypeFace, variantSelector:cpp.UInt64):RawPointer<cpp.UInt32>;

    @:native("FT_Library_Version")
    static function libraryVersion(lib:FreetypeLib, major:RawPointer<Int>, minor:RawPointer<Int>, patch:RawPointer<Int>):Void;

    @:native("FT_Face_CheckTrueTypePatents")
    static function faceCheckTrueTypePatents(face:FreetypeFace):cpp.UInt8;

    @:native("FT_Face_SetUnpatentedHinting")
    static function faceSetUnpatentedHinting(face:FreetypeFace, value:cpp.UInt8):cpp.UInt8;

    @:native("FT_Error_String")
    static function errorString(code:FTErr):ConstCharStar;
}