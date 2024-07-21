// Feather disable all

configStruct = PfConfigPixelArt(640, 360);
configStruct.viewMaxScale = infinity;

//Set the window to get as big as possible without quite filling the entire screen
configStruct.windowWidth  = display_get_width() - 160;
configStruct.windowHeight = display_get_height() - 160;

resultStruct = PfCalculate(configStruct);
PfApply(resultStruct);

//camera_set_view_angle(view_get_camera(0), 10);

var _camera = view_get_camera(0);
cameraX = camera_get_view_x(_camera);
cameraY = camera_get_view_y(_camera);