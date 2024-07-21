// Feather disable all

configStruct = PfConfigPixelArt(700, 160, true, true);

//Set the window to get as big as possible without quite filling the entire screen
configStruct.windowWidth  = display_get_width() - 160;
configStruct.windowHeight = display_get_height() - 160;

resultStruct = PfCalculate(configStruct);
PfApply(resultStruct);

camera_set_view_angle(view_get_camera(0), 10);