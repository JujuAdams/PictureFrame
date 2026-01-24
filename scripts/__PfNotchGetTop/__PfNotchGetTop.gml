// Feather disable all

function __PfNotchGetTop()
{
    if (os_type == os_android)
    {
        return __PfNotchGetTopRaw();
    }
    else if (os_type == os_ios)
    {
        if (display_get_orientation() != display_portrait) return 0;
        
        var _height = __PfGetDisplayHeightRaw();
        return (_height == 0)? 0 : ceil(0.67 * __PfNotchGetTopRaw() * display_get_height() / _height);
    }
    else
    {
        return 0;
    }
}