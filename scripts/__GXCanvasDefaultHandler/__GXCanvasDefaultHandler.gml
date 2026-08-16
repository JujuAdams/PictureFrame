/// @ignore
function __GXCanvasDefaultHandler() {
	static _isMobile = GXCanvasIsMobile();
	if (GXCanvasGetCanvasHeight() == 150 && GXCanvasGetCanvasWidth() == 300) {
	  return;
	}

	var _fullScale = GXCanvasGetFullScale(); 
	
	// Must get predetermined values if on mobile
	var startingHeight = (_isMobile && GXCanvasGetUseMobileDetection()) ? GXCanvasGetMobileHeight() : (_fullScale ? window_get_height() : GXCanvasGetScreenHeight());
	var startingWidth = (_isMobile && GXCanvasGetUseMobileDetection()) ? GXCanvasGetMobileWidth() : (_fullScale ? window_get_width() : GXCanvasGetScreenWidth());
	var startingAspect = (_isMobile && GXCanvasGetUseMobileDetection()) ? GXCanvasGetMobileAspectRatio() : startingWidth / startingHeight;
	
	var maxWidth = GXCanvasGetWindowInnerWidth();
	var maxHeight = GXCanvasGetWindowInnerHeight();
	var newHeight, newWidth;
	
	// Find the limiting dimension.
	var heightQuotient = startingHeight / maxHeight;
	var widthQuotient = startingWidth / maxWidth;
	
	if (GXCanvasIsItchIO() && GXCanvasGetUseItchIoCanvasSize()) {
		var _size = GXCanvasItchIoGetCanvasSize();
		newWidth = _size.width;
		newHeight = _size.height;
		startingWidth = _size.width;
		startingHeight = _size.height;
	} else {
		if (heightQuotient > widthQuotient) {          
		  // Max out on height.
		  newHeight = maxHeight;
		  newWidth = newHeight * startingAspect;
		} else {          
		  // Max out on width.
		  newWidth = maxWidth;
		  newHeight = newWidth / startingAspect;
		}
	}
	
	if (!_isMobile) GXCanvasSetCanvasSize(startingWidth, startingHeight);
	GXCanvasSetCanvasCSSSize(newWidth, newHeight);
}