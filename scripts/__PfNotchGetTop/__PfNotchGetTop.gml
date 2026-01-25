// Feather disable all

function __PfNotchGetTop()
{
    if (os_type == os_android)
    {
        return __PfNotchGetTopRaw();
    }
    else if (os_type == os_ios)
    {
        return (display_get_orientation() != display_portrait)? 0 : ceil(PICTURE_FRAME_IOS_INSET_SCALE * __PfNotchGetTopRaw());
    }
    else
    {
        return 0;
    }
}