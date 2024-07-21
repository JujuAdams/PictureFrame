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
        //var _array = application_get_position();
        //
        //var _scaleX = display_get_gui_width() / window_get_width();
        //var _scaleY = display_get_gui_height() / window_get_height();
        
        __noAppSurfDrawDisable = true;
        PfApply(PfCalculate(PfConfigGeneral()));
        __noAppSurfDrawDisable = false;
        
        //__resultStruct = {
        //    surfacePixelPerfect:   gpu_get_tex_filter(),
        //    surfacePostDrawX:      _array[0],
        //    surfacePostDrawY:      _array[1],
        //    surfacePostDrawWidth:  _array[2] - _array[0],
        //    surfacePostDrawHeight: _array[3] - _array[1],
        //    surfaceGuiX:           _scaleX*_array[0],
        //    surfaceGuiY:           _scaleY*_array[1],
        //    surfaceGuiWidth:       _scaleX*(_array[2] - _array[0]),
        //    surfaceGuiHeight:      _scaleY*(_array[3] - _array[1]),
        //};
        
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