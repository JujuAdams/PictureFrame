draw_set_font(fntDefault);

if (mode == 1)
{
    var _bottom = funcTextbox(3, 3, $"PictureFrame {PICTURE_FRAME_VERSION}, {PICTURE_FRAME_DATE}\nPress [left] and [right] to change page");
    var _bottom = funcTextbox(3, _bottom+6, "Layout struct");
    
    var _layoutStruct = PfGetAppliedLayoutStruct();
    
    var _string = "";
    _string += $"surfacePixelPerfect = {_layoutStruct.surfacePixelPerfect}\n";
    _string += $"surfacePostDrawScale = {_layoutStruct.surfacePostDrawScale}\n";
    _string += $"surfacePostDrawX = {_layoutStruct.surfacePostDrawX}\n";
    _string += $"surfacePostDrawY = {_layoutStruct.surfacePostDrawY}\n";
    _string += $"surfacePostDrawWidth = {_layoutStruct.surfacePostDrawWidth}\n";
    _string += $"surfacePostDrawHeight = {_layoutStruct.surfacePostDrawHeight}\n";
    _string += $"surfaceGuiX = {_layoutStruct.surfaceGuiX}\n";
    _string += $"surfaceGuiY = {_layoutStruct.surfaceGuiY}\n";
    _string += $"surfaceGuiWidth = {_layoutStruct.surfaceGuiWidth}\n";
    _string += $"surfaceGuiHeight = {_layoutStruct.surfaceGuiHeight}\n";
    funcTextbox(105, _bottom+6, _string);
    
    var _string = "";
    _string += $"marginsVisible = {_layoutStruct.marginsVisible}\n";
    _string += $"marginWestX1 = {_layoutStruct.marginWestX1}\n";
    _string += $"marginWestX2 = {_layoutStruct.marginWestX2}\n";
    _string += $"marginEastX1 = {_layoutStruct.marginEastX1}\n";
    _string += $"marginEastX2 = {_layoutStruct.marginEastX2}\n";
    _string += $"marginNorthY1 = {_layoutStruct.marginNorthY1}\n";
    _string += $"marginNorthY2 = {_layoutStruct.marginNorthY2}\n";
    _string += $"marginSouthY1 = {_layoutStruct.marginSouthY1}\n";
    _string += $"marginSouthY2 = {_layoutStruct.marginSouthY2}\n";
    funcTextbox(244, _bottom+6, _string);
    
    var _string = "";
    _string += $"cameraWidth = {_layoutStruct.cameraWidth}\n";
    _string += $"cameraHeight = {_layoutStruct.cameraHeight}\n";
    _string += $"cameraOverscan = {_layoutStruct.cameraOverscan}\n";
    _string += $"cameraIgnore = {_layoutStruct.cameraIgnore? "true" : "false"}\n";
    _string += $"viewWidth = {_layoutStruct.viewWidth}\n";
    _string += $"viewHeight = {_layoutStruct.viewHeight}\n";
    _string += $"viewScale = {_layoutStruct.viewScale}\n";
    _string += $"viewOverscan = {_layoutStruct.viewOverscan}\n";
    var _bottom = funcTextbox(3, _bottom+6, _string);
    
    var _string = "";
    _string += $"fullscreen = {_layoutStruct.fullscreen? "true" : "false"}\n";
    _string += $"windowWidth = {_layoutStruct.windowWidth}\n";
    _string += $"windowHeight = {_layoutStruct.windowHeight}\n";
    _string += $"guiWidth = {_layoutStruct.guiWidth}\n";
    _string += $"guiHeight = {_layoutStruct.guiHeight}\n";
    var _bottom = funcTextbox(3, _bottom+6, _string);
}
else if (mode == 2)
{
    var _bottom = funcTextbox(3, 3, $"PictureFrame {PICTURE_FRAME_VERSION}, {PICTURE_FRAME_DATE}\nPress [left] and [right] to change page");
    var _bottom = funcTextbox(3, _bottom+6, "Config struct");
    
    var _configStruct = PfGetAppliedConfigStruct();
    
    var _string = "";
    _string += $"fullscreen = {_configStruct.fullscreen? "true" : "false"}\n";
    _string += $"windowWidth = {_configStruct.windowWidth}\n";
    _string += $"windowHeight = {_configStruct.windowHeight}\n";
    _string += $"trimBlackBars = {_configStruct.trimBlackBars? "true" : "false"}\n";
    _string += $"surfaceAvoidNotch = {_configStruct.surfaceAvoidNotch? "true" : "false"}\n";
    _string += $"surfacePixelPerfect = {_configStruct.surfacePixelPerfect? "true" : "false"}\n";
    _string += $"windowOverscanScale = {_configStruct.windowOverscanScale}\n";
    var _rightBottom = funcTextbox(122, _bottom+6, _string);
    
    var _string = "";
    _string += $"PICTURE_FRAME_ON_DESKTOP = {PICTURE_FRAME_ON_DESKTOP? "true" : "false"}\n";
    _string += $"PICTURE_FRAME_ON_MOBILE = {PICTURE_FRAME_ON_MOBILE? "true" : "false"}\n";
    _string += $"PICTURE_FRAME_ON_GXGAMES = {PICTURE_FRAME_ON_GXGAMES? "true" : "false"}\n";
    funcTextbox(122, _rightBottom+6, _string);
    
    var _string = "";
    _string += $"guiWindowStretch = {_configStruct.guiWindowStretch}\n";
    _string += $"guiMode = {_configStruct.guiMode}\n";
    _string += $"guiTargetWidth = {_configStruct.guiTargetWidth}\n";
    _string += $"guiTargetHeight = {_configStruct.guiTargetHeight}\n";
    _string += $"guiScale = {_configStruct.guiScale}\n";
    _string += $"guiAvoidNotch = {_configStruct.guiAvoidNotch? "true" : "false"}\n";
    var _bottom = funcTextbox(3, _bottom+6, _string);
    
    var _string = "";
    _string += $"cameraTargetWidth = {_configStruct.cameraTargetWidth}\n";
    _string += $"cameraTargetHeight = {_configStruct.cameraTargetHeight}\n";
    _string += $"cameraMaxWidth = {_configStruct.cameraMaxWidth}\n";
    _string += $"cameraMaxHeight = {_configStruct.cameraMaxHeight}\n";
    _string += $"cameraOverscan = {_configStruct.cameraOverscan}\n";
    _string += $"cameraIgnore = {_configStruct.cameraIgnore? "true" : "false"}\n";
    _string += $"viewMaxScale = {_configStruct.viewMaxScale}\n";
    _string += $"viewPixelPerfect = {_configStruct.viewPixelPerfect}\n";
    funcTextbox(3, _bottom+6, _string);
}
else if (mode == 3)
{
    var _bottom = funcTextbox(3, 3, $"GX.Canvas {extension_get_version("GXCanvas")}\nPress [left] and [right] to change page");
    
    var _string = "";
    _string += $"itch.io = {GXCanvasIsItchIo()? "true" : "false"}\n";
    _string += $"Mobile = {GXCanvasIsMobile()? "true" : "false"}\n";
    _string += $"Canvas CSS = {GXCanvasGetCanvasCSSWidth()} x {GXCanvasGetCanvasCSSHeight()}\n";
    _string += $"Canvas = {GXCanvasGetCanvasWidth()} x {GXCanvasGetCanvasHeight()}\n";
    _string += $"Window Inner = {GXCanvasGetWindowInnerWidth()} x {GXCanvasGetWindowInnerHeight()}\n";
    _string += $"Screen = {GXCanvasGetScreenWidth()} x {GXCanvasGetScreenHeight()}\n";
    var _bottom = funcTextbox(3, _bottom+6, _string);
    
    var _string = "";
    _string += $"GM Native Window = {window_get_width()} x {window_get_height()}\n";
    _string += $"PF Window = {__PfWindowGetWidth()} x {__PfWindowGetHeight()}\n";
    funcTextbox(3, _bottom+6, _string);
}

draw_set_font(-1);