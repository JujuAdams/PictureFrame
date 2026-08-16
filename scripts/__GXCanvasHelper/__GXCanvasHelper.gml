// feather ignore all

/// @param {Function, Undefined} callback
function GXCanvasSetResolutionHandler(_callback){
	static _global = __GXCanvasGlobal();
	static _init = __GXCanvasSystem();

	if (os_type != os_operagx) return;

	_global.callback = _callback ?? __GXCanvasDefaultHandler;
}

function GXCanvasForceCallResolutionHandler() {
	static _global = __GXCanvasGlobal();
	if (os_type != os_operagx) return;
	_global.callback();
}

function GXCanvasIsItchIO() {
	static __onItchIO = string_starts_with(url_get_domain(), "html-classic.itch.zone") || string_starts_with(url_get_domain(), "itch.io");
	return __onItchIO;
}

function GXCanvasSetAutoRunResolutionHandler(_value) {
	static _global = __GXCanvasGlobal();
	_global.useTs = _value;
	if (_value) && (time_source_get_state(_global.ts) == time_source_state_stopped) {
		time_source_start(_global.ts);
	} else {
		time_source_stop(_global.ts);
	}
}

function GXCanvasGetAutoRunResolutionHandler() {
	static _global = __GXCanvasGlobal();
	return _global.useTs;
}

function GXCanvasSetUseMobileDetection(_value) {
	static _global = __GXCanvasGlobal();
	_global.useMobileDetection = _value;
}

function GXCanvasGetUseMobileDetection() {
	static _global = __GXCanvasGlobal();
	return _global.useMobileDetection;
}

/// @param {Bool} fullScale
function GXCanvasSetFullScale(_value) {
	static _global = __GXCanvasGlobal();
	_global.fullScale = _value;
}

function GXCanvasGetFullScale() {
	static _global = __GXCanvasGlobal();
	return _global.fullScale;
}

/// @return {Bool}
function GXCanvasIsMobile() {
	static _isMobile = (function() {var _map = os_get_info(); try {return _map[? "mobile"] ?? false;} finally {ds_map_destroy(_map)};})();
	return _isMobile;
}

/// @ignore
function __GXCanvasGlobal() {
	static _inst = {
		callback: __GXCanvasDefaultHandler,
		mobileWidth: (os_type == os_operagx) ? GXCanvasGetScreenHeight() : 0,
		mobileHeight: (os_type == os_operagx) ? GXCanvasGetScreenWidth() : 0,
		mobileAspect: (os_type == os_operagx) ? GXCanvasGetScreenHeight() / GXCanvasGetScreenWidth() : 0,
		fullScale: false,
		useItchCanvas: true,
		useTs: true,
		useMobileDetection: true,
		ts: time_source_create(
			time_source_global,
			1,
			time_source_units_frames,
			function() {
				static _global = __GXCanvasGlobal();
				_global.callback();
			},
			[],
			-1
		),
	};

	return _inst;
}

/// @param {Real} width
/// @param {Real} height
function GXCanvasSetMobileSize(_width, _height) {
	static _global = __GXCanvasGlobal();
	_global.mobileWidth = _width;
	_global.mobileHeight = _height;
	_global.mobileAspect = _width / _height;
}

function GXCanvasGetMobileWidth() {
	static _global = __GXCanvasGlobal();
	return _global.mobileWidth;
}

function GXCanvasGetMobileHeight() {
	static _global = __GXCanvasGlobal();
	return _global.mobileHeight;
}

function GXCanvasGetMobileAspectRatio() {
	static _global = __GXCanvasGlobal();
	return _global.mobileAspect;
}

function GXCanvasSetUseItchIoCanvasSize(_value) {
	static _global = __GXCanvasGlobal();
	_global.useItchCanvas = _value;
}

function GXCanvasGetUseItchIoCanvasSize() {
	static _global = __GXCanvasGlobal();
	return _global.useItchCanvas;
}

function GXCanvasItchIoGetCanvasSize() {
	static _size = {
		width: 0,
		height: 0,
	};
	if (!GXCanvasIsItchIO()) return undefined;
	_size.width = GXCanvasGetWindowInnerWidth();
	_size.height = GXCanvasGetWindowInnerHeight();
	return _size;
}

/// @ignore
function __GXCanvasSystem() {
	static _global = __GXCanvasGlobal();
	static _init = (os_type == os_operagx) ? (_global.useTs ? time_source_start(__GXCanvasGlobal().ts) : undefined) : undefined;
}
__GXCanvasSystem();