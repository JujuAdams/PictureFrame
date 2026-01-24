// Feather disable all

function __PfNotchGetRight()
{
    if (os_type == os_android)
    {
        return __PfNotchGetRightRaw();
    }
    else if (os_type == os_ios)
    {
        return (display_get_orientation() != display_landscape)? 0 : ceil(__PF_IOS_FUDGE_FACTOR * __PfNotchGetRightRaw());
    }
    else
    {
        return 0;
    }
}