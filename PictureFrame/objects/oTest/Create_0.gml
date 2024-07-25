// Feather disable all

//Create a new config using a 
configStruct = PfConfigPixelArt(640, 160, 640, 300);

//Set the window to get as big as possible without quite filling the entire screen
//We're going to force the window to resize so it doesn't matter if this is a "good" size
configStruct.windowWidth  = display_get_width()  - 160;
configStruct.windowHeight = display_get_height() - 160;

//We'll use this result struct later to draw the margins
resultStruct = PfApply(configStruct, true);

var _camera = view_get_camera(0);
cameraX = camera_get_view_x(_camera);
cameraY = camera_get_view_y(_camera);
cameraTargetX = cameraX;
cameraTargetY = cameraY;