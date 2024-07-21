// Feather disable all

function PfMouseY()
{
    static _system = __PfSystem();
    
    if (not _system.__mouseUpdated)
    {
        _system.__mouseUpdated = true;
        
        var _result = PfGuiToRoom(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0));
        _system.__mouseX = _result.x;
        _system.__mouseY = _result.y;
    }
    
    return _system.__mouseY;
}