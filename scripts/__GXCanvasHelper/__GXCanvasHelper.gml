// feather ignore all

/// @param {Function, Undefined} callback
function GXCanvasSetResolutionHandler(_callback){
	static _global = __GXCanvasGlobal();
	static _init = __GXCanvasSystem();

	if (os_type != os_operagx) return;

	_global.callback = _callback ?? __GXCanvasDefaultHandler;
}

/// @ignore
function __GXCanvasGlobal() {
	static _inst = {
		callback: __GXCanvasDefaultHandler,
	};

	return _inst;
}

/// @ignore
function __GXCanvasDefaultHandler() {
	static _isMobile = (function() {var _map = os_get_info(); try {return _map[? "mobile"];} finally {ds_map_destroy(_map)};})();
	if (GXCanvasGetCanvasHeight() == 150 && GXCanvasGetCanvasWidth() == 300) {
	  return;
	}
	
	var startingHeight = GXCanvasGetScreenHeight();
	var startingWidth = GXCanvasGetScreenWidth();
	var startingAspect = startingWidth / startingHeight;
	
	var maxWidth = GXCanvasGetWindowInnerWidth();
	var maxHeight = GXCanvasGetWindowInnerHeight();
	var newHeight, newWidth;
	
	// Find the limiting dimension.
	var heightQuotient = startingHeight / maxHeight;
	var widthQuotient = startingWidth / maxWidth;
	
	if (heightQuotient > widthQuotient) {          
	  // Max out on height.
	  newHeight = maxHeight;
	  newWidth = newHeight * startingAspect;
	} else {          
	  // Max out on width.
	  newWidth = maxWidth;
	  newHeight = newWidth / startingAspect;
	}
	
	GXCanvasSetCanvasSize(startingWidth, startingHeight);
	GXCanvasSetCanvasCSSSize(newWidth, newHeight);
}

/// @ignore
function __GXCanvasSystem() {
	static _init = (os_type == os_operagx) ? time_source_start(time_source_create(
		time_source_global,
		1,
		time_source_units_frames,
		function() {
			static _global = __GXCanvasGlobal();
			_global.callback();
		},
		[],
		-1
	)) : undefined;
}
__GXCanvasSystem();