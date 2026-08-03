// Feather disable all

/// Convenience function that returns a configuration struct set up for high resolution rendering.
/// This function will try to stretch the size of the GUI layer so that its size is close to the
/// target width/height but adjusted to match the aspect ratio of the camera (`.guiMode` is set to
/// `6`).
/// 
/// You can edit values in the returned struct if you'd like and it will obey all the same rules as
/// a configuration struct returned by `PfConfigGeneral()`.
/// 
/// N.B. Because `PfConfigHighRes()` returns a fresh struct every time it is called, you should
///      avoid calling this function more often than is necessary.
/// 
/// @param targetWidth
/// @param targetHeight
/// @param [fullscreen]
/// @param [maxWidth]
/// @param [maxHeight]

function PfConfigHighRes(_targetWidth, _targetHeight, _fullscreen = window_get_fullscreen(), _maxWidth = -1, _maxHeight = -1)
{
    return {
        cameraTargetWidth:  _targetWidth,
        cameraTargetHeight: _targetHeight,
        cameraMaxWidth:     _maxWidth,
        cameraMaxHeight:    _maxHeight,
        
        cameraOverscan: 0,
        cameraIgnore:   false,
        
        viewMaxScale:     infinity,
        viewPixelPerfect: false,
        
        //Force "fullscreen" on non-desktop platforms
        fullscreen: PICTURE_FRAME_ON_DESKTOP? _fullscreen : true,
        
        trimBlackBars: true,
        windowWidth:   __PfWindowGetWidth(),
        windowHeight:  __PfWindowGetHeight(),
        
        guiWindowStretch: false,
        guiMode:          6,
        guiTargetWidth:   _targetWidth,
        guiTargetHeight:  _targetHeight,
        guiScale:         1,
        guiAvoidNotch:    true,
        
        surfaceAvoidNotch:   true,
        surfacePixelPerfect: false,
        
        windowOverscanScale: 1,
    }
}