// Feather disable all

configStruct = PfConfigPixelArt(640, 360, 640, 400, true);

//Set the window to get as big as possible without quite filling the entire screen
configStruct.windowWidth  = display_get_width() - 160;
configStruct.windowHeight = display_get_height() - 160;

resultStruct = PfCalculate(configStruct);
PfApply(resultStruct);

var _camera = view_get_camera(0);
cameraX = camera_get_view_x(_camera);
cameraY = camera_get_view_y(_camera);
cameraTargetX = cameraX;
cameraTargetY = cameraY;