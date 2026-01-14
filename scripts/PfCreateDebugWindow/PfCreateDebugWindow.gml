// Feather disable all

/// @param [configStruct=none]
/// @param [resultStruct=applied]

function PfCreateDebugWindow(_configStruct = undefined, _resultStruct = PfGetApplied())
{
    static _system = __PfSystem();
    
    static _resultFocus = undefined;
    static _configFocus = undefined;
    
    if (_resultFocus != _resultStruct)
    {
        _resultFocus = _resultStruct;
        _system.__debugResult = variable_clone(_resultStruct);
    }
    
    if (_configFocus != _configStruct)
    {
        _configFocus = _configStruct;
        _system.__debugConfig = variable_clone(_configStruct);
    }
    
    var _debugResult = _system.__debugResult;
    var _debugConfig = _system.__debugConfig;
    
    dbg_view("PictureFrame", true);
    
    dbg_section("Result Struct", true);
    
    dbg_text($"cameraWidth    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "cameraWidth"));
    dbg_text($"cameraHeight   = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "cameraHeight"));
    dbg_text($"cameraOverscan = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "cameraOverscan"));
    dbg_text($"viewWidth      = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "viewWidth"));
    dbg_text($"viewHeight     = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "viewHeight"));
    dbg_text($"viewScale      = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "viewScale"));
    dbg_text($"viewOverscan   = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "viewOverscan"));
    dbg_text_separator("");
    dbg_text($"fullscreen   = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "fullscreen"));
    dbg_text($"windowWidth  = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "windowWidth"));
    dbg_text($"windowHeight = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "windowHeight"));
    dbg_text($"guiWidth     = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "guiWidth"));
    dbg_text($"guiHeight    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "guiHeight"));
    dbg_text_separator("");
    dbg_text($"surfacePixelPerfect   = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePixelPerfect"));
    dbg_text($"surfacePostDrawScale  = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePostDrawScale"));
    dbg_text($"surfacePostDrawX      = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePostDrawX"));
    dbg_text($"surfacePostDrawY      = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePostDrawY"));
    dbg_text($"surfacePostDrawWidth  = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePostDrawWidth"));
    dbg_text($"surfacePostDrawHeight = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfacePostDrawHeight"));
    dbg_text($"surfaceGuiX           = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfaceGuiX"));
    dbg_text($"surfaceGuiY           = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfaceGuiY"));
    dbg_text($"surfaceGuiWidth       = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfaceGuiWidth"));
    dbg_text($"surfaceGuiHeight      = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "surfaceGuiHeight"));
    dbg_text_separator("");
    dbg_text($"marginsVisible = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginsVisible"));
    dbg_text($"marginGuiX1    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiX1"));
    dbg_text($"marginGuiY1    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiY1"));
    dbg_text($"marginGuiX2    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiX2"));
    dbg_text($"marginGuiY2    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiY2"));
    dbg_text($"marginGuiX3    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiX3"));
    dbg_text($"marginGuiY3    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiY3"));
    dbg_text($"marginGuiX4    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiX4"));
    dbg_text($"marginGuiY4    = "); dbg_same_line(); dbg_text(ref_create(_debugResult, "marginGuiY4"));
    dbg_text("");
    
    dbg_section("Config Struct", true);
    
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
        
        dbg_text_input(ref_create(_debugConfig, "cameraTargetWidth"   ), "cameraTargetWidth",   "f");
        dbg_text_input(ref_create(_debugConfig, "cameraTargetHeight"  ), "cameraTargetHeight",  "f");
        dbg_text_input(ref_create(_debugConfig, "cameraMinWidth"      ), "cameraMinWidth",      "f");
        dbg_text_input(ref_create(_debugConfig, "cameraMinHeight"     ), "cameraMinHeight",     "f");
        dbg_text_input(ref_create(_debugConfig, "cameraMaxWidth"      ), "cameraMaxWidth",      "f");
        dbg_text_input(ref_create(_debugConfig, "cameraMaxHeight"     ), "cameraMaxHeight",     "f");
        dbg_text_input(ref_create(_debugConfig, "cameraOverscan"      ), "cameraOverscan",      "i");
        dbg_text_separator("");
        dbg_text_input(ref_create(_debugConfig, "viewMaxScale"        ), "viewMaxScale",        "f");
        dbg_checkbox(  ref_create(_debugConfig, "viewPixelPerfect"    ), "viewPixelPerfect"        );
        dbg_text_separator("");
        dbg_checkbox(  ref_create(_debugConfig, "fullscreen"          ), "fullscreen"              );
        dbg_text_input(ref_create(_debugConfig, "windowWidth"         ), "windowWidth",         "i");
        dbg_text_input(ref_create(_debugConfig, "windowHeight"        ), "windowHeight",        "i");
        dbg_text_separator("");
        dbg_checkbox(  ref_create(_debugConfig, "guiStretchOverWindow"), "guiStretchOverWindow"    );
        dbg_text_input(ref_create(_debugConfig, "guiTargetWidth"      ), "guiTargetWidth",      "f");
        dbg_text_input(ref_create(_debugConfig, "guiTargetHeight"     ), "guiTargetHeight",     "f");
        dbg_checkbox(  ref_create(_debugConfig, "surfacePixelPerfect" ), "surfacePixelPerfect"     );
        dbg_text_input(ref_create(_debugConfig, "windowOverscanScale" ), "windowOverscanScale", "f");
    }
}