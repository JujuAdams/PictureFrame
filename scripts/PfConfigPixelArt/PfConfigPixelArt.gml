// Feather disable all

/// Convenience function that returns a configuration struct set up for pixel-perfect rendering.
/// You can edit values in the returned struct if you'd like and it will obey all the same rules
/// as a configuration struct returned by PfConfigGeneral().
/// 
/// N.B. Because PfConfigPixelArt() returns a fresh struct every time it is called, you should
///      avoid calling this function more often than is necessary.
/// 
/// @param [targetWidth]
/// @param [targetHeight]
/// @param [fullscreen]
/// @param [minWidth]
/// @param [minHeight]
/// @param [maxWidth=Min]
/// @param [maxHeight=Min]

function PfConfigPixelArt(_targetWidth, _targetHeight, _fullscreen = window_get_fullscreen(), _minWidth = undefined, _minHeight = undefined, _maxWidth = undefined, _maxHeight = undefined)
{
    return {
        cameraTargetWidth:  _targetWidth,
        cameraTargetHeight: _targetHeight,
        cameraMinWidth:     _minWidth,
        cameraMinHeight:    _minHeight,
        cameraMaxWidth:     _maxWidth,
        cameraMaxHeight:    _maxHeight,
        
        cameraOverscan: 0,
        
        viewMaxScale:     1,
        viewPixelPerfect: true,
        
        //Force "fullscreen" on non-desktop platforms
        fullscreen: ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))? _fullscreen : true,
        
        windowWidth:  window_get_width(),
        windowHeight: window_get_height(),
        
        guiStretchOverWindow: false,
        guiTargetWidth:  (_targetWidth < _targetHeight)? _targetWidth : undefined,
        guiTargetHeight: (_targetWidth < _targetHeight)? undefined : _targetHeight,
        
        surfacePixelPerfect: true,
        windowOverscanScale:  1,
    }
}