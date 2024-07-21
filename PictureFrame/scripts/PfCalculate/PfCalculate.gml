// Feather disable all

/// Calculates and returns a PictureFrame "result struct" based on a configuration struct (please
/// see PfConfigGeneral() for more information). The result struct returned by PfCalculate()
/// contains many variables that define the size and position of various parts of the game window,
/// game camera, and so on.
/// 
/// N.B. Because PfCalculate() does a lot of maths and returns a fresh struct every time it is
///      called, you should avoid calling this function more often than is necessary.
/// 
/// For convenience, you can opt to use PfApply() and PfDrawAppSurface() with the generated result
/// struct to set the necessary native GameMaker values and draw the application surface
/// respectively. Please see documentation for those functions for more information.
/// 
/// @param configurationStruct
/// 
/// 
/// 
/// Variables contained in the result struct are as follows:
/// 
/// .cameraWisth
/// .cameraHeight
///     The roomspace width and height of the camera.
/// 
/// .viewWidth
/// .viewHeight
///     The width and height of the view used to draw the camera to the application surface.
/// 
/// .viewScale
///     The scaling factor between the camera and the view.
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
///     cause PfDrawAppSurface() to default to no texture filtering to preserve clean pixel edges.
/// 
/// .surfaceDrawScale
///     The scaling factor between the view and the window (backbuffer).
/// 
/// .surfaceDrawX
/// .surfaceDrawY
/// .surfaceDrawWidth
/// .surfaceDrawHeight
///     The draw position and size for the application surface on the GUI layer. These values are
///     in "GUI-space' and will not necessarily line up with roomspace coorfinates.
/// 
/// .marginLeft
/// .marginTop
/// .marginRight
/// .marginBottom
///     The size of the margins around the application surface on the GUI layers. These values are
///     in "GUI-space' and will not necessarily line up with roomspace coorfinates.



function PfCalculate(_configurationStruct)
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
        
        //Start with our result camera being the same size as the window
        var _outCameraWidth  = _windowWidth;
        var _outCameraHeight = _windowHeight;
        
        //Figure out the scaling factor that fits us inside the maximum bounds of the camera
        //If the scaling factor is greater than or equal to 1 then the camera already fits inside the maximum bounds and no scaling is needed
        var _cameraScale = min(1, cameraMaxWidth/_outCameraWidth, cameraMaxHeight/_outCameraHeight);
        
        //Shrink down the camera so that it fits inside the maximum bounds
        _outCameraWidth  *= _cameraScale;
        _outCameraHeight *= _cameraScale;
        
        //Figure out the s_cameraScalecaling factor that fits us outside the minimum bounds
        //If the scaling factor is less than or equal to 1 then the camera already fits outside the minimum bounds and no scaling is needed
        var _cameraScale = max(1, cameraMinWidth/_outCameraWidth, cameraMinHeight/_outCameraHeight);
        
        //Expand down the camera so that it fits outside the minimum bounds
        _outCameraWidth  *= _cameraScale;
        _outCameraHeight *= _cameraScale;
        
        //Round off each axis to the nearest even number of pixels
        _outCameraWidth  = 2*round(_outCameraWidth/2);
        _outCameraHeight = 2*round(_outCameraHeight/2);
        
        //Clip to the maximum bounds in case we've gone too far in one direction
        //This handles edge cases where there is no acceptible solution
        _outCameraWidth  = min(_outCameraWidth,  cameraMaxWidth );
        _outCameraHeight = min(_outCameraHeight, cameraMaxHeight);
        
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
        var _outViewWidth  = _outViewScale*_outCameraWidth;
        var _outViewHeight = _outViewScale*_outCameraHeight;
        
        // --- Window ---
        
        if (windowAllowResize && (not _fullscreen))
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
        
        // --- GUI ---
        
        if ((guiTargetWidth == undefined) && (guiTargetHeight == undefined))
        {
            //We don't have target GUI dimensions, use the window size for the GUI
            var _outGuiWidth  = _outWindowWidth;
            var _outGuiHeight = _outWindowHeight;
        }
        else if (guiTargetWidth == undefined)
        {
            //GUI height is fixed and width is flexible. Scale the GUI width to be in proportion to the GUI height
            var _outGuiWidth  = (guiTargetHeight/_outWindowHeight)*_outWindowWidth;
            var _outGuiHeight = guiTargetHeight;
        }
        else if (guiTargetHeight == undefined)
        {
            //GUI width is fixed and height is flexible. Scale the GUI height to be in proportion to the GUI width
            var _outGuiWidth  = guiTargetWidth;
            var _outGuiHeight = (guiTargetWidth/_outWindowWidth)*_outWindowHeight;
        }
        else
        {
            var _outGuiWidth  = guiTargetWidth;
            var _outGuiHeight = guiTargetHeight;
        }
        
        // --- Application Surface Drawing ---
        
        //Figure out the scaling factor that fits the application surface inside the GUI dimensions
        var _surfaceDrawScale = min(_outWindowWidth/_outViewWidth, _outWindowHeight/_outViewHeight);
        
        //If we're using pixel perfect scaling then drop down to the nearest integer scale
        if (surfacePixelPerfect && (_surfaceDrawScale > 1)) _surfaceDrawScale = floor(_surfaceDrawScale);
        
        var _surfaceGuiScaleX = _surfaceDrawScale*_outGuiWidth/_outWindowWidth;
        var _surfaceGuiScaleY = _surfaceDrawScale*_outGuiHeight/_outWindowHeight;
        
        //Centre the application surface on the GUI layer
        var _surfaceDrawWidth  = _surfaceGuiScaleX*_outViewWidth;
        var _surfaceDrawHeight = _surfaceGuiScaleY*_outViewHeight;
        var _surfaceDrawX      = 0.5*(_outGuiWidth  - _surfaceDrawWidth );
        var _surfaceDrawY      = 0.5*(_outGuiHeight - _surfaceDrawHeight);
        
        return {
            cameraWidth:  _outCameraWidth,
            cameraHeight: _outCameraHeight,
            
            viewWidth:  _outViewWidth,
            viewHeight: _outViewHeight,
            viewScale:  _outViewScale,
            
            fullscreen:   _fullscreen,
            windowWidth:  _outWindowWidth,
            windowHeight: _outWindowHeight,
            
            guiWidth:  _outGuiWidth,
            guiHeight: _outGuiHeight,
            
            surfacePixelPerfect: surfacePixelPerfect,
            surfaceDrawScale:    _surfaceDrawScale,
            surfaceDrawX:        _surfaceDrawX,
            surfaceDrawY:        _surfaceDrawY,
            surfaceDrawWidth:    _surfaceDrawWidth,
            surfaceDrawHeight:   _surfaceDrawHeight,
            
            marginLeft:   _surfaceDrawX,
            marginTop:    _surfaceDrawY,
            marginRight:  _surfaceDrawX + _surfaceDrawWidth,
            marginBottom: _surfaceDrawY + _surfaceDrawHeight,
        }
    }
}