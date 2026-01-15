// Feather disable all

/// Convenience function that returns a configuration struct set up for pixel-perfect rendering.
/// This function will set the size of the GUI layer to be the same as the size of the camera
/// (`.guiMode` is set to `1`). You can further edit values in the returned struct if you'd like
/// and it will obey all the samerules as a configuration struct returned by `PfConfigGeneral()`.
/// 
/// N.B. Because `PfConfigPixelArt()` returns a fresh struct every time it is called, you should
///      avoid calling this function more often than is necessary.
/// 
/// @param [targetWidth]
/// @param [targetHeight]
/// @param [fullscreen]
/// @param [minWidth]
/// @param [minHeight]
/// @param [maxWidth=min]
/// @param [maxHeight=min]

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
        fullscreen: __PF_ON_DESKTOP? _fullscreen : true,
        
        trimBlackBars: true,
        windowWidth:   window_get_width(),
        windowHeight:  window_get_height(),
        
        guiWindowStretch: false,
        guiMode:          1,
        guiTargetWidth:   _targetWidth,
        guiTargetHeight:  _targetHeight,
        guiScale:         1,
        
        surfacePixelPerfect: true,
        windowOverscanScale: 1,
    }
}