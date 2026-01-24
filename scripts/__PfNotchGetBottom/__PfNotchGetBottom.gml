// Feather disable all

function __PfNotchGetBottom()
{
    if (os_type == os_android)
    {
        return __PfNotchGetBottomRaw();
    }
    else if (os_type == os_ios)
    {
        return (display_get_orientation() != display_portrait_flipped)? 0 : ceil(__PF_IOS_FUDGE_FACTOR * __PfNotchGetBottomRaw());
    }
    else
    {
        return 0;
    }
}