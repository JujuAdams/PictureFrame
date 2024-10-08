// Feather disable all

__PfSystem();
function __PfSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    __PfTrace($"Welcome to PictureFrame by Juju Adams! This is version {PICTURE_FRAME_VERSION}, {PICTURE_FRAME_DATE}");
    
    _system = {};
    with(_system)
    {
        __noAppSurfDrawDisable = true;
        PfApply(PfConfigGeneral());
        __noAppSurfDrawDisable = false;
        
        __mouseUpdated = false;
        __mouseX = undefined;
        __mouseY = undefined;
        
        __windowWidth  = window_get_width();
        __windowHeight = window_get_height();
        __windowSizeChanged = false;
        
        time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
        {
            __mouseUpdated = false;
            
            if (((__windowWidth != window_get_width()) || (__windowHeight != window_get_height()))
            && (window_get_width() != 0)
            && (window_get_height() != 0))
            {
                __windowWidth  = window_get_width();
                __windowHeight = window_get_height();
                
                __windowSizeChanged = true;
            }
            else
            {
                __windowSizeChanged = false;
            }
        },
        [], -1));
    }
    
    return _system;
}