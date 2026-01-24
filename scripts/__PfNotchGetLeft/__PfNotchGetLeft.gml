// Feather disable all

function __PfNotchGetLeft()
{
    if (os_type == os_android)
    {
        return __PfNotchGetLeftRaw();
    }
    else if (os_type == os_ios)
    {
        var _width = __PfGetDisplayWidthRaw();
        return (_width == 0)? 0 : __PfNotchGetLeftRaw() * display_get_width() / _width;
    }
    else
    {
        return 0;
    }
}