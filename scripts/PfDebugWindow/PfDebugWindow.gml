// Feather disable all

/// Creates a debug view for PictureFrame using GameMaker's native `dbg_*` functions. You should
/// call this function once to create the view. If you want to change which configuration struct is
/// being targeted then call the function using the new struct reference.
/// 
/// If you provide a configuration struct when calling `PfDebugWindow()` then you can edit that
/// struct in the debug view. You can execute `PfApply()` struct to the render state by clicking
/// the appropriate button.
/// 
/// Additionally, the debug view shows the current window state as reported by GameMaker and the
/// layout struct that was generated the last time `PfApply()` was called.
/// 
/// @param [configStruct=none]

function PfDebugWindow(_configStruct = undefined)
{
    static _system = __PfSystem();
    
    static _once = (function()
    {
        time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function()
        {
            static _system = __PfSystem();
            
            //TODO - Don't think we need this copying behaviour
            
            var _currentLayout = _system.__layoutStruct;
            var _debugLayout   = _system.__debugLayout;
            
            if (_currentLayout == undefined)
            {
                //Clear out the debug layout struct
                var _namesArray = struct_get_names(_debugLayout);
                var _i = 0;
                repeat(array_length(_namesArray))
                {
                    struct_remove(_debugLayout, _namesArray[_i]);
                    ++_i;
                }
            }
            else
            {
                //Copy content from the current layout to the debug struct
                var _namesArray = struct_get_names(_currentLayout);
                var _i = 0;
                repeat(array_length(_namesArray))
                {
                    var _name = _namesArray[_i];
                    _debugLayout[$ _name] = _currentLayout[$ _name];
                    ++_i;
                }
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
                
                appSurfWidth  = surface_get_width(application_surface);
                appSurfHeight = surface_get_height(application_surface);
                
                guiWidth  = display_get_gui_width();
                guiHeight = display_get_gui_height();
                
                windowX          = window_get_x();
                windowY          = window_get_y();
                windowWidth      = window_get_width();
                windowHeight     = window_get_height();
                windowFullscreen = window_get_fullscreen();
                windowShowBorder = window_get_showborder();
                
                displayWidth     = display_get_width();
                displayHeight    = display_get_height();
                displayFrequency = display_get_frequency();
                displayDPI       = display_get_dpi_x();
                
            }
        },
        [], -1));
    })();
    
    var _debugState  = _system.__debugState;
    var _debugLayout = _system.__debugLayout;
    
    dbg_view("PictureFrame", true);
    
    dbg_section("Config Struct", false);
    
    dbg_text("");
    
    if (_configStruct == undefined)
    {
        dbg_text("No config struct provided");
    }
    else
    {
        dbg_button("Apply config", method({
            __configStruct: _configStruct,
        },
        function()
        {
            PfConfigSetWindowVars(__configStruct);
            PfApply(__configStruct);
        }));
        
        dbg_same_line();
        
        dbg_button("Apply + window resize", method({
            __configStruct: _configStruct,
        },
        function()
        {
            PfApply(__configStruct, true);
        }));
        
        dbg_text("");
        dbg_text_input(ref_create(_configStruct, "cameraTargetWidth"    ), ".cameraTargetWidth",   "f");
        dbg_text_input(ref_create(_configStruct, "cameraTargetHeight"   ), ".cameraTargetHeight",  "f");
        dbg_text_input(ref_create(_configStruct, "cameraMinWidth"       ), ".cameraMinWidth",      "f");
        dbg_text_input(ref_create(_configStruct, "cameraMinHeight"      ), ".cameraMinHeight",     "f");
        dbg_text_input(ref_create(_configStruct, "cameraMaxWidth"       ), ".cameraMaxWidth",      "f");
        dbg_text_input(ref_create(_configStruct, "cameraMaxHeight"      ), ".cameraMaxHeight",     "f");
        dbg_text_input(ref_create(_configStruct, "cameraOverscan"       ), ".cameraOverscan",      "i");
        dbg_text_separator("");
        dbg_text_input(ref_create(_configStruct, "viewMaxScale"         ), ".viewMaxScale",        "f");
        dbg_checkbox(  ref_create(_configStruct, "viewPixelPerfect"     ), ".viewPixelPerfect"        );
        dbg_text_separator("");
        dbg_checkbox(  ref_create(_configStruct, "fullscreen"           ), ".fullscreen"              );
        dbg_text_input(ref_create(_configStruct, "windowWidth"          ), ".windowWidth",         "i");
        dbg_text_input(ref_create(_configStruct, "windowHeight"         ), ".windowHeight",        "i");
        dbg_checkbox(  ref_create(_configStruct, "trimBlackBars"        ), ".trimBlackBars"           );
        dbg_text_separator("");
        dbg_checkbox(  ref_create(_configStruct, "guiWindowStretch"     ), ".guiWindowStretch"        );
        dbg_text_input(ref_create(_configStruct, "guiMode"              ), ".guiMode [0 -> 6]",    "i");
        dbg_text_input(ref_create(_configStruct, "guiTargetWidth"       ), ".guiTargetWidth",      "i");
        dbg_text_input(ref_create(_configStruct, "guiTargetHeight"      ), ".guiTargetHeight",     "i");
        dbg_text_input(ref_create(_configStruct, "guiScale"             ), ".guiScale",            "f");
        dbg_text_separator("");
        dbg_checkbox(  ref_create(_configStruct, "surfacePixelPerfect"  ), ".surfacePixelPerfect"     );
        dbg_text_input(ref_create(_configStruct, "windowOverscanScale"  ), ".windowOverscanScale", "f");
    }
    
    dbg_text("");
    dbg_section("GameMaker State", false);
    
    dbg_text("");
    dbg_button("Toggle fullscreen", function()
    {
        window_set_fullscreen(not window_get_fullscreen());
    });
    
    dbg_text("");
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
    dbg_text($"App surf width  = "); dbg_same_line(); dbg_text(ref_create(_debugState, "appSurfWidth"));
    dbg_text($"App surf height = "); dbg_same_line(); dbg_text(ref_create(_debugState, "appSurfHeight"));
    dbg_text_separator("");
    dbg_text($"(GUI X     = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfaceGuiX")); dbg_same_line(); dbg_text(")");
    dbg_text($"(GUI Y     = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfaceGuiY")); dbg_same_line(); dbg_text(")");
    dbg_text($"GUI width  = "); dbg_same_line(); dbg_text(ref_create(_debugState,  "guiWidth"));
    dbg_text($"GUI height = "); dbg_same_line(); dbg_text(ref_create(_debugState,  "guiHeight"));
    dbg_text_separator("");
    dbg_text($"Window X      = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowX"));
    dbg_text($"Window Y      = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowY"));
    dbg_text($"Window width  = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowWidth"));
    dbg_text($"Window height = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowHeight"));
    dbg_text($"Fullscreen    = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowFullscreen"));
    dbg_text($"Show Border   = "); dbg_same_line(); dbg_text(ref_create(_debugState, "windowShowBorder"));
    dbg_text_separator("");
    dbg_text($"Display width     = "); dbg_same_line(); dbg_text(ref_create(_debugState, "displayWidth"));
    dbg_text($"Display height    = "); dbg_same_line(); dbg_text(ref_create(_debugState, "displayHeight"));
    dbg_text($"Display frequency = "); dbg_same_line(); dbg_text(ref_create(_debugState, "displayFrequency"));
    dbg_text($"Display DPI       = "); dbg_same_line(); dbg_text(ref_create(_debugState, "displayDPI"));
    
    dbg_text("");
    dbg_section("Layout Struct", false);
    
    dbg_text("");
    dbg_text($".cameraWidth    = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "cameraWidth"));
    dbg_text($".cameraHeight   = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "cameraHeight"));
    dbg_text($".cameraOverscan = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "cameraOverscan"));
    dbg_text($".viewWidth      = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "viewWidth"));
    dbg_text($".viewHeight     = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "viewHeight"));
    dbg_text($".viewScale      = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "viewScale"));
    dbg_text($".viewOverscan   = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "viewOverscan"));
    dbg_text_separator("");
    dbg_text($".fullscreen   = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "fullscreen"));
    dbg_text($".windowWidth  = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "windowWidth"));
    dbg_text($".windowHeight = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "windowHeight"));
    dbg_text($".guiWidth     = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "guiWidth"));
    dbg_text($".guiHeight    = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "guiHeight"));
    dbg_text_separator("");
    dbg_text($".surfacePixelPerfect   = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfacePixelPerfect"));
    dbg_text($".surfacePostDrawScale  = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfacePostDrawScale"));
    dbg_text($".surfacePostDrawX      = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfacePostDrawX"));
    dbg_text($".surfacePostDrawY      = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfacePostDrawY"));
    dbg_text($".surfacePostDrawWidth  = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfacePostDrawWidth"));
    dbg_text($".surfacePostDrawHeight = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfacePostDrawHeight"));
    dbg_text($".surfaceGuiX           = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfaceGuiX"));
    dbg_text($".surfaceGuiY           = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfaceGuiY"));
    dbg_text($".surfaceGuiWidth       = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfaceGuiWidth"));
    dbg_text($".surfaceGuiHeight      = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "surfaceGuiHeight"));
    dbg_text_separator("");
    dbg_text($".marginsVisible = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "marginsVisible"));
    dbg_text($".marginWestX1    = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "marginWestX1"));
    dbg_text($".marginNorthY1    = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "marginNorthY1"));
    dbg_text($".marginWestX2    = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "marginWestX2"));
    dbg_text($".marginNorthY2    = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "marginNorthY2"));
    dbg_text($".marginEastX1    = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "marginEastX1"));
    dbg_text($".marginSouthY1    = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "marginSouthY1"));
    dbg_text($".marginEastX2    = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "marginEastX2"));
    dbg_text($".marginSouthY2    = "); dbg_same_line(); dbg_text(ref_create(_debugLayout, "marginSouthY2"));
    dbg_text("");
}