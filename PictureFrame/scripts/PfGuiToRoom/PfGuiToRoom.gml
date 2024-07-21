// Feather disable all

/// @param x
/// @param y

function PfGuiToRoom(_x, _y)
{
    static _system = __PfSystem();
    
    static _result = {
        x: 0,
        y: 0,
    };
    
    with(_system.__resultStruct)
    {
        var _camera = (view_enabled && view_get_visible(0))? view_get_camera(0) : undefined;
        if (_camera != undefined)
        {
            var _viewX = camera_get_view_x(     _camera);
            var _viewY = camera_get_view_y(     _camera);
            var _viewW = camera_get_view_width( _camera);
            var _viewH = camera_get_view_height(_camera);
            var _viewA = camera_get_view_angle( _camera);
        }
        else
        {
            //Fall back on the room's dimensions
            var _viewX = 0;
            var _viewY = 0;
            var _viewW = room_width;
            var _viewH = room_height;
            var _viewA = 0;
        }
        
        //Reduce x/y to normalised values in GUI-space
        _x = (_x - surfaceDrawX) / surfaceDrawWidth;
        _y = (_y - surfaceDrawY) / surfaceDrawHeight;
        
        if (_viewA == 0) //Skip expensive rotation step if we can
        {
            //Expand room-space x/y from normalised values in the viewport
            _x = _viewW*_x + _viewX;
            _y = _viewH*_y + _viewY;
        }
        else
        {
            //Perform a rotation, eventually ending up with room-space coordinates as above
            _viewX += _viewW/2;
            _viewY += _viewH/2;
            
            var _sin = dsin(_viewA);
            var _cos = dcos(_viewA);
            
            var _x0 = _x*_viewW - _viewW/2;
            var _y0 = _y*_viewH - _viewH/2;
            _x = (_x0*_cos - _y0*_sin) + _viewX;
            _y = (_x0*_sin + _y0*_cos) + _viewY;
        }
        
        //Set values and return!
        _result.x = _x;
        _result.y = _y;
        
        return _result;
    }
    
    __PfError("Please call PfApply() before PfGuiToRoom()");
}
