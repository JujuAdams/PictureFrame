// Feather disable all

/// Returns the y-coordinate of the mouse in roomspace, after being corrected for all the weird and
/// wonderful things that PictureFrame does.

function PfMouseY()
{
    static _system = __PfSystem();
    
    if (not _system.__mouseUpdated)
    {
        _system.__mouseUpdated = true;
        
        var _result = PfWindowToRoom(window_mouse_get_x(), window_mouse_get_y());
        _system.__mouseX = _result.x;
        _system.__mouseY = _result.y;
    }
    
    return _system.__mouseY;
}