// Feather disable all

/// Convenience function that returns a configuration struct set up for pixel-perfect rendering.
/// You can edit values in the returned struct if you'd like and it will obey all the same rules
/// as a configuration struct returned by PfConfigGeneral().
/// 
/// N.B. Because PfConfigPixelArt() returns a fresh struct every time it is called, you should
///      avoid calling this function more often than is necessary.
/// 
/// @param cameraWidth
/// @param cameraHeight
/// @param [subpixelling=false]
/// @param [fullscreen]

function PfConfigPixelArt(_cameraWidth, _cameraHeight, _subpixelling = false, _fullscreen = window_get_fullscreen())
{
    return {
        cameraMinWidth:  _cameraWidth,
        cameraMinHeight: _cameraHeight,
        
        cameraMaxWidth:  _cameraWidth,
        cameraMaxHeight: _cameraHeight,
        
        viewMaxScale:     _subpixelling? infinity : 1,
        viewPixelPerfect: true,
        
        //Force "fullscreen" on non-desktop platforms
        fullscreen: ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))? _fullscreen : true,
        
        windowWidth:       window_get_width(),
        windowHeight:      window_get_height(),
        windowAllowResize: true,
        
        guiTargetWidth:  (_cameraWidth < _cameraHeight)? _cameraWidth : undefined,
        guiTargetHeight: (_cameraWidth < _cameraHeight)? undefined : _cameraHeight,
        
        surfacePixelPerfect: (not _subpixelling),
    }
}