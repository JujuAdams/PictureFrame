// Feather disable all

function __PfNotchGetLeft()
{
    if (os_type == os_android)
    {
        return __PfNotchGetLeftRaw();
    }
    else if (os_type == os_ios)
    {
        if (display_get_orientation() != display_landscape_flipped) return 0;
        
        var _width = __PfGetDisplayWidthRaw();
        return (_width == 0)? 0 : ceil(0.67 * __PfNotchGetLeftRaw() * display_get_width() / _width);
    }
    else
    {
        return 0;
    }
}