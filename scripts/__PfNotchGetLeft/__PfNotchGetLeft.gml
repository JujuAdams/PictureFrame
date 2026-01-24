// Feather disable all

function __PfNotchGetLeft()
{
    if (os_type == os_android)
    {
        return __PfNotchGetLeftRaw();
    }
    else if (os_type == os_ios)
    {
        return (display_get_orientation() != display_landscape_flipped)? 0 : ceil(__PF_IOS_FUDGE_FACTOR * __PfNotchGetLeftRaw());
    }
    else
    {
        return 0;
    }
}