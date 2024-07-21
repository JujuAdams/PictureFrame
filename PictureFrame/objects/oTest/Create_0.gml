// Feather disable all

configStruct = PfConfigPixelPerfect(640, 160, false);

//Set the window to get as big as possible without quite filling the entire screen
configStruct.windowWidth  = display_get_width() - 160;
configStruct.windowHeight = display_get_height() - 160;

resultStruct = PfCalculate(configStruct);
PfApply(resultStruct);
application_surface_draw_enable(false);

camera_set_view_angle(view_get_camera(0), 10);