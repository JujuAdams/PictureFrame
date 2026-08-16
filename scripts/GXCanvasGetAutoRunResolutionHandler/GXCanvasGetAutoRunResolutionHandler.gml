// feather ignore all

function GXCanvasGetAutoRunResolutionHandler() {
	static _global = __GXCanvasGlobal();
	return _global.useTs;
}