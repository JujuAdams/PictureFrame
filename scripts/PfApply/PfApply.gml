// Feather disable all

/// Applies a PictureFrame configuration struct to the render state for the game, setting up
/// cameras, views, window size etc.  This function calls `PfCalculate()` to generate a layout
/// struct and then uses values from the layout struct to call various GameMaker functions. The
/// layout struct is then returned by `PfApply()` for you to use elsewhere. You can also get the
/// currently applied config and layout structs with `PfGetAppliedConfigStruct()` and
/// `PfGetAppliedLayoutStruct()` respectively.
/// 
/// N.B. Automatic drawing of the application surface will always be disabled by `PfApply()` by
///      calling `application_surface_draw_enable(false)`. This means that without further action,
///      your game will not be visible. You should call `PfPostDrawAppSurface()` in a Post Draw
///      event to ensure that your application surface is visible for the player.
/// 
/// There are some optional parameters that affect how the layout struct is applied. The
/// `tryResizeWindow` parameter applies when the game is already windowed or is transitioning from
/// fullscreen to a windowed state (as such, it only applies on desktop platforms). When
/// `tryResizeWindow` is set to `true`, the function will change the size and position of the
/// window, including trimming extra space if the `.trimBlackBars` option has been set in the input
/// configuration struct.
/// 
/// `cameraIgnoreForce` is an optional parameter that allows you to override the `.cameraIgnore`
/// variable in the layout struct. If set to `true` or `false` then that behaviour will be
/// enforced. Regardless of whether the native GameMaker is ignored, you can still use the two
/// camera size variables, `.cameraWidth` and `.cameraHeight`, from the returned layout struct to
/// setup whatever you need yourself.
/// 
/// N.B. Because `PfApply()` runs a lot of logic and returns a fresh struct every time it is
///      called, you should avoid calling this function more often than is necessary.
/// 
/// @param configStruct
/// @param [tryResizeWindow=false]
/// @param [cameraIgnoreForce]
/// 
/// 
/// 
/// `PfApply()` calls the following functions to set native GameMaker values:
///   
///   - Camera position and size. These will only be adjusted if the `.cameraIgnore` variable in
///     the layout struct is set to `false` or the optional `cameraIgnoreForce` parameter for
///     this function is set to `false`. `PfApply()` presumes that you are using GameMaker's native
///     view system and that you're using view[0] for your game view and will set up view[0] for
///     rendering. If `PfApply()` causes a camera's width or height to change then it will resize
///     keeping the centre of the camera pointing at the same roomspace position.
///     
///     Functions called:
///         view_enabled = true
///         view_set_visible(0, true)
///         camera_set_view_pos(view_get_camera(0), ...)
///         camera_set_view_size(view_get_camera(0), ...)
///   
///   - Application surface size. `PfApply()` will set the size of the application surface to match
///     the size of the view. For pixel perfect configurations, the size of the view is usually the
///     same size as the camera but edge cases exist and this isn't guaranteed.
///     
///     Functions called:
///         surface_resize(application_surface, ...)
///   
///   - Viewport dimensions. `PfApply()` presumes that you are using GameMaker's native view system
///     and that you're using view[0] for your game view. If you are using a custom system of some
///     kind then you should use the layout struct returned by `PfApply()` to update that system.
///     Viewport dimensions will only be adjusted if `view_enable` is set to `true` and view[0] is
///     visible (both of these conditions might be met, see "Camera position and size" above).
///     
///     Functions called:
///         view_set_xport(0, 0)
///         view_set_yport(0, 0)
///         view_set_wport(0, ...)
///         view_set_hport(0, ...)
///   
///   - Window position and size, including fullscreen state. If the window's size changes then the
///     window will be resized keeping the centre of the window static on the display. `PfApply()`
///     will only adjust the window when on desktop platforms (Windows, MacOS, Linux).
///     
///     Functions called:
///         window_set_fullscreen(...)
///         window_set_rectangle(...)
///   
///   - GUI layer scale. The exact size that gets set is controlled by the `.guiMode` variable
///     found in the configuration struct.
///     
///     Functions called:
///         display_set_gui_maximize(...)

function PfApply(_configStruct, _tryResizeWindow = false, _cameraIgnoreForce = undefined)
{
    static _system = __PfSystem();
    
    //Force a resize if we're swapping from fullscreen to window
    if (PICTURE_FRAME_ON_DESKTOP && (not _configStruct.fullscreen) && window_get_fullscreen())
    {
        _tryResizeWindow = true;
    }
    
    //Disable automatic application surface drawing
    if (not _system.__noAppSurfDrawDisable)
    {
        application_surface_draw_enable(false);
    }
    
    var _layoutStruct = PfCalculate(_configStruct, _tryResizeWindow);
    
    _system.__configStruct = variable_clone(_configStruct);
    _system.__layoutStruct = _layoutStruct;
    
    if (PICTUREFRAME_VERBOSE) __PfTrace($"`PfApply()` called with `tryResizeWindow` = `{_tryResizeWindow? "true" : "false"}` and  `cameraIgnoreForce` = `{(_cameraIgnoreForce == undefined)? "undefined" : (_cameraIgnoreForce? "true" : "false")}`");
    
    with(_layoutStruct)
    {
        _cameraIgnoreForce ??= cameraIgnore;
        if (PICTUREFRAME_VERBOSE) __PfTrace($"`cameraIgnoreForce` resolved to `{(_cameraIgnoreForce? "true" : "false")}`");
        
        if (not _cameraIgnoreForce)
        {
            view_enabled = true;
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Set `view_enabled` to `true` to turn on views for this room");
            
            var _camera = view_get_camera(0);
            if (_camera < 0)
            {
                //No camera exists, create it
                view_set_visible(0, true);
                var _camera = camera_create_view(0, 0, cameraWidth, cameraHeight);
                view_set_camera(0, _camera);
                if (PICTUREFRAME_VERBOSE) __PfTrace($"Set view[0] to visible, created camera {_camera}, and set the camera size to {cameraWidth} x {cameraHeight}");
            }
            else
            {
                if (view_get_visible(0))
                {
                    //A camera is already renderering. Resize whilst keeping the centre of the camera pointing at the same point
                    var _oldWidth  = camera_get_view_width( _camera);
                    var _oldHeight = camera_get_view_height(_camera);
                    
                    var _x = camera_get_view_x(_camera) + 0.5*(_oldWidth - cameraWidth);
                    var _y = camera_get_view_y(_camera) + 0.5*(_oldHeight - cameraHeight);
                    
                    camera_set_view_pos(_camera, _x, _y);
                    camera_set_view_size(_camera, cameraWidth, cameraHeight);
                    
                    if (PICTUREFRAME_VERBOSE) __PfTrace($"Set camera {_camera} for view[0] to {cameraWidth} x {cameraHeight} at position ({_x}, {_y})");
                }
                else
                {
                    //Camera exists but the view isn't visible, set up the camera in the default top-left corner
                    view_set_visible(0, true);
                    camera_set_view_pos(_camera, 0, 0);
                    camera_set_view_size(_camera, cameraWidth, cameraHeight);
                    
                    if (PICTUREFRAME_VERBOSE) __PfTrace($"Set view[0] to visible and set its camera ({_camera}) to {cameraWidth} x {cameraHeight} at position (0, 0)");
                }
            }
        }
        
        //Make sure the applicationn surface matches the view
        if ((surface_get_width(application_surface) != floor(viewWidth)) || (surface_get_height(application_surface) != floor(viewHeight)))
        {
            surface_resize(application_surface, viewWidth, viewHeight);
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Resizing application surface to {viewWidth} x {viewHeight} (should be the same as the view)");
        }
        
        //Set the view position to take up the entirety of the application surface
        if (view_enabled && view_get_visible(0))
        {
            view_set_xport(0, 0);
            view_set_yport(0, 0);
            view_set_wport(0, viewWidth);
            view_set_hport(0, viewHeight);
            
            if (PICTUREFRAME_VERBOSE) __PfTrace($"Set viewport to {viewWidth} x {viewHeight} at position (0, 0) on the application surface");
        }
        
        //Handle fullscreen transition and window size on desktop
        if (PICTURE_FRAME_ON_DESKTOP)
        {
            if (fullscreen)
            {
                if (not window_get_fullscreen())
                {
                    window_set_fullscreen(true);
                    if (PICTUREFRAME_VERBOSE) __PfTrace($"Set fullscreen");
                }
            }
            else
            {
                if (window_get_fullscreen())
                {
                    window_set_fullscreen(false);
                    if (PICTUREFRAME_VERBOSE) __PfTrace($"Set windowed");
                }
                
                if (_tryResizeWindow && ((window_get_width() != windowWidth) || (window_get_height() != windowHeight)))
                {
                    var _oldWidth  = window_get_width();
                    var _oldHeight = window_get_height();
                    var _width     = windowWidth;
                    var _height    = windowHeight;
                    
                    var _x = window_get_x() - 0.5*(_width  - _oldWidth);
                    var _y = window_get_y() - 0.5*(_height - _oldHeight);
                    
                    window_set_rectangle(_x, _y, _width, _height);
                    
                    if (PICTUREFRAME_VERBOSE) __PfTrace($"Set window rectangle to {_width} x {_height} at position ({_x}, {_y})");
                }
            }
        }
        
        //Set up the GUI layer transform. This function is really weird, I don't like it, but we
        //have to use it regardless
        display_set_gui_maximize(1/windowToGuiScaleX, 1/windowToGuiScaleY, guiX, guiY);
        
        if (PICTUREFRAME_VERBOSE)
        {
            __PfTrace($"Set the GUI to {guiWidth} x {guiHeight} at position ({guiX}, {guiY})");
            __PfTrace($"Calling `display_set_gui_maximize({1/windowToGuiScaleX}, {1/windowToGuiScaleY}, {guiX}, {guiY})`");
        }
    }
    
    return _layoutStruct;
}