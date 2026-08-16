// feather ignore all

/// @return {Bool}
function GXCanvasIsMobile() {
	static _isMobile = (function() {var _map = os_get_info(); try {return _map[? "mobile"] ?? false;} finally {ds_map_destroy(_map)};})();
	return _isMobile;
}