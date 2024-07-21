// Feather disable all

#macro PICTURE_FRAME_VERSION  "3.0.0"
#macro PICTURE_FRAME_DATE     "2024-07-21"

__PfSystem();
function __PfSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    __PfTrace($"Welcome to PictureFrame by Juju Adams! This is version {PICTURE_FRAME_VERSION}, {PICTURE_FRAME_DATE}");
    
    _system = {};
    with(_system)
    {
        var _array = application_get_position();
        
        __resultStruct = {
            surfacePixelPerfect: gpu_get_tex_filter(),
            surfaceDrawX:        _array[0],
            surfaceDrawY:        _array[1],
            surfaceDrawWidth:    _array[2] - _array[0],
            surfaceDrawHeight:   _array[3] - _array[1],
        };
        
        __mouseUpdated = false;
        __mouseX = undefined;
        __mouseY = undefined;
        
        time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
        {
            __mouseUpdated = false;
        },
        [], -1));
    }
    
    return _system;
}