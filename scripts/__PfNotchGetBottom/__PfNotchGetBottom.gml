// Feather disable all

function __PfNotchGetBottom()
{
    if (os_type == os_android)
    {
        return __PfNotchGetBottomRaw();
    }
    else if (os_type == os_ios)
    {
        var _height = __PfGetDisplayHeightRaw();
        return (_height == 0)? 0 : __PfNotchGetBottomRaw() * display_get_height() / _height;
    }
    else
    {
        return 0;
    }
}