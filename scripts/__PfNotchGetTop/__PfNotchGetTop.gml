// Feather disable all

function __PfNotchGetTop()
{
    if (os_type == os_android)
    {
        return __PfNotchGetTopRaw();
    }
    else if (os_type == os_ios)
    {
        var _height = __PfGetDisplayHeightRaw();
        return (_height == 0)? 0 : __PfNotchGetTopRaw() * display_get_height() / _height;
    }
    else
    {
        return 0;
    }
}