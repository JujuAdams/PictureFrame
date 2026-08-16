// feather ignore all

/// @ignore
function __GXCanvasGlobal() {
	static _inst = {
		callback: __GXCanvasDefaultHandler,
		mobileWidth: (os_type == os_gxgames) ? GXCanvasGetScreenHeight() : 0,
		mobileHeight: (os_type == os_gxgames) ? GXCanvasGetScreenWidth() : 0,
		mobileAspect: (os_type == os_gxgames) ? GXCanvasGetScreenHeight() / GXCanvasGetScreenWidth() : 0,
		fullScale: false,
		useItchCanvas: true,
		useTs: os_type == os_gxgames,
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