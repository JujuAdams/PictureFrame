// Feather disable all

/// Returns the y-coordinate of the mouse in roomspace, after being corrected for all the weird and
/// wonderful things that PictureFrame does.
/// 
/// If PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS (which it is out of the box) then the native
/// GameMaker constant "mouse_x" will be mapped to this function. This means you shouldn't have to
/// change any code for mouse position detection to work automatically.

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