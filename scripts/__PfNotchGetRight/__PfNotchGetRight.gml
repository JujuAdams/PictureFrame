// Feather disable all

function __PfNotchGetRight()
{
    if (os_type == os_android)
    {
        return __PfNotchGetRightRaw();
    }
    else if (os_type == os_ios)
    {
        if (display_get_orientation() != display_landscape) return 0;
        
        var _width = __PfGetDisplayWidthRaw();
        return (_width == 0)? 0 : ceil(0.67 * __PfNotchGetRightRaw() * display_get_width() / _width);
    }
    else
    {
        return 0;
    }
}