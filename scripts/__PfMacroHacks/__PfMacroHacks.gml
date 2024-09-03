// Feather disable all

#macro mouse_x                     __PfDeviceMouseX(0)
#macro mouse_y                     __PfDeviceMouseY(0)
#macro device_mouse_x              __PfDeviceMouseX
#macro device_mouse_y              __PfDeviceMouseY
#macro window_views_mouse_get_x    __PfWindowViewsMouseGetX
#macro window_views_mouse_get_y    __PfWindowViewsMouseGetY
#macro window_view_mouse_get_x     __PfWindowViewMouseGetX
#macro window_view_mouse_get_y     __PfWindowViewMouseGetY

#macro __PF_mouse_x                    window_views_mouse_get_x() //Using mouse_x here causes an infinite loop
#macro __PF_mouse_y                    window_views_mouse_get_y() //Using mouse_y here causes an infinite loop
#macro __PF_window_views_mouse_get_x   window_views_mouse_get_x
#macro __PF_window_views_mouse_get_y   window_views_mouse_get_y
#macro __PF_window_view_mouse_get_x    window_view_mouse_get_x
#macro __PF_window_view_mouse_get_y    window_view_mouse_get_y

function __PfDeviceMouseX(_device)
{
    if (not PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS)
    {
        return __PF_mouse_x;
    }
    else if ((_device == 0) || (os_type == os_windows)) //Can't use multi-touch on Windows
    {
        return PfMouseX();
    }
    else
    {
        return PfWindowToRoom(device_mouse_raw_x(_device), device_mouse_raw_y(_device)).x;
    }
}

function __PfDeviceMouseY(_device)
{
    if (not PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS)
    {
        return __PF_mouse_y;
    }
    else if ((_device == 0) || (os_type == os_windows)) //Can't use multi-touch on Windows
    {
        return PfMouseY();
    }
    else
    {
        return PfWindowToRoom(device_mouse_raw_x(_device), device_mouse_raw_y(_device)).y;
    }
}

function __PfWindowViewsMouseGetX()
{
    if (not PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS)
    {
        return __PF_window_views_mouse_get_x();
    }
    else
    {
        return PfMouseX();
    }
}

function __PfWindowViewsMouseGetY()
{
    if (not PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS)
    {
        return __PF_window_views_mouse_get_y();
    }
    else
    {
        return PfMouseY();
    }
}

function __PfWindowViewMouseGetX(_view)
{
    if (not PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS)
    {
        return __PF_window_view_mouse_get_x(_view);
    }
    else if (_view == 0)
    {
        return PfMouseX();
    }
    else
    {
        return __PF_window_view_mouse_get_x(_view);
    }
}

function __PfWindowViewMouseGetY(_view)
{
    if (not PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS)
    {
        return __PF_window_view_mouse_get_y(_view);
    }
    else if (_view == 0)
    {
        return PfMouseY();
    }
    else
    {
        return __PF_window_view_mouse_get_y(_view);
    }
}