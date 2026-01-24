// Feather disable all

function __PfNotchGetTop()
{
    if (os_type == os_android)
    {
        return __PfNotchGetTopRaw();
    }
    else if (os_type == os_ios)
    {
        return (display_get_orientation() != display_portrait)? 0 : ceil(__PF_IOS_FUDGE_FACTOR * __PfNotchGetTopRaw());
    }
    else
    {
        return 0;
    }
}