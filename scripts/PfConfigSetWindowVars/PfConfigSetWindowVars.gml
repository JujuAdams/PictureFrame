// Feather disable all

/// Updates window variables in the configuration struct. This is helpful to call after detecting
/// a window state change with `PfGetWindowStateChanged()` to refresh a config struct.
/// 
/// Variables adjusted are:
/// 
/// .fullscreen
///     The fullscreen state for the game.
/// 
/// .windowWidth
/// .windowHeight
///     The size of the game window.
/// 
/// @param configStruct

function PfConfigSetWindowVars(_configStruct)
{
    with(_configStruct)
    {
        fullscreen   = window_get_fullscreen();
        windowWidth  = window_get_width();
        windowHeight = window_get_height();
    }
    
    return _configStruct;
}