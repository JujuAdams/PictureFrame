// Feather disable all

/// Updates window variables in the configuration struct. You should call this before `PfApply()`
/// unless you have specific state that you'd like to set.

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