// Feather disable all

/// Convenience function that returns a configuration struct set up for pixel-perfect rendering.
/// This function will set the size of the GUI layer to be the same as the size of the camera
/// (`.guiMode` is set to `1`).
/// 
/// You can further edit values in the returned struct if you'd like and it will obey all the same
/// rules as a configuration struct returned by `PfConfigGeneral()`.
/// 
/// On most platforms, the application surface will be drawn to the window such that it maintains
/// pixel-perfect rendering (`.surfacePixelPerfect` is set to `true`). However, on mobile you'll
/// usually want the application surface to fill the entire usable area of the screen. As a result,
/// the `.surfacePixelPerfect` variable will be set to `false` when `PfConfigPixelArt()` is called
/// on iOS and Android devices. You can override this behaviour yourself on any platform by setting
/// `.surfacePixelPerfect` on the returned struct.
/// 
/// N.B. Because `PfConfigPixelArt()` returns a fresh struct every time it is called, you should
///      avoid calling this function more often than is necessary.
/// 
/// @param targetWidth
/// @param targetHeight
/// @param [fullscreen]
/// @param [maxWidth]
/// @param [maxHeight]

function PfConfigPixelArt(_targetWidth, _targetHeight, _fullscreen = window_get_fullscreen(), _maxWidth = -1, _maxHeight = -1)
{
    return {
        cameraTargetWidth:  _targetWidth,
        cameraTargetHeight: _targetHeight,
        cameraMaxWidth:     _maxWidth,
        cameraMaxHeight:    _maxHeight,
        
        cameraOverscan: 0,
        cameraIgnore:   false,
        
        viewMaxScale:     1,
        viewPixelPerfect: true,
        
        //Force "fullscreen" on non-desktop platforms
        fullscreen: PICTURE_FRAME_ON_DESKTOP? _fullscreen : true,
        
        trimBlackBars: true,
        windowWidth:   window_get_width(),
        windowHeight:  window_get_height(),
        
        guiWindowStretch: false,
        guiMode:          1,
        guiTargetWidth:   _targetWidth,
        guiTargetHeight:  _targetHeight,
        guiScale:         1,
        guiAvoidNotch:    true,
        
        surfaceAvoidNotch:   true,
        surfacePixelPerfect: not PICTURE_FRAME_ON_MOBILE,
        
        windowOverscanScale: 1,
    }
}