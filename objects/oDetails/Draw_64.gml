if (mode == 2) return;

draw_set_font(fntDefault);

if (mode == 0)
{
    funcTextbox(3, 3, "Press [enter] or [start] for details");
}
else if (mode == 1)
{
    var _string = "";
    _string += $"PictureFrame {PICTURE_FRAME_VERSION}, {PICTURE_FRAME_DATE}\n";
    _string += $"Press [enter] or [start] to hide details\n";
    
    var _bottom = funcTextbox(3, 3, _string);
    
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

draw_set_font(-1);