// Feather disable all

function __PfNotchGetLeft()
{
    if (os_type == os_android)
    {
        return __PfNotchGetLeftRaw();
    }
    else if (os_type == os_ios)
    {
        return (display_get_orientation() != display_landscape_flipped)? 0 : ceil(PICTURE_FRAME_IOS_INSET_SCALE * __PfNotchGetLeftRaw());
    }
    else
    {
        return 0;
    }
}