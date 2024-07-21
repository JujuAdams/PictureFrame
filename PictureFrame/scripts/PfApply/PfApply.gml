// Feather disable all

/// Applies a PictureFrame result struct, setting necessary native GameMaker values to ensure that
/// the values in the result struct accurately affect the game. A PictureFrame result struct is
/// made by calling PfCalculate() - please see that function for further information.
/// 
/// N.B. Due to GameMaker's native application surface drawing behaviour, it is likely that even
///      after applying a result struct you will have encounter some graphical defects. You will
///      very probably want to call PfPostDrawAppSurface() to manually, and correctly, draw the
///      application surface. Please see PfPostDrawAppSurface() for more details.
/// 
/// PfApply() calls the following functions to set native GameMaker values:
/// 
/// - Camera position and size. PfApply() presumes that you are using GameMaker's native view
///   system and that you're using view[0] for your game view. If a camera's width or height
///   changes then it will resize keeping the centre of the view static.
/// 
///   Functions called:
///     view_enabled = true
///     view_set_visible(0, true)
///     camera_set_view_pos(view_get_camera(0), ...)
///     camera_set_view_size(view_get_camera(0), ...)
/// 
/// - View width and height. PfApply() presumes that you are using GameMaker's native view system
///   and that you're using view[0] for your game view.
/// 
///   Functions called:
///     view_set_wport(0, ...)
///     view_set_hport(0, ...)
/// 
/// - Application surface size. PfApply() will set the size of the application surface to match the
///   size of the view.
/// 
///   Functions called:
///     surface_resize(application_surface, ...)
/// 
/// - Window position and size, including fullscreen state. If the window's size changes then the
///   window will be resized keeping the centre of the window static on the display. PfApply() will
///   only adjust the window when on desktop platforms (Windows, MacOS, Linux).
/// 
///   Functions called:
///     window_set_fullscreen(...)
///     window_set_rectangle(...)
/// 
/// - GUI layer scale.
/// 
///   Functions called:
///     display_set_gui_size(...)
/// 
/// @param resultStruct
/// @param [ignoreCamera=false]

function PfApply(_resultStruct, _ignoreCamera = false)
{
    static _system = __PfSystem();
    _system.__resultStruct = _resultStruct;
    if (not _system.__noAppSurfDrawDisable) application_surface_draw_enable(false);
    
    with(_resultStruct)
    {
        if (not _ignoreCamera)
        {
            view_enabled = true;
            view_set_visible(0, true);
            
            var _camera = view_get_camera(0);
            if (_camera < 0)
            {
                view_set_camera(0, camera_create_view(0, 0, cameraWidth, cameraHeight));
            }
            else
            {
                var _oldWidth  = camera_get_view_width( _camera);
                var _oldHeight = camera_get_view_height(_camera);
                
                var _x = camera_get_view_x(_camera) - 0.5*(_oldWidth - cameraWidth);
                var _y = camera_get_view_y(_camera) - 0.5*(_oldHeight - cameraHeight);
                
                camera_set_view_pos(_camera, _x, _y);
                camera_set_view_size(_camera, cameraWidth, cameraHeight);
            }
        }
        
        if (view_enabled && view_get_visible(0))
        {
            view_set_wport(0, viewWidth);
            view_set_hport(0, viewHeight);
        }
        
        if ((surface_get_width(application_surface) != floor(viewWidth)) || (surface_get_height(application_surface) != floor(viewHeight)))
        {
            surface_resize(application_surface, viewWidth, viewHeight);
        }
        
        if ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))
        {
            if (fullscreen)
            {
                if (not window_get_fullscreen()) window_set_fullscreen(true);
            }
            else
            {
                if (window_get_fullscreen())
                {
                    window_set_fullscreen(false);
                }
                
                if ((window_get_width() != windowWidth) || (window_get_height() != windowHeight))
                {
                    var _oldWidth  = window_get_width();
                    var _oldHeight = window_get_height();
                    var _width     = windowWidth;
                    var _height    = windowHeight;
                    
                    var _x = window_get_x() - 0.5*(_width  - _oldWidth);
                    var _y = window_get_y() - 0.5*(_height - _oldHeight);
                    
                    window_set_rectangle(_x, _y, _width, _height);
                }
            }
        }
        
        display_set_gui_size(guiWidth, guiHeight);
    }
}