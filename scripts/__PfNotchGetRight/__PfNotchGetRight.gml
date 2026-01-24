// Feather disable all

function __PfNotchGetRight()
{
    if (os_type == os_android)
    {
        return __PfNotchGetRightRaw();
    }
    else if (os_type == os_ios)
    {
        var _width = __PfGetDisplayWidthRaw();
        return (_width == 0)? 0 : __PfNotchGetRightRaw() * display_get_width() / __PfGetDisplayWidthRaw();
    }
    else
    {
        return 0;
    }
}