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
/// .cameraIgnore
///     Whether to never set native GameMaker camera/view properties. The size of the camera will
///     still be calculated when calling `PfApply()` but those values will not be applied.
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

function PfCalculate(_configurationStruct, _tryResizeWindow = false, _currentFullscreen = window_get_fullscreen(), _currentWindowWidth = __PfWindowGetWidth(), _currentWindowHeight = __PfWindowGetHeight(), _currentDisplayWidth = display_get_width(), _currentDisplayHeight = display_get_height())
{
    with(_configurationStruct)
    {
        if (PICTUREFRAME_VERBOSE)
        {
            __PfTrace($"`PfCalculate()` called with `tryResizeWindow` = `{_tryResizeWindow? "true" : "false"}`, `currentFullscreen` = `{_currentFullscreen? "true" : "false"}`, window = {_currentWindowWidth} x {_currentWindowHeight}, display = {_currentDisplayWidth} x {_currentDisplayHeight}");
        }
        
        ///////
        // 1. Determine the inset sizes
        ///////
        
        //Get the size of the display inset for each side of the device's display. This only
        //applies to iOS and Android devices, for other platforms these will be set to 0
        var _displayMarginLeft   = __PfNotchGetLeft();
        var _displayMarginTop    = __PfNotchGetTop();
        var _displayMarginRight  = __PfNotchGetRight();
        var _displayMarginBottom = __PfNotchGetBottom();
        var _displayMarginWidth  = _displayMarginLeft + _displayMarginRight;
        var _displayMarginHeight = _displayMarginTop + _displayMarginBottom;
        
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Display margins are {_displayMarginLeft}, {_displayMarginTop}, {_displayMarginRight}, {_displayMarginBottom} (size is {_displayMarginWidth} x {_displayMarginHeight})");
        
        ///////
        // 2. Fullscreen and window size
        ///////
        
        //Do we want to be in fullscreen? If we're not on desktop then we have to be
        var _fullscreen = PICTURE_FRAME_ON_DESKTOP? fullscreen : true;
        
        //Are we going to respect the display insets? This variable is possibly unnecessary but it
        //makes later code easier to read
        var _displayHasMargins = PICTURE_FRAME_ON_MOBILE && _fullscreen;
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Desired fullscreen state is `{_fullscreen? "true" : "false"}`. \"Display has margins\" is `{_displayHasMargins? "true" : "false"}`");
        
        //If we're in fullscreen mode then use the whole display as the max window size
        if (_fullscreen)
        {
            var _windowWidth  = _currentDisplayWidth;
            var _windowHeight = _currentDisplayHeight;
            
            //Can never resize the window if we're going into fullscreen
            _tryResizeWindow = false;
            
            if (PICTUREFRAME_VERBOSE) __PfTrace($"We want to be in fullscreen so the window size is the same as the display ({_windowWidth} x {_windowHeight}) and we don't want to try to resize the window");
        }
        else
        {
            //If we're transitioning from fullscreen to windows then we necessarily need to resize
            //the window
            if (_currentFullscreen)
            {
                _tryResizeWindow = true;
                if (PICTUREFRAME_VERBOSE) __PfTrace($"We're leaving fullscreen to go to windowed mode so we need to resize the window");
            }
            
            if (_tryResizeWindow)
            {
                var _windowWidth  = windowWidth;
                var _windowHeight = windowHeight;
                
                if (PICTUREFRAME_VERBOSE) __PfTrace($"Target window size is {_windowWidth} x {_windowHeight}");
            }
            else
            {
                //If we're not going to resize the window then we have to use the current window size
                var _windowWidth  = _currentWindowWidth;
                var _windowHeight = _currentWindowHeight;
                
                if (PICTUREFRAME_VERBOSE) __PfTrace($"Current window size is {_windowWidth} x {_windowHeight}");
            }
        }
        
        ///////
        // 3. Camera size
        ///////
        
        // The camera size is constrained by the size of the application surface which in turn is
        // constrained by the size of the window. We only have one camera so we presume that the camera
        // will take up the entirety of the application surface. Additionally, we want to optimise our
        // camera size such that the application surface will take up as much room as possible i.e.
        // leave the smallest possible black bars (or none at all).
        
        if (_displayHasMargins && surfaceAvoidNotch)
        {
            //If the application surface needs to avoid the display insets then substract the total inset
            //width/height from the window
            var _surfaceRegionWidth  = _windowWidth  - _displayMarginWidth;
            var _surfaceRegionHeight = _windowHeight - _displayMarginHeight;
            
            if (PICTUREFRAME_VERBOSE) __PfTrace($"We're avoiding display cutouts so the available application surface area is {_surfaceRegionWidth} x {_surfaceRegionHeight}");
        }
        else
        {
            //Otherwise use the entire window
            var _surfaceRegionWidth  = _windowWidth;
            var _surfaceRegionHeight = _windowHeight;
            
            if (PICTUREFRAME_VERBOSE) __PfTrace($"We're not avoiding display cutouts so the available application surface area is {_surfaceRegionWidth} x {_surfaceRegionHeight}");
        }
        
        //Resolve the actual maximum camera width/height
        var _cameraMaxWidth  = (cameraMaxWidth  > 0)? cameraMaxWidth  : cameraTargetWidth;
        var _cameraMaxHeight = (cameraMaxHeight > 0)? cameraMaxHeight : cameraTargetHeight;
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Camera maximum size resolved to {_cameraMaxWidth} x {_cameraMaxHeight}");
        
        if (surfacePixelPerfect)
        {
            //Find the scaling factor that fits the target camera size inside the surface region
            var _targetScale = min(_surfaceRegionWidth/cameraTargetWidth, _surfaceRegionHeight/cameraTargetHeight);
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Camera-to-window scaling factor is {_targetScale} using \"scale down\" technique");
            
            //Force the scale down to the nearest integer (providing we're not very squished already)
            if (viewPixelPerfect && (_targetScale > 1))
            {
                _targetScale = floor(_targetScale);
                if (PICTUREFRAME_VERBOSE) __PfTrace($"Camera-to-window scaling factor rounded to {floor(_targetScale)}");
            }
            
            //Greedily eat up extra space by expanding the camera out to its maximum extents
            var _outCameraWidth  = floor(min(_surfaceRegionWidth/_targetScale,  _cameraMaxWidth));
            var _outCameraHeight = floor(min(_surfaceRegionHeight/_targetScale, _cameraMaxHeight));
            
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Camera size expanded up to the maximum and calculated as {_outCameraWidth} x {_outCameraHeight}");
        }
        else
        {
            //The surface will eventually be drawn stretched over the entire surface region. This
            //means we get better coverage by keeping the aspect ratio of the camera the same as
            //the region. To do this, we fit the surface region inside the max bounds of the camera
            var _targetScale = max(_surfaceRegionWidth/_cameraMaxWidth, _surfaceRegionHeight/_cameraMaxHeight);
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Camera-to-window scaling factor is {_targetScale} using \"similar aspect ratio\" technique");
            
            var _outCameraWidth  = floor(_surfaceRegionWidth/_targetScale);
            var _outCameraHeight = floor(_surfaceRegionHeight/_targetScale);
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Camera size calculated as {_outCameraWidth} x {_outCameraHeight}");
        }
        
        //Handle edge case where the generated camera dimensions violate the minimum width/height. This will
        //often give us a suboptimal solution but that's better than breaking the game design
        _outCameraWidth  = max(_outCameraWidth, cameraTargetWidth);
        _outCameraHeight = max(_outCameraHeight, cameraTargetHeight);
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Final camera size (after minimum size limit {cameraTargetWidth} x {cameraTargetHeight}) is {_outCameraWidth} x {_outCameraHeight}");
        
        ///////
        // 4. Viewport
        ///////
        
        // The viewport is defined as the space on the application surface where the camera is rendered
        // to. We only have one camera so the camera necessarily fills up the entire application surface.
        // However, the scaling factor to apply to the camera when it renders to the applicatiom surface
        // still needs to be calculated. You can think of this as a measure of "units to pixels" where
        // "units" is the roomspace size of the camera and "pixels" is the size of the viewport on the
        // application surface.
        
        //Figure out the scaling factor that fits the camera inside the window. We limit how scaled up the
        //view can be at the same time here too
        var _outViewScale = min(viewMaxScale, _surfaceRegionWidth/_outCameraWidth, _surfaceRegionHeight/_outCameraHeight);
        
        //If we're using pixel perfect scaling for our view then drop down to the nearest integer scale
        if (viewPixelPerfect && (_outViewScale > 1))
        {
            if (PICTUREFRAME_VERBOSE) __PfTrace($"View-to-surface scaling factor is {floor(_outViewScale)} (rounded from {_outViewScale})");
            _outViewScale = floor(_outViewScale);
        }
        else
        {
            if (PICTUREFRAME_VERBOSE) __PfTrace($"View-to-surface scaling factor is {_outViewScale}");
        }
        
        //Scale up the view using the same aspect ratio as the camera. We round these values to ensure we
        //have an integer value
        var _outViewWidth  = round(_outViewScale*_outCameraWidth);
        var _outViewHeight = round(_outViewScale*_outCameraHeight);
        
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Viewport / application surface size is {_outViewWidth} x {_outViewHeight}");
        
        //Calculate how much overscan we have in viewspace
        var _viewOverscan = cameraOverscan*_outViewScale;
        
        ///////
        // 5. Application Surface Render Size
        ///////
        
        // The application surface itself has the same size as the viewport. However, when drawing the
        // application surface in the Post Draw event, it is not necessarily the case that the surface
        // will be draw at a 1:1 scale. Instead, we need to calculate a suitable drawing size for the
        // surface such that it is as large as possible in the window whilst optionally retaining
        // pixel-perfect scaling
        
        //Figure out the scaling factor that fits the application surface inside the window dimensions
        var _surfacePostDrawScale = min(_surfaceRegionWidth/_outViewWidth, _surfaceRegionHeight/_outViewHeight);
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Application-surface-to-window scale is {_surfacePostDrawScale}");
        
        //If we're using pixel perfect scaling then drop down to the nearest integer scale
        if (surfacePixelPerfect && (_surfacePostDrawScale > 1))
        {
            _surfacePostDrawScale = floor(_surfacePostDrawScale);
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Application-surface-to-window scale rounded to {_surfacePostDrawScale}");
        }
        
        //Calculate the initial windowspace size of the application surface
        var _surfacePostDrawWidth  = _surfacePostDrawScale*_outViewWidth;
        var _surfacePostDrawHeight = _surfacePostDrawScale*_outViewHeight;
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Application surface render size is {_surfacePostDrawWidth} x {_surfacePostDrawHeight}");
        
        //Calculate the limits of the overscan box
        var _overscanWidth  = windowOverscanScale*_surfaceRegionWidth;
        var _overscanHeight = windowOverscanScale*_surfaceRegionHeight;
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Window overscan scale is {windowOverscanScale} which limits the surface region to {_overscanWidth} x {_overscanHeight}");
        
        //Figure out another scaling factor if the application surface exceeds the overscan limits
        var _overscanCorrectionScale = min(1, _overscanWidth/_surfacePostDrawWidth, _overscanHeight/_surfacePostDrawHeight);
        _surfacePostDrawScale *= _overscanCorrectionScale;
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Overscan correction scale is {_overscanCorrectionScale}, application-surface-to-window scale is now {_surfacePostDrawScale}");
        
        //Apply the correction scale
        _surfacePostDrawWidth  = floor(_surfacePostDrawScale*_outViewWidth);
        _surfacePostDrawHeight = floor(_surfacePostDrawScale*_outViewHeight);
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Final application surface render size is {_surfacePostDrawWidth} x {_surfacePostDrawHeight}");
        
        ///////
        // 6. Window
        ///////
        
        // The final window size can now be calculated if we're trying to resize it.
        
        if (_tryResizeWindow && trimBlackBars)
        {
            var _outWindowWidth  = _surfacePostDrawWidth;
            var _outWindowHeight = _surfacePostDrawHeight;
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Window trimmed to {_outWindowWidth} x {_outWindowHeight}");
        }
        else
        {
            var _outWindowWidth  = _windowWidth;
            var _outWindowHeight = _windowHeight;
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Window size is {_outWindowWidth}, {_outWindowHeight}");
        }
        
        ///////
        // 7. Application Surface Position
        ///////
        
        //Centre the application surface in the window
        var _surfacePostDrawX = floor(0.5*(_outWindowWidth - _surfacePostDrawWidth));
        var _surfacePostDrawY = floor(0.5*(_outWindowHeight - _surfacePostDrawHeight));
        
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Application surface centred in the window at ({_surfacePostDrawX}, {_surfacePostDrawY})");
        
        // Correct for the display margins. This code will try to keep the application surface in
        // the centre of the display, integrating the notch area into the black bars around the edge
        // of the surface. However, if the application surface overlaps the notch then the surface
        // will be pushed to one side or another to avoid unsightly asymmetric black bars (instead
        // there will be one big black bar where the notch is).
        if (_displayHasMargins && surfaceAvoidNotch)
        {
            if (_surfacePostDrawX < _displayMarginLeft)
            {
                //We overlap the notch on the left, force ourselves all the way to the right
                _surfacePostDrawX = _currentDisplayWidth - _displayMarginRight - _surfacePostDrawWidth;
            }
            else if (_surfacePostDrawX + _surfacePostDrawWidth > _currentDisplayWidth - _displayMarginRight)
            {
                //We overlap the notch on the right, force ourselves all the way to the left
                _surfacePostDrawX = 0;
            }
            
            if (_surfacePostDrawY < _displayMarginTop)
            {
                //We overlap the notch at the top, force ourselves all the way to the bottom
                _surfacePostDrawY = _currentDisplayHeight - _displayMarginBottom - _surfacePostDrawHeight;
            }
            else if (_surfacePostDrawY + _surfacePostDrawHeight > _currentDisplayHeight - _displayMarginBottom)
            {
                //We overlap the notch at the bottom, force ourselves all the way to the top
                _surfacePostDrawY = 0;
            }
            
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Application surface position avoided the display cutout at ({_surfacePostDrawX}, {_surfacePostDrawY})");
        }
        
        ///////
        // 8. GUI Layer
        ///////
        
        // The last major block of work is to determine the coordinate space for the GUI layer. This
        // was a lot more complex than I anticipated because there's doesn't seem to be an established
        // "correct" was of setting up the GUI layer that a clear majority of developers use.
        
        if (guiWindowStretch)
        {
            //Stretch the GUI layer over the entire window, ignoring where the application surface is
            if (_displayHasMargins && guiAvoidNotch)
            {
                //Correct for the display margins
                var _outGuiX = _displayMarginLeft;
                var _outGuiY = _displayMarginTop;
                var _guiRegionWidth  = _outWindowWidth  - _displayMarginWidth;
                var _guiRegionHeight = _outWindowHeight - _displayMarginHeight;
                if (PICTUREFRAME_VERBOSE) __PfTrace($"GUI respecting display cutout: {_guiRegionWidth} x {_guiRegionHeight} at position ({_outGuiX}, {_outGuiY})");
            }
            else
            {
                //Otherwise we should use the entire window
                var _outGuiX = 0;
                var _outGuiY = 0;
                var _guiRegionWidth  = _outWindowWidth;
                var _guiRegionHeight = _outWindowHeight;
                if (PICTUREFRAME_VERBOSE) __PfTrace($"GUI region is the entire window: {_guiRegionWidth} x {_guiRegionHeight} at position (0, 0)");
            }
        }
        else
        {
            //Stretch the GUI layer over the application surface
            if (_displayHasMargins && guiAvoidNotch)
            {
                //Try to position ourselves on the application surface but dodge the display insets
                var _outGuiX = max(_surfacePostDrawX, _displayMarginLeft);
                var _outGuiY = max(_surfacePostDrawY, _displayMarginTop);
                var _guiRegionWidth  = min(_surfacePostDrawX + _surfacePostDrawWidth,  _outWindowWidth  - _displayMarginRight ) - _outGuiX;
                var _guiRegionHeight = min(_surfacePostDrawY + _surfacePostDrawHeight, _outWindowHeight - _displayMarginBottom) - _outGuiY;
                if (PICTUREFRAME_VERBOSE) __PfTrace($"GUI trying to copy the application surface but dodging the display cutout: {_guiRegionWidth} x {_guiRegionHeight} at position ({_outGuiX}, {_outGuiY})");
            }
            else
            {
                //Otherwise use the application surface position
                var _outGuiX = _surfacePostDrawX;
                var _outGuiY = _surfacePostDrawY;
                var _guiRegionWidth  = _surfacePostDrawWidth;
                var _guiRegionHeight = _surfacePostDrawHeight;
                if (PICTUREFRAME_VERBOSE) __PfTrace($"GUI sharing the application surface region: {_guiRegionWidth} x {_guiRegionHeight} at position ({_outGuiX}, {_outGuiY})");
            }
        }
        
        if (PICTUREFRAME_VERBOSE) __PfTrace($"GUI mode is {guiMode}");
        
        if (guiMode == 0)
        {
            //Use the 1:1 region size
            var _outGuiWidth  = _guiRegionWidth;
            var _outGuiHeight = _guiRegionHeight;
            if (PICTUREFRAME_VERBOSE) __PfTrace($"GUI size is the same as the available region {_outGuiWidth} x {_outGuiHeight}");
        }
        else if (guiMode == 1)
        {
            //Use the camera size
            var _outGuiWidth  = _outCameraWidth;
            var _outGuiHeight = _outCameraHeight;
            if (PICTUREFRAME_VERBOSE) __PfTrace($"GUI size is the same as the camera {_outGuiWidth} x {_outGuiHeight}");
        }
        else if (guiMode == 2)
        {
            //Use the application surface / view size
            var _outGuiWidth  = _outViewWidth;
            var _outGuiHeight = _outViewHeight;
            if (PICTUREFRAME_VERBOSE) __PfTrace($"GUI size is the same as the view {_outGuiWidth} x {_outGuiHeight}");
        }
        else if (guiMode == 3)
        {
            //Use the target size (which will usually stretch things)
            var _outGuiWidth  = guiTargetWidth;
            var _outGuiHeight = guiTargetHeight;
            if (PICTUREFRAME_VERBOSE) __PfTrace($"GUI size is the same as the target GUI size {_outGuiWidth} x {_outGuiHeight}");
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
            
            if (PICTUREFRAME_VERBOSE)
            {
                if (guiMode == 4)
                {
                    __PfTrace($"GUI width adjusted to {_outGuiWidth} x {_outGuiHeight} (from {guiTargetWidth})");
                }
                else if (guiMode == 5)
                {
                    __PfTrace($"GUI height adjusted to {_outGuiWidth} x {_outGuiHeight} (from {guiTargetHeight})");
                }
                else if (guiMode == 6)
                {
                    if (_stretchWidth)
                    {
                        __PfTrace($"Decided to adjust GUI width to {_outGuiWidth} x {_outGuiHeight} (from {guiTargetWidth} x {guiTargetHeight})");
                    }
                    else
                    {
                        __PfTrace($"Decided to adjust GUI height to {_outGuiWidth} x {_outGuiHeight} (from {guiTargetWidth} x {guiTargetHeight})");
                    }
                }
            }
        }
        else
        {
            __PfError($".guiMode <{guiMode}> not supported");
        }
        
        //Apply scaling
        _outGuiWidth  /= guiScale;
        _outGuiHeight /= guiScale;
        if (PICTUREFRAME_VERBOSE) __PfTrace($"GUI size after scaling factor of {guiScale} is {_outGuiWidth} x {_outGuiHeight}");
        
        //Convert window coordinates to GUI coordinates
        var _windowToGuiScaleX = _outGuiWidth/_guiRegionWidth;
        var _windowToGuiScaleY = _outGuiHeight/_guiRegionHeight;
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Window-to-GUI scales are ({_windowToGuiScaleX}, {_windowToGuiScaleY})");
        
        var _surfaceGuiX      = _windowToGuiScaleX*(_surfacePostDrawX - _outGuiX);
        var _surfaceGuiY      = _windowToGuiScaleY*(_surfacePostDrawY - _outGuiY);
        var _surfaceGuiWidth  = _windowToGuiScaleX*_surfacePostDrawWidth;
        var _surfaceGuiHeight = _windowToGuiScaleY*_surfacePostDrawHeight;
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Application surface is {_surfaceGuiWidth} x {_surfaceGuiHeight} at position ({_surfaceGuiX}, {_surfaceGuiY}) on the GUI layer");
        
        ///////
        // 9. Final Overscan Corrections
        ///////
        
        //Increase the actual size of the camera and view/application surface after we do all maths
        if (PICTUREFRAME_VERBOSE) __PfTrace($"Camera overscan is {cameraOverscan}, view overscan is {_viewOverscan} (added to all edges)");
        
        _outCameraWidth  += 2*cameraOverscan;
        _outCameraHeight += 2*cameraOverscan;
        _outViewWidth    += 2*_viewOverscan;
        _outViewHeight   += 2*_viewOverscan;
        
        ///////
        // 10. Export
        ///////
        
        return {
            cameraWidth:    _outCameraWidth,
            cameraHeight:   _outCameraHeight,
            cameraOverscan: cameraOverscan,
            cameraIgnore:   cameraIgnore,
            
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
            
            marginWestX1: _windowToGuiScaleX*(-_outGuiX),                  //Left side of the window
            marginWestX2: _surfaceGuiX,                                    //Left side of the application surface
            marginEastX1: _surfaceGuiX + _surfaceGuiWidth,                 //Right side of the application surface
            marginEastX2: _windowToGuiScaleX*(_outWindowWidth - _outGuiX), //Right side of the window
            
            marginNorthY1: _windowToGuiScaleY*(-_outGuiY),                   //Top of the window
            marginNorthY2: _surfaceGuiY,                                     //Top of the application surface
            marginSouthY1: _surfaceGuiY + _surfaceGuiHeight,                 //Bottom of the application surface
            marginSouthY2: _windowToGuiScaleY*(_outWindowHeight - _outGuiY), //Bottom of the window
        }
    }
}