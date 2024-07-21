// Feather disable all

#macro mouse_x                     PfMouseX()
#macro mouse_y                     PfMouseY()
#macro window_views_mouse_get_x    PfMouseX
#macro window_views_mouse_get_y    PfMouseY
#macro device_mouse_x              __PfDeviceMouseX
#macro device_mouse_y              __PfDeviceMouseY
#macro window_view_mouse_get_x     __PfWindowViewMouseGetX
#macro window_view_mouse_get_y     __PfWindowViewMouseGetY
#macro __window_view_mouse_get_x   window_view_mouse_get_x
#macro __window_view_mouse_get_y   window_view_mouse_get_y

function __PfDeviceMouseX(_device)
{
    if (_device == 0)
    {
        return PfMouseX();
    }
    else
    {
        return PfGuiToRoom(device_mouse_x_to_gui(_device), device_mouse_y_to_gui(_device)).x;
    }
}

function __PfDeviceMouseY(_device)
{
    return PfGuiToRoom(device_mouse_x_to_gui(_device), device_mouse_y_to_gui(_device)).y;
}

function __PfWindowViewMouseGetX(_view)
{
    if (_view == 0)
    {
        return PfMouseX();
    }
    else
    {
        return __window_view_mouse_get_x(_view);
    }
}

function __PfWindowViewMouseGetY(_view)
{
    if (_view == 0)
    {
        return PfMouseY();
    }
    else
    {
        return __window_view_mouse_get_y(_view);
    }
}