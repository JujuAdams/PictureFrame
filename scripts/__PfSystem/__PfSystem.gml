// Feather disable all

#macro __PF_ON_DESKTOP  ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))

__PfSystem();

function __PfSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
    
    __PfTrace($"Welcome to PictureFrame by Juju Adams! This is version {PICTURE_FRAME_VERSION}, {PICTURE_FRAME_DATE}");
    
    _system = {};
    with(_system)
    {
        __configStruct = undefined;
        __layoutStruct = undefined;
        
        __noAppSurfDrawDisable = true;
        PfApply(PfConfigGeneral());
        __noAppSurfDrawDisable = false;
        
        __mouseUpdated = false;
        __mouseX = undefined;
        __mouseY = undefined;
        
        __fullscreen   = window_get_fullscreen();
        __windowWidth  = window_get_width();
        __windowHeight = window_get_height();
        __windowStateChanged = false;
        
        __debugState  = {};
        __debugLayout = {};
        
        time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
        {
            __mouseUpdated = false;
            
            if (__fullscreen != window_get_fullscreen())
            {
                __fullscreen = window_get_fullscreen();
                
                __windowStateChanged = true;
            }
            else if (((__windowWidth != window_get_width()) || (__windowHeight != window_get_height()))
            && (window_get_width() != 0)
            && (window_get_height() != 0))
            {
                __windowWidth  = window_get_width();
                __windowHeight = window_get_height();
                
                __windowStateChanged = true;
            }
            else
            {
                __windowStateChanged = false;
            }
        },
        [], -1));
    }
    
    return _system;
}