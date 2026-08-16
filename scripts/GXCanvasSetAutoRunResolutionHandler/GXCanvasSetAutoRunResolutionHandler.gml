// feather ignore all

/// @param {Bool} auto
function GXCanvasSetAutoRunResolutionHandler(_value) {
	static _global = __GXCanvasGlobal();
	_global.useTs = _value;
	if (_value) && (time_source_get_state(_global.ts) == time_source_state_stopped) {
		time_source_start(_global.ts);
	} else {
		time_source_stop(_global.ts);
	}
}
