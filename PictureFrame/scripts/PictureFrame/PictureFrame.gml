function PictureFrame() constructor
{
    __input = {
        __cameraMinWidth:  640,
        __cameraMinHeight: 360,
        __cameraMaxWidth:  640,
        __cameraMaxHeight: 360,
        
        __maxViewScale: infinity,
        __pixelPerfect: true,
        
        //Force "fullscreen" on non-desktop platforms
        __fullscreen: ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))? window_get_fullscreen() : true,
        
        __windowWidth:       window_get_width(),
        __windowHeight:      window_get_height(),
        __windowAllowResize: false,
        
        __guiTargetWidth:  window_get_width(),
        __guiTargetHeight: window_get_height(),
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
    /// @param pixelPerfect
    static SetViewParams = function(_maxViewScale, _pixelPerfect)
    {
        if ((_maxViewScale != __input.__maxViewScale)
        ||  (_pixelPerfect != __input.__pixelPerfect))
        {
            __input.__maxViewScale = _maxViewScale;
            __input.__pixelPerfect = _pixelPerfect;
            
            __dirty = true;
        }
        
        return self;
    }
    
    static GetViewParams = function()
    {
        static _result = {};
        _result.__maxViewScale   = __input.__maxViewScale;
        _result.__pixelPerfect   = __input.__pixelPerfect;
        return _result;
    }
    
    
    
    /// @param width
    /// @param weight
    /// @param [allowResize=false]
    static SetWindowParams = function(_windowWidth, _windowHeight, _windowAllowResize)
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
    
    
    
    /// @param targetWidth
    /// @param targetHeight
    static SetGuiParams = function(_guiTargetWidth, _guiTargetHeight)
    {
        if ((_guiTargetWidth != undefined) && (_guiTargetHeight != undefined))
        {
            show_error("May only specify either a GUI width target or a GUI height target, not both");
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
            var _camera = view_camera[0];
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
            else if ((window_get_width() != GetWindowWidth()) || (window_get_height() != GetWindowHeight()))
            {
                window_set_size(GetWindowWidth(), GetWindowHeight());
            }
        }
        
        display_set_gui_size(GetGuiWidth(), GetGuiHeight());
        
        return self;
    }
    
    static DrawApplicationSurface = function(_filter, _blendEnable = false)
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
            
            //Start with our output camera being the same size as the window but scaled down by the maximum view scale
            var _outCameraWidth  = _windowWidth/__maxViewScale;
            var _outCameraHeight = _windowHeight/__maxViewScale;
            
            //Figure out the scaling factor that fits us inside the maximum bounds
            //If the scaling factor is greater than or equal to 1 then the camera already fits inside the maximum bounds and no scaling is needed
            var _scale = min(1, __cameraMaxWidth/_outCameraWidth, __cameraMaxHeight/_outCameraHeight);
            //Shrink down the camera so that it fits inside the maximum bounds
            _outCameraWidth  *= _scale;
            _outCameraHeight *= _scale;
            
            //Figure out the scaling factor that fits us outside the minimum bounds
            //If the scaling factor is less than or equal to 1 then the window already fits outside the minimum bounds and no scaling is needed
            var _scale = max(1, __cameraMinWidth/_outCameraWidth, __cameraMinHeight/_outCameraHeight);
            //Expand down the window so that it fits outside the maximum bounds
            _outCameraWidth  *= _scale;
            _outCameraHeight *= _scale;
            
            //Clip to the maximum bounds in case we've put a foot over the line
            _outCameraWidth  = min(_outCameraWidth,  __cameraMaxWidth );
            _outCameraHeight = min(_outCameraHeight, __cameraMaxHeight);
            
            //Figure out the scaling factor that fits the camera inside the window
            var _outViewScale = min(__maxViewScale, _windowWidth/_outCameraWidth, _windowHeight/_outCameraHeight);
            if (__pixelPerfect && (_outViewScale > 1)) _outViewScale = floor(_outViewScale);
            
            //And work out the view dimensions too
            var _outViewWidth  = _outViewScale*_outCameraWidth;
            var _outViewHeight = _outViewScale*_outCameraHeight;
            
            //If we're in fullscreen mode then the window size is always at the maximum (which is the size of the display)
            if (!__windowAllowResize || __fullscreen)
            {
                var _outWindowWidth  = _windowWidth;
                var _outWindowHeight = _windowHeight;
            }
            else
            {
                var _outWindowWidth  = _outViewWidth;
                var _outWindowHeight = _outViewHeight;
            }
            
            if ((__guiTargetWidth == undefined) && (__guiTargetHeight == undefined))
            {
                var _outGuiWidth  = _outWindowWidth;
                var _outGuiHeight = _outWindowHeight;
            }
            else if (__guiTargetWidth == undefined)
            {
                var _outGuiWidth  = (__guiTargetHeight/_outWindowHeight)*_outWindowWidth;
                var _outGuiHeight = __guiTargetHeight;
            }
            else // (__guiTargetHeight == undefined)
            {
                var _outGuiWidth  = __guiTargetWidth;
                var _outGuiHeight = (__guiTargetWidth/_outWindowWidth)*_outWindowHeight;
            }
            
            //Figure out the scaling factor that fits the application surface inside the GUI dimensions
            var _scale = min(_outGuiWidth/_outViewWidth, _outGuiHeight/_outViewHeight);
            var _surfaceDrawWidth  = _scale*_outViewWidth;
            var _surfaceDrawHeight = _scale*_outViewHeight;
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