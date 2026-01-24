// Feather disable all

function __PfNotchGetBottom()
{
    if (os_type == os_android)
    {
        return __PfNotchGetBottomRaw();
    }
    else if (os_type == os_ios)
    {
        if (display_get_orientation() != display_portrait_flipped) return 0;
        
        var _height = __PfGetDisplayHeightRaw();
        return (_height == 0)? 0 : ceil(0.67 * __PfNotchGetBottomRaw() * display_get_height() / _height);
    }
    else
    {
        return 0;
    }
}