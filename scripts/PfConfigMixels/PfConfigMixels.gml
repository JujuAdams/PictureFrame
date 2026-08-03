// Feather disable all

/// Convenience function that returns a configuration struct set up for pixel art games that want
/// to allow for smooth rotation and scaling of graphics (a.k.a. "mixels"). This function will set
/// the size of the GUI layer to be the same as the size of the camera (`.guiMode` is set to `1`).
/// 
/// You can further edit values in the returned struct if you'd like and it will obey all the same
/// rules as a configuration struct returned by `PfConfigGeneral()`.
/// 
/// N.B. Because `PfConfigMixels()` returns a fresh struct every time it is called, you should
///      avoid calling this function more often than is necessary.
/// 
/// @param targetWidth
/// @param targetHeight
/// @param [fullscreen]
/// @param [maxWidth]
/// @param [maxHeight]

function PfConfigMixels(_targetWidth, _targetHeight, _fullscreen = window_get_fullscreen(), _maxWidth = -1, _maxHeight = -1)
{
    return {
        cameraTargetWidth:  _targetWidth,
        cameraTargetHeight: _targetHeight,
        cameraMaxWidth:     _maxWidth,
        cameraMaxHeight:    _maxHeight,
        
        cameraOverscan: 0,
        cameraIgnore:   false,
        
        viewMaxScale:     infinity,
        viewPixelPerfect: true,
        
        //Force "fullscreen" on non-desktop platforms
        fullscreen: PICTURE_FRAME_ON_DESKTOP? _fullscreen : true,
        
        trimBlackBars: true,
        windowWidth:   __PfWindowGetWidth(),
        windowHeight:  __PfWindowGetHeight(),
        
        guiWindowStretch: false,
        guiMode:          1,
        guiTargetWidth:   _targetWidth,
        guiTargetHeight:  _targetHeight,
        guiScale:         1,
        guiAvoidNotch:    true,
        
        surfaceAvoidNotch:   true,
        surfacePixelPerfect: false,
        
        windowOverscanScale: 1,
    }
}