// feather ignore all

/// @ignore
function __GXCanvasSystem() {
	static _global = __GXCanvasGlobal();
	static _init = (os_type == os_gxgames) ? (_global.useTs ? time_source_start(__GXCanvasGlobal().ts) : undefined) : undefined;
}
__GXCanvasSystem();