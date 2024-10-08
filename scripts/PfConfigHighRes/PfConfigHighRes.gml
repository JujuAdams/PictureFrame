// Feather disable all

/// Convenience function that returns a configuration struct set up for high resolution rendering.
/// You can edit values in the returned struct if you'd like and it will obey all the same rules
/// as a configuration struct returned by PfConfigGeneral().
/// 
/// N.B. Because PfConfigHighRes() returns a fresh struct every time it is called, you should
///      avoid calling this function more often than is necessary.
/// 
/// @param cameraMinWidth
/// @param cameraMinHeight
/// @param [cameraMaxWidth=Min]
/// @param [cameraMaxHeight=Min]
/// @param [fullscreen]

function PfConfigHighRes(_cameraMinWidth, _cameraMinHeight, _cameraMaxWidth = _cameraMinWidth, _cameraMaxHeight = _cameraMinHeight, _fullscreen = window_get_fullscreen())
{
    return {
        cameraMinWidth:  _cameraMinWidth,
        cameraMinHeight: _cameraMinHeight,
        
        cameraMaxWidth:  _cameraMaxWidth,
        cameraMaxHeight: _cameraMaxHeight,
        
        cameraOverscan: 0,
        
        viewMaxScale:     infinity,
        viewPixelPerfect: false,
        
        //Force "fullscreen" on non-desktop platforms
        fullscreen: ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))? _fullscreen : true,
        
        windowWidth:  window_get_width(),
        windowHeight: window_get_height(),
        
        guiStretchOverWindow: false,
        
        guiTargetWidth:  (_cameraMinWidth < _cameraMinHeight)? _cameraMinWidth : undefined,
        guiTargetHeight: (_cameraMinWidth < _cameraMinHeight)? undefined : _cameraMinHeight,
        
        surfacePixelPerfect: false,
        windowOverscanScale:  1,
    }
}