// feather ignore all

/// @ignore
function __GXCanvasDefaultHandler() {
	static _isMobile = GXCanvasIsMobile();

	var _fullScale = GXCanvasGetFullScale(); 
	
	// Must get predetermined values if on mobile
	var _startingHeight = (_isMobile && GXCanvasGetUseMobileDetection()) ? GXCanvasGetMobileHeight() : (_fullScale ? window_get_height() : GXCanvasGetScreenHeight());
	var _startingWidth = (_isMobile && GXCanvasGetUseMobileDetection()) ? GXCanvasGetMobileWidth() : (_fullScale ? window_get_width() : GXCanvasGetScreenWidth());
	var _startingAspect = (_isMobile && GXCanvasGetUseMobileDetection()) ? GXCanvasGetMobileAspectRatio() : _startingWidth / _startingHeight;
	
	var _maxWidth = GXCanvasGetWindowInnerWidth();
	var _maxHeight = GXCanvasGetWindowInnerHeight();
	var _newHeight, _newWidth;
	
	// Find the limiting dimension.
	var _heightQuotient = _startingHeight / _maxHeight;
	var _widthQuotient = _startingWidth / _maxWidth;
	
	if (GXCanvasIsItchIo() && (GXCanvasGetUseItchIoCanvasSize())) {
		var _size = GXCanvasItchIoGetCanvasSize();
		_newWidth = _size.width;
		_newHeight = _size.height;
		_startingWidth = _size.width;
		_startingHeight = _size.height;
	} else {
		if (_heightQuotient > _widthQuotient) {          
		  _newHeight = _maxHeight;
		  _newWidth = _newHeight * _startingAspect;
		} else {          
		  _newWidth = _maxWidth;
		  _newHeight = _newWidth / _startingAspect;
		}
	}
	
	if (!_isMobile) GXCanvasSetCanvasSize(_startingWidth, _startingHeight);
	GXCanvasSetCanvasCSSSize(_newWidth, _newHeight);
}