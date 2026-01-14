// Feather disable all

/// Creates a debug view using GameMaker's native `dbg_*` functions.
/// 
/// @param [configStruct=none]

function PfDebugWindow(_configStruct = undefined)
{
    static _system = __PfSystem();
    
    static _configFocus = undefined;
    
    static _once = (function()
    {
        time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
        {
            static _system = __PfSystem();
            
            var _currentResult = _system.__resultStruct;
            var _debugResult   = _system.__debugResult;
            
            var _namesArray = struct_get_names(_currentResult);
            var _i = 0;
            repeat(array_length(_namesArray))
            {
                var _name = _namesArray[_i];
                _debugResult[$ _name] = _currentResult[$ _name];
                ++_i;
            }
            
            with(_system.__debugState)
            {
                var _view   = 0;
                var _camera = view_get_camera(_view);
                
                camera       = _camera;
                cameraX      = camera_get_view_x(_camera);
                cameraY      = camera_get_view_y(_camera);
                cameraWidth  = camera_get_view_width(_camera);
                cameraHeight = camera_get_view_height(_camera);
                cameraAngle  = camera_get_view_angle(_camera);
                
                viewX       = view_get_xport(_view);
                viewY       = view_get_yport(_view);
                viewWidth   = view_get_wport(_view);
                viewHeight  = view_get_hport(_view);
                viewEnabled = view_enabled;
                viewVisible = view_get_visible(_view);
                
                windowX          = window_get_x();
                windowY          = window_get_y();
                windowWidth      = window_get_width();
                windowHeight     = window_get_height();
                windowFullscreen = window_get_fullscreen();
                windowShowBorder = window_get_showborder();
            }
        },
        [], -1));
    })();
    
    if (_configFocus != _configStruct)
    {
        _configFocus = _configStruct;
        _system.__debugConfig = variable_clone(_configStruct);
    }
    
    var _debugState  = _system.__debugState;
    var _debugResult = _system.__debugResult;
    var _debugConfig = _system.__debugConfig;
    
    dbg_view("PictureFrame", true);
    
    dbg_section("GameMaker State", true);
    
    dbg_text($"Camera ID     = "); dbg_same_line(); dbg_text(ref_create(_debugState, "camera"));
    dbg_text($"Camera X      = "); dbg_same_line(); dbg_text(ref_create(_debugState, "cameraX"));
    dbg_text($"Camera Y      = "); dbg_same_line(); dbg_text(ref_create(_debugState, "cameraY"));
    dbg_text($"Camera width  = "); dbg_same_line(); dbg_text(ref_create(_debugState, "cameraWidth"));
    dbg_text($"Camera height = "); dbg_same_line(); dbg_text(ref_create(_debugState, "cameraHeight"));
    dbg_text($"Camera angle  = "); dbg_same_line(); dbg_text(ref_create(_debugState, "cameraAngle"));
    dbg_text_separator("");
    dbg_text($"View X        = "); dbg_same_line(); dbg_text(ref_create(_debugState, "viewX"));
    dbg_text($"View Y        = "); dbg_same_line(); dbg_text(ref_create(_debugState, "viewY"));
    dbg_text($"View width    = "); dbg_same_line(); dbg_text(ref_create(_debugState, "viewWidth"));
    dbg_text($"View height   = "); dbg_same_line(); dbg_text(ref_create(_debugState, "viewHeight"));
    dbg_text($"View visible  = "); dbg_same_line(); dbg_text(ref_create(_debugState, "viewVisible"));
    dbg_text($"Views enabled = "); dbg_same_line(); dbg_text(ref_create(_debugState, "viewEnabled"));
    dbg_text_separator("");
    dbg_text($"Window X      = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowX"));
    dbg_text($"Window Y      = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowY"));
    dbg_text($"Window width  = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowWidth"));
    dbg_text($"Window height = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowHeight"));
    dbg_text($"Fullscreen    = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowFullscreen"));
    dbg_text($"Show Border   = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowShowBorder"));
    dbg_text("");
    
    dbg_section("Result Struct", true);
    
    dbg_text($".cameraWidth    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "cameraWidth"));
    dbg_text($".cameraHeight   = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "cameraHeight"));
    dbg_text($".cameraOverscan = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "cameraOverscan"));
    dbg_text($".viewWidth      = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "viewWidth"));
    dbg_text($".viewHeight     = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "viewHeight"));
    dbg_text($".viewScale      = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "viewScale"));
    dbg_text($".viewOverscan   = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "viewOverscan"));
    dbg_text_separator("");
    dbg_text($".fullscreen   = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "fullscreen"));
    dbg_text($".windowWidth  = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "windowWidth"));
    dbg_text($".windowHeight = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "windowHeight"));
    dbg_text($".guiWidth     = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "guiWidth"));
    dbg_text($".guiHeight    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "guiHeight"));
    dbg_text_separator("");
    dbg_text($".surfacePixelPerfect   = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePixelPerfect"));
    dbg_text($".surfacePostDrawScale  = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePostDrawScale"));
    dbg_text($".surfacePostDrawX      = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePostDrawX"));
    dbg_text($".surfacePostDrawY      = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePostDrawY"));
    dbg_text($".surfacePostDrawWidth  = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePostDrawWidth"));
    dbg_text($".surfacePostDrawHeight = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePostDrawHeight"));
    dbg_text($".surfaceGuiX           = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfaceGuiX"));
    dbg_text($".surfaceGuiY           = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfaceGuiY"));
    dbg_text($".surfaceGuiWidth       = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfaceGuiWidth"));
    dbg_text($".surfaceGuiHeight      = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfaceGuiHeight"));
    dbg_text_separator("");
    dbg_text($".marginsVisible = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginsVisible"));
    dbg_text($".marginGuiX1    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiX1"));
    dbg_text($".marginGuiY1    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiY1"));
    dbg_text($".marginGuiX2    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiX2"));
    dbg_text($".marginGuiY2    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiY2"));
    dbg_text($".marginGuiX3    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiX3"));
    dbg_text($".marginGuiY3    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiY3"));
    dbg_text($".marginGuiX4    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiX4"));
    dbg_text($".marginGuiY4    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiY4"));
    dbg_text("");
    
    dbg_section("Config Struct", true);
    
    dbg_text("");
    
    if (_configStruct == undefined)
    {
        dbg_text("No config struct provided");
    }
    else
    {
        dbg_button("Apply config struct", function()
        {
            static _system = __PfSystem();
            PfApply(_system.__debugConfig);
        });
        
        dbg_text_input(ref_create(_debugConfig, "cameraTargetWidth"   ), ".cameraTargetWidth",   "f");
        dbg_text_input(ref_create(_debugConfig, "cameraTargetHeight"  ), ".cameraTargetHeight",  "f");
        dbg_text_input(ref_create(_debugConfig, "cameraMinWidth"      ), ".cameraMinWidth",      "f");
        dbg_text_input(ref_create(_debugConfig, "cameraMinHeight"     ), ".cameraMinHeight",     "f");
        dbg_text_input(ref_create(_debugConfig, "cameraMaxWidth"      ), ".cameraMaxWidth",      "f");
        dbg_text_input(ref_create(_debugConfig, "cameraMaxHeight"     ), ".cameraMaxHeight",     "f");
        dbg_text_input(ref_create(_debugConfig, "cameraOverscan"      ), ".cameraOverscan",      "i");
        dbg_text_separator("");
        dbg_text_input(ref_create(_debugConfig, "viewMaxScale"        ), ".viewMaxScale",        "f");
        dbg_checkbox(  ref_create(_debugConfig, "viewPixelPerfect"    ), ".viewPixelPerfect"        );
        dbg_text_separator("");
        dbg_checkbox(  ref_create(_debugConfig, "fullscreen"          ), ".fullscreen"              );
        dbg_text_input(ref_create(_debugConfig, "windowWidth"         ), ".windowWidth",         "i");
        dbg_text_input(ref_create(_debugConfig, "windowHeight"        ), ".windowHeight",        "i");
        dbg_text_separator("");
        dbg_checkbox(  ref_create(_debugConfig, "guiStretchOverWindow"), ".guiStretchOverWindow"    );
        dbg_text_input(ref_create(_debugConfig, "guiTargetWidth"      ), ".guiTargetWidth",      "f");
        dbg_text_input(ref_create(_debugConfig, "guiTargetHeight"     ), ".guiTargetHeight",     "f");
        dbg_checkbox(  ref_create(_debugConfig, "surfacePixelPerfect" ), ".surfacePixelPerfect"     );
        dbg_text_input(ref_create(_debugConfig, "windowOverscanScale" ), ".windowOverscanScale", "f");
    }
}