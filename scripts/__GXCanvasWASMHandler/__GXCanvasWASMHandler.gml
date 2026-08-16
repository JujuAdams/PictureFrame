// feather ignore all

/// @ignore
function __GXCanvasWASMHandler() {
	var _startingWidth = window_get_width();
	var _startingHeight = window_get_height();

	var _startingAspect = _startingWidth / _startingHeight;

    var maxWidth = GXCanvasGetWindowInnerWidth();
    var maxHeight = GXCanvasGetWindowInnerHeight();
    var newHeight, newWidth;
    
    // Find the limiting dimension.
    var _heightQuotient = _startingHeight / maxHeight;
    var _widthQuotient = _startingWidth / maxWidth;
    
    if (_heightQuotient > _widthQuotient) {
      newHeight = maxHeight;
      newWidth = newHeight * _startingAspect;
    } else {
      newWidth = maxWidth;
      newHeight = newWidth / _startingAspect;
    }
	GXCanvasSetCanvasCSSSize(newWidth, newHeight);
}