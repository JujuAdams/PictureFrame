// feather ignore all

function GXCanvasForceCallResolutionHandler() {
	static _global = __GXCanvasGlobal();
	if (os_type != os_operagx) return;
	_global.callback();
}
