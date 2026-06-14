// Feather disable all

function __PfNotchGetRight()
{
    if (os_type == os_android)
    {
        return __PfNotchGetRightRaw();
    }
    else if (os_type == os_ios)
    {
        return (display_get_orientation() != display_landscape)? 0 : ceil(PICTURE_FRAME_IOS_INSET_SCALE * __PfNotchGetRightRaw());
    }
    else
    {
        return 0;
    }
}