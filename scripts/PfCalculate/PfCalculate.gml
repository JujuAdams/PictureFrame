// Feather disable all

/// Calculates and returns a PictureFrame "result struct" based on an input configuration struct
/// (please see PfConfigGeneral() for more information). The result struct returned by PfCalculate()
/// contains many variables that define the size and position of various parts of the render
/// pipeline.
/// 
/// This function is provided for people who don't want to use PfApply() and instead want to
/// set up their render pipeline manually.
/// 
/// The "resizeWindow" argument controls whether results should be calculated as though the window
/// will be resized to avoid black bars. This value is only relevant when the game is not
/// fullscreened and is therefore only relevant on desktop platforms (Windows, MacOS, Linux).
/// 
/// N.B. Because PfCalculate() does a lot of maths and returns a fresh struct every time it is
///      called, you should avoid calling this function more often than is necessary.
/// 
/// @param configStruct
/// @param [resizeWindow=false]
/// 
/// 
/// 
/// Variables contained in the returned result struct are as follows:
/// 
/// .cameraWisth
/// .cameraHeight
///     The roomspace width and height of the camera.
/// 
/// .cameraOverscan
///     The number of extra pixels, in roomspace, to add around the edges of the camera. This is
///     the same literal value as in the configuration struct and is included for convenience.
/// 
/// .viewWidth
/// .viewHeight
///     The width and height of the view used to draw the camera to the application surface.
/// 
/// .viewScale
///     The scaling factor between the camera and the view.
/// 
/// .viewOverscan
///     The number of extra pixels, in roomspace, to add around the edges of the view. This is
///     equal to .cameraOverscan multiplied by .viewScale and is provided for convenience.
/// 
/// .fullscreen
///     Whether the game should be in fullscreen mode. This value is only relevant on desktop
///     platforms (Windows, MacOS, Linux). On other platforms, this will always be <true>.
/// 
/// .windowWidth
/// .windowHeight
///     The dimensions of the window. If the .fullscreen variable (see above) is <true> then these
///     values will be the same as the display's width and height
/// 
/// .guiWidth
/// .guiHeight
///     The width and height of the GUI layer.
/// 
/// .surfacePixelPerfect
///     Whether the application surface should be drawn as pixel perfect where possible. This will
///     cause PfPostDrawAppSurface() to default to no texture filtering to preserve clean pixel
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
/// .marginGuiX1
/// .marginGuiX2
/// .marginGuiX3
/// .marginGuiX4
/// .marginGuiY1
/// .marginGuiY2
/// .marginGuiY3
/// .marginGuiY4
///     Coordinates for the margins around the application surface in GUI-space.

function PfCalculate(_configurationStruct, _resizeWindow = false)
{
    with(_configurationStruct)
    {
        var _fullscreen = ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))? fullscreen : true;
        
        //If we're in fullscreen mode then use the whole display as the max window size
        if (_fullscreen)
        {
            var _windowWidth  = display_get_width();
            var _windowHeight = display_get_height();
        }
        else
        {
            var _windowWidth  = windowWidth;
            var _windowHeight = windowHeight;
        }
        
        
        
        // --- Camera ---
        
        var _cameraMinWidth  = cameraMinWidth  ?? cameraTargetWidth;
        var _cameraMinHeight = cameraMinHeight ?? cameraTargetHeight;
        var _cameraMaxWidth  = cameraMaxWidth  ?? cameraTargetWidth;
        var _cameraMaxHeight = cameraMaxHeight ?? cameraTargetHeight;
        
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
        
        
        
        // --- View ---
        
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
        
        
        
        // --- Window ---
        
        if (_resizeWindow && (not _fullscreen))
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
        
        
        
        // --- Application Surface Drawing ---
        
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
        
        
        
        // --- GUI ---
        
        if (guiCenter)
        {
            var _outGuiWidth  = guiTargetWidth;
            var _outGuiHeight = guiTargetHeight;
            
            var _scale = _surfacePostDrawScale;
            _scale *= min(_surfacePostDrawWidth / (_scale*_outGuiWidth), _surfacePostDrawHeight / (_scale*_outGuiHeight));
            if ((_scale > 1) && guiCenterPixelPerfect)
            {
                _scale = floor(_scale);
            }
            
            var _outGuiX = floor(0.5*(_windowWidth  - _scale*_outGuiWidth));
            var _outGuiY = floor(0.5*(_windowHeight - _scale*_outGuiHeight));
            
            //Convert window coordinates to GUI coordinates
            var _windowToGuiScaleX = 1 / _scale;
            var _windowToGuiScaleY = 1 / _scale;
        }
        else
        {
            if (guiStretchOverWindow)
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
            
            if ((guiTargetWidth == undefined) && (guiTargetHeight == undefined))
            {
                //We don't have target GUI dimensions, use the window size for the GUI
                var _outGuiWidth  = _guiRegionWidth;
                var _outGuiHeight = _guiRegionHeight;
            }
            else if (guiTargetWidth == undefined)
            {
                //GUI height is fixed and width is flexible. Scale the GUI width to be in proportion to the GUI height
                var _outGuiWidth  = round((guiTargetHeight/_guiRegionHeight)*_guiRegionWidth);
                var _outGuiHeight = guiTargetHeight;
            }
            else if (guiTargetHeight == undefined)
            {
                //GUI width is fixed and height is flexible. Scale the GUI height to be in proportion to the GUI width
                var _outGuiWidth  = guiTargetWidth;
                var _outGuiHeight = round((guiTargetWidth/_guiRegionWidth)*_guiRegionHeight);
            }
            else
            {
                var _outGuiWidth  = guiTargetWidth;
                var _outGuiHeight = guiTargetHeight;
            }
            
            //Convert window coordinates to GUI coordinates
            var _windowToGuiScaleX = _outGuiWidth/_guiRegionWidth;
            var _windowToGuiScaleY = _outGuiHeight/_guiRegionHeight;
        }
        
        var _surfaceGuiX      = _windowToGuiScaleX*(_surfacePostDrawX - _outGuiX);
        var _surfaceGuiY      = _windowToGuiScaleY*(_surfacePostDrawY - _outGuiY);
        var _surfaceGuiWidth  = _windowToGuiScaleX*_surfacePostDrawWidth;
        var _surfaceGuiHeight = _windowToGuiScaleY*_surfacePostDrawHeight;
        
        
        
        // --- Final Corrections ---
        
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
            
            marginGuiX1: _windowToGuiScaleX*(-_outGuiX),
            marginGuiX2: _surfaceGuiX,
            marginGuiX3: _surfaceGuiX + _surfaceGuiWidth,
            marginGuiX4: _windowToGuiScaleX*(_windowWidth - _outGuiX),
            
            marginGuiY1: _windowToGuiScaleY*(-_outGuiY),
            marginGuiY2: _surfaceGuiY,
            marginGuiY3: _surfaceGuiY + _surfaceGuiHeight,
            marginGuiY4: _windowToGuiScaleY*(_windowHeight - _outGuiY),
        }
    }
}