// Feather disable all

#macro __PF_IOS_FUDGE_FACTOR  0.66

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
            static _orientation         = undefined;
            static _displayMarginLeft   = undefined;
            static _displayMarginTop    = undefined;
            static _displayMarginRight  = undefined;
            static _displayMarginBottom = undefined;
            
            __mouseUpdated = false;
            __windowStateChanged = false;
            
            //Report a change in orientation as a new window state change
            if (_orientation != display_get_orientation())
            {
                if (_orientation != undefined) __windowStateChanged = true;
                _orientation = display_get_orientation();
            }
            
            //Change in notches also triggers a window state change
            if (PICTURE_FRAME_ON_MOBILE)
            {
                if (_displayMarginLeft != __PfNotchGetLeft())
                {
                    if (_displayMarginLeft != undefined) __windowStateChanged = true;
                    _displayMarginLeft = __PfNotchGetLeft();
                }
                
                if (_displayMarginTop != __PfNotchGetTop())
                {
                    if (_displayMarginTop != undefined) __windowStateChanged = true;
                    _displayMarginTop = __PfNotchGetTop();
                }
                
                if (_displayMarginRight != __PfNotchGetRight())
                {
                    if (_displayMarginRight != undefined) __windowStateChanged = true;
                    _displayMarginRight = __PfNotchGetRight();
                }
                
                if (_displayMarginBottom != __PfNotchGetBottom())
                {
                    if (_displayMarginBottom != undefined) __windowStateChanged = true;
                    _displayMarginBottom = __PfNotchGetBottom();
                }
            }
            
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
        },
        [], -1));
    }
    
    return _system;
}