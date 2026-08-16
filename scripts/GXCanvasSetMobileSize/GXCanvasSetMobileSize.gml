// feather ignore all

/// @param {Real} width
/// @param {Real} height
function GXCanvasSetMobileSize(_width, _height) {
	static _global = __GXCanvasGlobal();
	_global.mobileWidth = _width;
	_global.mobileHeight = _height;
	_global.mobileAspect = _width / _height;
}