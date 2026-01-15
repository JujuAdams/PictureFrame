// Feather disable all

/// Updates window variables in the configuration struct.

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