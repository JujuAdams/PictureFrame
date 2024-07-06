/// PictureFrame 1.1.0  2024-07-06
/// Juju Adams
/// 
/// Camera, view, GUI, window, and application surface dimension calculator. Simplifies the
/// finnicky mathematics of handling reactive scaling for 2D games. Supports safe regions for
/// cameras and pixel perfect scaling.
/// 
/// 
/// .Apply()
///   Applies variables from the PictureFrame instance to the camera and view if active, and to the
///   GUI layer, application surface, and window. You don't have to call this method but it very
///   convenient. The exact size of each stage in rendering are determined by PictureFrame using
///   the parameters set by other methods.
/// 
/// .DrawApplicationSurface([texFilter], [blendEnable=false])
///   Manually draws the application surface. This should typically be called in the Post-Draw or
///   Begin Draw event. The position and scale of the application surface are calculated by
///   PictureFrame using the parameters set by other methods.
/// 
/// .GetDebugString()
///   Returns a string that contains all the output variables calculated by PictureFrame.
/// 
/// 
/// .SetCameraParams(minWidth, minHeight, maxWidth, maxHeight)
///   Sets minimum and maximum dimensions (in room-space) for your game's camera. A PictureFrame
///   will try to maximise the size of the camera within these bounds whilst keeping the same
///   aspect ratio as the window (or display when in fullscreen mode).
/// 
/// .GetCameraParams()
///   Returns a struct containing the parameters set above.
/// 
/// 
/// .SetViewParams(maxScale, pixelPerfect)
///   Sets the maximum scale used to calculate the view size from the camera size. Set this value
///   to 1 for pixel art games that don't want to use subpixels. The "pixelPerfect" argument when
///   set to <true> will tell the PictureFrame to use an integer scales.
/// 
/// .GetViewMaxScale()
///   Returns a struct containing the parameters set above.
/// 
/// 
/// .SetWindowParams(width, height, [allowResize=false])
///   Sets the size of the window for PictureFrame. These parameters are ignored when in fullscreen
///   mode (see below). The optional argument "allowResize" should be set to <true> if you allow
///   the player to resize the window freely.
/// 
/// .GetWindowParams()
///   Returns a struct containing the parameters set above.
/// 
/// 
/// .SetFullscreen(state)
///   Sets whether the PictureFrame should operate in fullscreen mode.
/// 
/// .GetFullscreen()
///   Returns whether the scoped PictureFrame is set up for fullscreen.
/// 
/// 
/// .SetGuiParams([targetWidth], [targetHeight])
///   Sets the GUI target width or target height. By defining the target width or the target
///   height, PictureFrame will try to set the undefined dimension according to the aspect ratio
///   needed. If neither GUI width nor height are given a target (i.e. the value is <undefined>)
///   then the GUI dimensions will be the same as the window's size.
/// 
/// .GetGuiParams()
///   Returns a struct containing the parameters set above.
/// 
/// 
/// .SetAppSurfacePixelPerfect(state)
///   Sets whether PictureFrame should use integer scaling when calculating the rendering size and
///   position of the application surface.
/// 
/// .GetAppSurfacePixelPerfect()
///   Returns the state of the above.
/// 
/// 
/// .GetCameraWidth()
/// .GetCameraHeight()
/// .GetCameraMidX()
/// .GetCameraMidY()
/// .GetViewWidth()
/// .GetViewHeight()
/// .GetWindowWidth()
/// .GetWindowHeight()
/// .GetGuiWidth()
/// .GetGuiHeight()
/// .GetGuiMidX()
/// .GetGuiMidY()
/// .GetAppSurfDrawX()
/// .GetAppSurfDrawY()
/// .GetAppSurfDrawWidth()
/// .GetAppSurfDrawHeight()
/// .GetMarginLeft()
/// .GetMarginTop()
/// .GetMarginRight()
/// .GetMarginBottom()
/// .GetGuiScale()
/// 
/// .Recalculate()
///   Immediately recalculates output variables. You shouldn't need to call this function but you
///   might find a situation where it's helpful.

function PictureFrame() constructor
{
    __input = {
        __cameraMinWidth:  640,
        __cameraMinHeight: 360,
        __cameraMaxWidth:  640,
        __cameraMaxHeight: 360,
        
        __maxViewScale:     infinity,
        __viewPixelPerfect: true,
        
        //Force "fullscreen" on non-desktop platforms
        __fullscreen: ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))? window_get_fullscreen() : true,
        
        __windowWidth:       window_get_width(),
        __windowHeight:      window_get_height(),
        __windowAllowResize: false,
        
        __guiTargetWidth:  window_get_width(),
        __guiTargetHeight: window_get_height(),
        
        __surfacePixelPerfect: true,
    };
    
    __output = {
        __cameraWidth:  undefined,
        __cameraHeight: undefined,
        
        __viewWidth:  undefined,
        __viewHeight: undefined,
        
        __windowWidth:  undefined,
        __windowHeight: undefined,
        
        __guiWidth:  undefined,
        __guiHeight: undefined,
        
        __surfaceDrawX:      undefined,
        __surfaceDrawY:      undefined,
        __surfaceDrawWidth:  undefined,
        __surfaceDrawHeight: undefined,
        
        __marginLeft:   undefined,
        __marginTop:    undefined,
        __marginRight:  undefined,
        __marginBottom: undefined,
    };
    
    __dirty = true;
    
    
    
    /// @param minWidth
    /// @param minHeight
    /// @param maxWidth
    /// @param maxHeight
    static SetCameraParams = function(_cameraMinWidth, _cameraMinHeight, _cameraMaxWidth, _cameraMaxHeight)
    {
        if ((_cameraMinWidth  != __input.__cameraMinWidth)
        ||  (_cameraMinHeight != __input.__cameraMinHeight)
        ||  (_cameraMaxWidth  != __input.__cameraMaxWidth)
        ||  (_cameraMaxHeight != __input.__cameraMaxHeight))
        {
            __input.__cameraMinWidth  = _cameraMinWidth;
            __input.__cameraMinHeight = _cameraMinHeight;
            __input.__cameraMaxWidth  = _cameraMaxWidth;
            __input.__cameraMaxHeight = _cameraMaxHeight;
            
            __dirty = true;
        }
        
        return self;
    }
    
    static GetCameraParams = function()
    {
        static _result = {};
        _result.__cameraMinWidth  = __input.__cameraMinWidth;
        _result.__cameraMinHeight = __input.__cameraMinHeight;
        _result.__cameraMaxWidth  = __input.__cameraMaxWidth;
        _result.__cameraMaxHeight = __input.__cameraMaxHeight;
        return _result;
    }
    
    
    
    /// @param maxScale
    static SetViewParams = function(_maxViewScale, _pixelPerfect)
    {
        if ((_maxViewScale != __input.__maxViewScale)
        ||  (_pixelPerfect != __input.__pixelPerfect))
        {
            __input.__maxViewScale     = _maxViewScale;
            __input.__viewPixelPerfect = _pixelPerfect;
            
            __dirty = true;
        }
        
        return self;
    }
    
    static GetViewParams = function()
    {
        static _result = {};
        _result.__maxViewScale     = __input.__maxViewScale;
        _result.__viewPixelPerfect = __input.__viewPixelPerfect;
        return _result;
    }
    
    
    
    /// @param width
    /// @param weight
    /// @param [allowResize=false]
    static SetWindowParams = function(_windowWidth, _windowHeight, _windowAllowResize = false)
    {
        if ((_windowWidth  != __input.__windowWidth)
        ||  (_windowHeight != __input.__windowHeight))
        {
            __input.__windowWidth       = _windowWidth;
            __input.__windowHeight      = _windowHeight;
            __input.__windowAllowResize = _windowAllowResize;
            
            __dirty = true;
        }
        
        return self;
    }
    
    static GetWindowParams = function()
    {
        static _result = {};
        _result.__windowWidth  = __input.__windowWidth;
        _result.__windowHeight = __input.__windowHeight;
        return _result;
    }
    
    
    
    /// @param state
    static SetFullscreen = function(_state)
    {
        //Force "fullscreen" on non-desktop platforms
        if ((os_type != os_windows) && (os_type != os_macosx) && (os_type != os_linux)) _state = true;
        
        if (_state != __input.__fullscreen)
        {
            __input.__fullscreen = _state;
        }
        
        return self;
    }
    
    static GetFullscreen = function()
    {
        return __input.__fullscreen;
    }
    
    
    
    /// @param [targetWidth]
    /// @param [targetHeight]
    static SetGuiParams = function(_guiTargetWidth = undefined, _guiTargetHeight = undefined)
    {
        if ((_guiTargetWidth != undefined) && (_guiTargetHeight != undefined))
        {
            show_error("May only specify either a GUI width target or a GUI height target, not both", true);
        }
        
        if ((_guiTargetWidth  != __input.__guiTargetWidth)
        ||  (_guiTargetHeight != __input.__guiTargetHeight))
        {
            __input.__guiTargetWidth  = _guiTargetWidth;
            __input.__guiTargetHeight = _guiTargetHeight;
            
            __dirty = true;
        }
        
        return self;
    }
    
    static GetGuiParams = function()
    {
        static _result = {};
        _result.__guiTargetWidth  = __input.__guiTargetWidth;
        _result.__guiTargetHeight = __input.__guiTargetHeight;
        return _result;
    }
    
    
    
    /// @param state
    static SetAppSurfacePixelPerfect = function(_state)
    {
        if (_state != __input.__surfacePixelPerfect)
        {
            __input.__surfacePixelPerfect = _state;
            
            __dirty = true;
        }
        
        return self;
    }
    
    static GetAppSurfacePixelPerfect = function()
    {
        return __input.__surfacePixelPerfect;
    }
    
    
    
    static GetCameraWidth = function()
    {
        Recalculate();
        return __output.__cameraWidth;
    }
    
    static GetCameraHeight = function()
    {
        Recalculate();
        return __output.__cameraHeight;
    }
    
    static GetCameraMidX = function()
    {
        return GetCameraWidth()/2;
    }
    
    static GetCameraMidY = function()
    {
        return GetCameraHeight()/2;
    }
    
    static GetViewWidth = function()
    {
        Recalculate();
        return __output.__viewWidth;
    }
    
    static GetViewHeight = function()
    {
        Recalculate();
        return __output.__viewHeight;
    }
    
    static GetWindowWidth = function()
    {
        Recalculate();
        return __output.__windowWidth;
    }
    
    static GetWindowHeight = function()
    {
        Recalculate();
        return __output.__windowHeight;
    }
    
    static GetGuiWidth = function()
    {
        Recalculate();
        return __output.__guiWidth;
    }
    
    static GetGuiHeight = function()
    {
        Recalculate();
        return __output.__guiHeight;
    }
    
    static GetGuiMidX = function()
    {
        return GetGuiWidth()/2;
    }
    
    static GetGuiMidY = function()
    {
        return GetGuiHeight()/2;
    }
    
    static GetAppSurfDrawX = function()
    {
        Recalculate();
        return __output.__surfaceDrawX;
    }
    
    static GetAppSurfDrawY = function()
    {
        Recalculate();
        return __output.__surfaceDrawY;
    }
    
    static GetAppSurfDrawWidth = function()
    {
        Recalculate();
        return __output.__surfaceDrawWidth;
    }
    
    static GetAppSurfDrawHeight = function()
    {
        Recalculate();
        return __output.__surfaceDrawHeight;
    }
    
    static GetMarginLeft = function()
    {
        Recalculate();
        return __output.__marginLeft;
    }
    
    static GetMarginTop = function()
    {
        Recalculate();
        return __output.__marginTop;
    }
    
    static GetMarginRight = function()
    {
        Recalculate();
        return __output.__marginRight;
    }
    
    static GetMarginBottom = function()
    {
        Recalculate();
        return __output.__marginBottom;
    }
    
	static GetGuiScale = function(_camWidth)
	{
		Recalculate();
		return _camWidth / GetGuiWidth();
	}
    
    
    static Apply = function()
    {
        if (view_enabled && view_visible[0])
        {
            var _camera    = view_camera[0];
            var _oldWidth  = camera_get_view_width( _camera);
            var _oldHeight = camera_get_view_height(_camera);
            
            camera_set_view_size(_camera, GetCameraWidth(), GetCameraHeight());
            camera_set_view_pos(_camera, 0.5*(_oldWidth - GetCameraWidth()), 0.5*(_oldHeight - GetCameraHeight()));
            
            view_wport[0] = GetViewWidth();
            view_hport[0] = GetViewHeight();
        }
        
        if ((surface_get_width(application_surface) != floor(GetViewWidth())) || (surface_get_height(application_surface) != floor(GetViewHeight())))
        {
            surface_resize(application_surface, GetViewWidth(), GetViewHeight());
        }
        
        if (GetFullscreen())
        {
            if (!window_get_fullscreen()) window_set_fullscreen(true);
        }
        else
        {
            if (window_get_fullscreen())
            {
                window_set_fullscreen(false);
            }
            
            if ((window_get_width() != GetWindowWidth()) || (window_get_height() != GetWindowHeight()))
            {
                window_set_size(GetWindowWidth(), GetWindowHeight());
            }
        }
        
        display_set_gui_size(GetGuiWidth(), GetGuiHeight());
        
        return self;
    }
    
    
    /// @param [texFilter]
    /// @param [blendEnable=false]
    static DrawApplicationSurface = function(_filter = (not __surfacePixelPerfect), _blendEnable = false)
    {
        Recalculate();
        with(__output)
        {
            var _oldFilter = gpu_get_tex_filter();
            var _oldBlendEnable = gpu_get_blendenable();
            
            gpu_set_tex_filter(_filter);
            gpu_set_blendenable(_blendEnable);
            
            draw_surface_stretched(application_surface, __surfaceDrawX, __surfaceDrawY, __surfaceDrawWidth, __surfaceDrawHeight);
            
            gpu_set_tex_filter(_oldFilter);
            gpu_set_blendenable(_oldBlendEnable);
        }
        
        return self;
    }
    
    static GetDebugString = function()
    {
        Recalculate();
        with(__output)
        {
            var _string = "";
            _string += "camera=" + string(__cameraWidth) + "x" + string(__cameraHeight) + "\n";
            _string += "view=" + string(__viewWidth) + "x" + string(__viewHeight) + " (scale=" + string(__viewScale) + ")\n";
            _string += "window=" + string(__windowWidth) + "x" + string(__windowHeight) + "\n";
            _string += "gui= " + string(__guiWidth) + "x" + string(__guiHeight) + "\n";
            _string += "appSurf=" + string(__surfaceDrawWidth) + "x" + string(__surfaceDrawHeight) + " @ " + string(__surfaceDrawX) + "," + string(__surfaceDrawY) + "\n";
        	return _string;
        }
    }
    
    
    
    static Recalculate = function()
    {
        if (!__dirty) return self;
        __dirty = false;
        
        with(__input)
        {
            //If we're in fullscreen mode then use the whole display as the max window size
            if (__fullscreen)
            {
                var _windowWidth  = display_get_width();
                var _windowHeight = display_get_height();
            }
            else
            {
                var _windowWidth  = __windowWidth;
                var _windowHeight = __windowHeight;
            }
            
            // --- Camera ---
            
            //Start with our output camera being the same size as the window but scaled down by the maximum view scale
            var _outCameraWidth  = _windowWidth/__maxViewScale;
            var _outCameraHeight = _windowHeight/__maxViewScale;
            
            //Figure out the scaling factor that fits us inside the maximum bounds of the camera
            //If the scaling factor is greater than or equal to 1 then the camera already fits inside the maximum bounds and no scaling is needed
            var _cameraScale = min(1, __cameraMaxWidth/_outCameraWidth, __cameraMaxHeight/_outCameraHeight);
            //Shrink down the camera so that it fits inside the maximum bounds
            _outCameraWidth  *= _cameraScale;
            _outCameraHeight *= _cameraScale;
            
            //Figure out the s_cameraScalecaling factor that fits us outside the minimum bounds
            //If the scaling factor is less than or equal to 1 then the camera already fits outside the minimum bounds and no scaling is needed
            var _cameraScale = max(1, __cameraMinWidth/_outCameraWidth, __cameraMinHeight/_outCameraHeight);
            //Expand down the camera so that it fits outside the maximum bounds
            _outCameraWidth  *= _cameraScale;
            _outCameraHeight *= _cameraScale;
            
            //Clip to the maximum bounds in case we've gone too far in one direction
            //This handles edge cases where there is no acceptible solution
            _outCameraWidth  = min(_outCameraWidth,  __cameraMaxWidth );
            _outCameraHeight = min(_outCameraHeight, __cameraMaxHeight);
            
            // --- View ---
            
            //Figure out the scaling factor that fits the camera inside the window
            //We limit how scaled up the view can be at the same time here too
            var _outViewScale = min(__maxViewScale, _windowWidth/_outCameraWidth, _windowHeight/_outCameraHeight);
            
            //If we're using pixel perfect scaling for our view then drop down to the nearest integer scale
            if (__viewPixelPerfect && (_outViewScale > 1)) _outViewScale = floor(_outViewScale);
            
            //Scale up the view using the same aspect ratio as the camera
            var _outViewWidth  = _outViewScale*_outCameraWidth;
            var _outViewHeight = _outViewScale*_outCameraHeight;
            
            // --- Window ---
            
            if (!__windowAllowResize || __fullscreen)
            {
                //If we're in fullscreen mode then the window size is always at the maximum (which is the size of the display)
                var _outWindowWidth  = _windowWidth;
                var _outWindowHeight = _windowHeight;
            }
            else
            {
                //Otherwise use the view dimensions
                var _outWindowWidth  = _outViewWidth;
                var _outWindowHeight = _outViewHeight;
            }
            
            // --- GUI ---
            
            if ((__guiTargetWidth == undefined) && (__guiTargetHeight == undefined))
            {
                //We don't have target GUI dimensions, use the window size for the GUI
                var _outGuiWidth  = _outWindowWidth;
                var _outGuiHeight = _outWindowHeight;
            }
            else if (__guiTargetWidth == undefined)
            {
                //GUI height is fixed and width is flexible. Scale the GUI width to be in proportion to the GUI height
                var _outGuiWidth  = (__guiTargetHeight/_outWindowHeight)*_outWindowWidth;
                var _outGuiHeight = __guiTargetHeight;
            }
            else // (__guiTargetHeight == undefined)
            {
                //GUI width is fixed and height is flexible. Scale the GUI height to be in proportion to the GUI width
                var _outGuiWidth  = __guiTargetWidth;
                var _outGuiHeight = (__guiTargetWidth/_outWindowWidth)*_outWindowHeight;
            }
            
            // --- Application Surface Drawing ---
            
            //Figure out the scaling factor that fits the application surface inside the GUI dimensions
            var _surfaceScale = min(_outGuiWidth/_outViewWidth, _outGuiHeight/_outViewHeight);
            
            //If we're using pixel perfect scaling then drop down to the nearest integer scale
            if (__surfacePixelPerfect && (_surfaceScale > 1)) _surfaceScale = floor(_surfaceScale);
            
            //Centre the application surface on the GUI layer
            var _surfaceDrawWidth  = _surfaceScale*_outViewWidth;
            var _surfaceDrawHeight = _surfaceScale*_outViewHeight;
            var _surfaceDrawX      = 0.5*(_outGuiWidth  - _surfaceDrawWidth );
            var _surfaceDrawY      = 0.5*(_outGuiHeight - _surfaceDrawHeight);
        }
        
        with(__output)
        {
            __cameraWidth  = _outCameraWidth;
            __cameraHeight = _outCameraHeight;
            
            __viewWidth  = _outViewWidth;
            __viewHeight = _outViewHeight;
            __viewScale  = _outViewScale;
        
            __windowWidth  = _outWindowWidth;
            __windowHeight = _outWindowHeight;
            
            __guiWidth  = _outGuiWidth;
            __guiHeight = _outGuiHeight;
            
            __surfaceDrawX      = _surfaceDrawX;
            __surfaceDrawY      = _surfaceDrawY;
            __surfaceDrawWidth  = _surfaceDrawWidth;
            __surfaceDrawHeight = _surfaceDrawHeight;
            
            __marginLeft   = _surfaceDrawX;
            __marginTop    = _surfaceDrawY;
            __marginRight  = _surfaceDrawX + _surfaceDrawWidth;
            __marginBottom = _surfaceDrawY + _surfaceDrawHeight;
        }
        
        return self;
    }
}