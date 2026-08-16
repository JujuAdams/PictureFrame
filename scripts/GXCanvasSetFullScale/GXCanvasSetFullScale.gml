// feather ignore all

/// @param {Bool} fullScale
function GXCanvasSetFullScale(_value) {
	static _global = __GXCanvasGlobal();
	_global.fullScale = _value;
}