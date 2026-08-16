/// @param {Function, Undefined} callback
function GXCanvasSetResolutionHandler(_callback){
	static _global = __GXCanvasGlobal();
	static _init = __GXCanvasSystem();

	if (os_type != os_gxgames) return;

	_global.callback = _callback ?? __GXCanvasDefaultHandler;
}