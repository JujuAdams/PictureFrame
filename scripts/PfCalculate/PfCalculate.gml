// Feather disable all

/// Calculates and returns a PictureFrame "layout struct" based on an input configuration struct
/// (please see `PfConfigGeneral()` for more information). The layout struct returned by
/// `PfCalculate()` contains many variables that define the size and position of various parts of
/// the render pipeline.
/// 
/// This function is provided for people who don't want to use `PfApply()` and instead want to
/// set up their render pipeline manually. If you're looking for the easiest out-of-the-box
/// experience then you can skip this function and just use `PfApply()`.
/// 
/// The `tryResizeWindow` parameter applies when the game is already windowed or is transitioning
/// from fullscreen to a windowed state (as such, it only applies on desktop platforms). When
/// `tryResizeWindow` is set to `true`, the function will calculate the layout struct with the
/// presumption that the size of the window can change. If the `.trimBlackBars` option has been set
/// to `true` then unnecessary extra space will be removed.
/// 
/// You may use the remaining optional arguments to override the current window state. This has
/// limited uses in production but may be useful when testing.
/// 
/// N.B. Because `PfCalculate()` does a lot of maths and returns a fresh struct every time it is
///      called, you should avoid calling this function more often than is necessary.
/// 
/// @param configStruct
/// @param [tryResizeWindow=false]
/// @param [isFullscreen]
/// @param [currentWindowWidth]
/// @param [currentWindowHeight]
/// @param [displayWidth]
/// @param [displayHeight]
/// 
/// 
/// 
/// Variables contained in the returned layout struct are as follows:
/// 
/// .cameraWisth
/// .cameraHeight
///     The roomspace width and height of the camera. This includes overscan pixels, if defined.
/// 
/// .cameraOverscan
///     The number of extra pixels, in roomspace, to add around the edges of the camera. This is
///     the same literal value as in the configuration struct and is included for convenience.
/// 
/// .viewWidth
/// .viewHeight
///     The width and height of the view used to draw the camera to the application surface. This
///     includes overscan pixels, if defined. When using `PfApply()`, the application surface size
///     will match the view width and height.
/// 
/// .viewScale
///     The scaling factor between the camera and the view. A scaling factor of 2 means that there
///     will be 2 pixels on the view for every 1 pixel in roomspace on the camera. A view scale of
///     exactly 1 is therefore a pixel perfect view.
/// 
/// .viewOverscan
///     The number of extra pixels, in viewspace, that have been added around the edges of the
///     view. This is equal to `.cameraOverscan` multiplied by `.viewScale` and is provided for
///     convenience.
/// 
/// .fullscreen
///     Whether the game should be in fullscreen mode. This value is only relevant on desktop
///     platforms (Windows, MacOS, Linux). On other platforms, this will always be `true`.
/// 
/// .windowWidth
/// .windowHeight
///     The dimensions of the window. If the `.fullscreen` variable (see above) is `true` then
///     these values will be the same as the display's width and height.
/// 
/// .guiX
/// .guiY
///     The coordinates of the top-left corner of the GUI layer in windowspace.
/// 
/// .guiWidth
/// .guiHeight
///     The width and height of the GUI layer.
/// 
/// .surfacePixelPerfect
///     Whether the application surface should be drawn as pixel perfect where possible. This will
///     cause `PfPostDrawAppSurface()` to default to no texture filtering to preserve clean pixel
///     edges.
/// 
/// .surfacePostDrawScale
///     The scaling factor between the view and the window (backbuffer). This includes the
///     contribution from the overscan scale from the configuration struct.
/// 
/// .surfacePostDrawX
/// .surfacePostDrawY
/// .surfacePostDrawWidth
/// .surfacePostDrawHeight
///     The draw position and size for the application surface in the Post Draw event (i.e. the
///     coordinates in the window/backbuffer). These values are in "window space' and will not
///     necessarily line up with roomspace coorfinates.
/// 
/// .surfaceGuiX
/// .surfaceGuiY
/// .surfaceGuiWidth
/// .surfaceGuiHeight
///     The draw position and size for the application surface on the GUI layer. These values are
///     in "GUI-space' and will not necessarily line up with roomspace coorfinates.
/// 
/// .marginsVisible
///     Whether any of the margins are visible. You should check this variable before drawing the
///     margins (using the variables below).
/// 
/// .marginWestX1
/// .marginWestX2
/// .marginEastX1
/// .marginEastX2
/// .marginNorthY1
/// .marginNorthY2
/// .marginSouthY1
/// .marginSouthY2
///     Coordinates for the margins around the application surface. The coordinates are in
///     GUI-space.

function PfCalculate(_configurationStruct, _tryResizeWindow = false, _currentFullscreen = window_get_fullscreen(), _currentWindowWidth = window_get_width(), _currentWindowHeight = window_get_height(), _currentDisplayWidth = display_get_width(), _currentDisplayHeight = display_get_height())
{
    with(_configurationStruct)
    {
        var _fullscreen = PICTURE_FRAME_ON_DESKTOP? fullscreen : true;
        
        //If we're in fullscreen mode then use the whole display as the max window size
        if (_fullscreen)
        {
            var _windowWidth  = _currentDisplayWidth;
            var _windowHeight = _currentDisplayHeight;
            
            //Can never resize the window if we're going into fullscreen
            _tryResizeWindow = false;
        }
        else
        {
            //If we're transitioning from fullscreen to windows then we necessarily need to resize
            //the window.
            if (_currentFullscreen)
            {
                _tryResizeWindow = true;
            }
            
            if (_tryResizeWindow)
            {
                var _windowWidth  = windowWidth;
                var _windowHeight = windowHeight;
            }
            else
            {
                var _windowWidth  = _currentWindowWidth;
                var _windowHeight = _currentWindowHeight;
            }
        }
        
        ///////
        // Camera
        ///////
        
        var _cameraMinWidth  = (cameraMinWidth  > 0)? cameraMinWidth  : cameraTargetWidth;
        var _cameraMinHeight = (cameraMinHeight > 0)? cameraMinHeight : cameraTargetHeight;
        var _cameraMaxWidth  = (cameraMaxWidth  > 0)? cameraMaxWidth  : cameraTargetWidth;
        var _cameraMaxHeight = (cameraMaxHeight > 0)? cameraMaxHeight : cameraTargetHeight;
        
        //Figure out the scaling factor that fits us inside the target bounds
        //If we've using a pixel-perfect view then floor the scale to ensure that the view is a whole multiple of the target width/height
        var _targetScale = min(_windowWidth/cameraTargetWidth, _windowHeight/cameraTargetHeight);
        if (viewPixelPerfect) _targetScale = floor(_targetScale);
        var _outCameraWidth  = _windowWidth/_targetScale;
        var _outCameraHeight = _windowHeight/_targetScale;
        
        //Figure out the scaling factor that fits us outside the minimum bounds, if needed
        //If the scaling factor is less than or equal to 1 then the camera already fits outside the minimum bounds and no scaling is needed
        //We apply the same scaling factor in both axes to try to keep the aspect ratio consistent
        var _minScale = max(1, _cameraMinWidth/_outCameraWidth, _cameraMinHeight/_outCameraHeight);
        _outCameraWidth  = max(_minScale*_outCameraWidth,  _cameraMinWidth);
        _outCameraHeight = max(_minScale*_outCameraHeight, _cameraMinHeight);
        
        //Work out how much extra space we have and add that to the camera
        _outCameraWidth  += max(0, (_windowWidth  / _targetScale) - _outCameraWidth);
        _outCameraHeight += max(0, (_windowHeight / _targetScale) - _outCameraHeight);
        
        //Apply max size limits and round camera bounds down to the nearest whole pixel
        _outCameraWidth  = floor(min(_outCameraWidth,  _cameraMaxWidth));
        _outCameraHeight = floor(min(_outCameraHeight, _cameraMaxHeight));
        
        ///////
        // View
        ///////
        
        //Figure out the scaling factor that fits the camera inside the window
        //We limit how scaled up the view can be at the same time here too
        var _outViewScale = min(viewMaxScale, _windowWidth/_outCameraWidth, _windowHeight/_outCameraHeight);
        
        //If we're using pixel perfect scaling for our view then drop down to the nearest integer scale
        if ((_outViewScale > 1) && viewPixelPerfect)
        {
            _outViewScale = floor(_outViewScale);
        }
        
        //Scale up the view using the same aspect ratio as the camera
        //We round these values to ensure we have an integer value
        var _outViewWidth  = round(_outViewScale*_outCameraWidth);
        var _outViewHeight = round(_outViewScale*_outCameraHeight);
        
        //Calculate how much overscan we have in viewspace
        var _viewOverscan = cameraOverscan*_outViewScale;
        
        ///////
        // Window
        ///////
        
        if (_tryResizeWindow && trimBlackBars)
        {
            //If we're allowed to resize the window then we want to scale up the view dimensions
            var _windowScale = min(_windowWidth/_outViewWidth, _windowHeight/_outViewHeight);
            
            if (surfacePixelPerfect && (_windowScale > 1)) _windowScale = floor(_windowScale);
            
            var _outWindowWidth  = _windowScale*_outViewWidth;
            var _outWindowHeight = _windowScale*_outViewHeight;
        }
        else
        {
            //Otherwise use the window dimenstions as they are
            var _outWindowWidth  = _windowWidth;
            var _outWindowHeight = _windowHeight;
        }
        
        ///////
        // Application Surface Drawing
        ///////
        
        //Figure out the scaling factor that fits the application surface inside the window dimensions
        var _surfacePostDrawScale = min(_outWindowWidth/_outViewWidth, _outWindowHeight/_outViewHeight);
        
        //If we're using pixel perfect scaling then drop down to the nearest integer scale
        if (surfacePixelPerfect && (_surfacePostDrawScale > 1)) _surfacePostDrawScale = floor(_surfacePostDrawScale);
        
        //Calculate the initial windowspace size of the application surface
        var _surfacePostDrawWidth  = _surfacePostDrawScale*_outViewWidth;
        var _surfacePostDrawHeight = _surfacePostDrawScale*_outViewHeight;
        
        //Calculate the limits of the overscan box
        var _overscanWidth  = windowOverscanScale*_outWindowWidth;
        var _overscanHeight = windowOverscanScale*_outWindowHeight;
        
        //Figure out another scaling factor if the application surface exceeds the overscan limits
        var _overscanCorrectionScale = min(1, _overscanWidth/_surfacePostDrawWidth, _overscanHeight/_surfacePostDrawHeight);
        _surfacePostDrawScale *= _overscanCorrectionScale;
        
        //Apply the correction scale
        _surfacePostDrawWidth  = floor(_surfacePostDrawScale*_outViewWidth);
        _surfacePostDrawHeight = floor(_surfacePostDrawScale*_outViewHeight);
        
        //Centre the application surface in the window
        var _surfacePostDrawX = floor(0.5*(_outWindowWidth  - _surfacePostDrawWidth ));
        var _surfacePostDrawY = floor(0.5*(_outWindowHeight - _surfacePostDrawHeight));
        
        ///////
        // GUI Layer
        ///////
        
        if (guiWindowStretch)
        {
            var _outGuiX = 0;
            var _outGuiY = 0;
            
            var _guiRegionWidth  = _outWindowWidth;
            var _guiRegionHeight = _outWindowHeight;
        }
        else
        {
            var _outGuiX = _surfacePostDrawX;
            var _outGuiY = _surfacePostDrawY;
            
            var _guiRegionWidth  = _surfacePostDrawWidth;
            var _guiRegionHeight = _surfacePostDrawHeight;
        }
        
        if (guiMode == 0)
        {
            //Use the 1:1 region size
            var _outGuiWidth  = _guiRegionWidth;
            var _outGuiHeight = _guiRegionHeight;
        }
        else if (guiMode == 1)
        {
            //Use the camera size
            var _outGuiWidth  = _outCameraWidth;
            var _outGuiHeight = _outCameraHeight;
        }
        else if (guiMode == 2)
        {
            //Use the application surface / view size
            var _outGuiWidth  = _outViewWidth;
            var _outGuiHeight = _outViewHeight;
        }
        else if (guiMode == 3)
        {
            //Use the target size (which will usually stretch things)
            var _outGuiWidth  = guiTargetWidth;
            var _outGuiHeight = guiTargetHeight;
        }
        else if ((guiMode == 4) || (guiMode == 5) || (guiMode == 6))
        {
            var _stretchWidth = (guiMode == 4);
            
            if (guiMode == 6)
            {
                _stretchWidth = (abs(ln(_guiRegionWidth / guiTargetWidth)) > abs(ln(_guiRegionHeight / guiTargetHeight)));
            }
            
            if (_stretchWidth)
            {
                //GUI height is fixed and width is flexible. Scale the GUI width to be in proportion to the GUI height
                var _outGuiWidth  = round((guiTargetHeight/_guiRegionHeight)*_guiRegionWidth);
                var _outGuiHeight = guiTargetHeight;
            }
            else
            {
                //GUI width is fixed and height is flexible. Scale the GUI height to be in proportion to the GUI width
                var _outGuiWidth  = guiTargetWidth;
                var _outGuiHeight = round((guiTargetWidth/_guiRegionWidth)*_guiRegionHeight);
            }
        }
        else
        {
            __PfError($".guiMode <{guiMode}> not supported");
        }
        
        //Apply scaling
        _outGuiWidth  /= guiScale;
        _outGuiHeight /= guiScale;
        
        //Convert window coordinates to GUI coordinates
        var _windowToGuiScaleX = _outGuiWidth/_guiRegionWidth;
        var _windowToGuiScaleY = _outGuiHeight/_guiRegionHeight;
        
        var _surfaceGuiX      = _windowToGuiScaleX*(_surfacePostDrawX - _outGuiX);
        var _surfaceGuiY      = _windowToGuiScaleY*(_surfacePostDrawY - _outGuiY);
        var _surfaceGuiWidth  = _windowToGuiScaleX*_surfacePostDrawWidth;
        var _surfaceGuiHeight = _windowToGuiScaleY*_surfacePostDrawHeight;
        
        ///////
        // Final Corrections
        ///////
        
        //Increase the actual size of the camera and view/application surface after we do all maths
        _outCameraWidth  += 2*cameraOverscan;
        _outCameraHeight += 2*cameraOverscan;
        _outViewWidth    += 2*_viewOverscan;
        _outViewHeight   += 2*_viewOverscan;
        
        return {
            cameraWidth:    _outCameraWidth,
            cameraHeight:   _outCameraHeight,
            cameraOverscan: cameraOverscan,
            
            viewWidth:    _outViewWidth,
            viewHeight:   _outViewHeight,
            viewScale:    _outViewScale,
            viewOverscan: _viewOverscan,
            
            fullscreen:   _fullscreen,
            windowWidth:  _outWindowWidth,
            windowHeight: _outWindowHeight,
            
            guiX:      _outGuiX,
            guiY:      _outGuiY,
            guiWidth:  _outGuiWidth,
            guiHeight: _outGuiHeight,
            
            surfacePixelPerfect:   surfacePixelPerfect,
            surfacePostDrawScale:  _surfacePostDrawScale,
            surfacePostDrawX:      _surfacePostDrawX,
            surfacePostDrawY:      _surfacePostDrawY,
            surfacePostDrawWidth:  _surfacePostDrawWidth,
            surfacePostDrawHeight: _surfacePostDrawHeight,
            
            windowToGuiScaleX: _windowToGuiScaleX,
            windowToGuiScaleY: _windowToGuiScaleY,
            
            surfaceGuiX:      _surfaceGuiX,
            surfaceGuiY:      _surfaceGuiY,
            surfaceGuiWidth:  _surfaceGuiWidth,
            surfaceGuiHeight: _surfaceGuiHeight,
            
            marginsVisible:  ((_surfacePostDrawX > 0) || (_surfacePostDrawY > 0) || (_surfacePostDrawWidth < _outWindowWidth) || (_surfacePostDrawHeight < _outWindowHeight)),
            
            marginWestX1: _windowToGuiScaleX*(-_outGuiX),                 //Left side of the window
            marginWestX2: _surfaceGuiX,                                   //Left side of the application surface
            marginEastX1: _surfaceGuiX + _surfaceGuiWidth,                //Right side of the application surface
            marginEastX2: _windowToGuiScaleX*(_windowWidth  - _outGuiX),  //Right side of the window
            
            marginNorthY1: _windowToGuiScaleY*(-_outGuiY),                //Top of the window
            marginNorthY2: _surfaceGuiY,                                  //Top of the application surface
            marginSouthY1: _surfaceGuiY + _surfaceGuiHeight,              //Bottom of the application surface
            marginSouthY2: _windowToGuiScaleY*(_windowHeight - _outGuiY), //Bottom of the window
        }
    }
}