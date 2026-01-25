// Feather disable all

function __PfNotchGetBottom()
{
    if (os_type == os_android)
    {
        return __PfNotchGetBottomRaw();
    }
    else if (os_type == os_ios)
    {
        return (display_get_orientation() != display_portrait_flipped)? 0 : ceil(PICTURE_FRAME_IOS_INSET_SCALE * __PfNotchGetBottomRaw());
    }
    else
    {
        return 0;
    }
}