// Feather disable all

//Shortcut to quit the game
if (keyboard_check_pressed(vk_escape))
{
    game_end();
}

//
if (keyboard_check_pressed(vk_f4))
{
    configStruct.fullscreen = not window_get_fullscreen();
    resultStruct = PfApply(configStruct);
}

//Move the camera when the player clicks
var _camera = view_get_camera(0);

if (mouse_check_button_pressed(mb_left))
{
    cameraTargetX = mouse_x - camera_get_view_width(_camera)/2;
    cameraTargetY = mouse_y - camera_get_view_height(_camera)/2;
}

cameraX = lerp(cameraX, cameraTargetX, 0.1);
cameraY = lerp(cameraY, cameraTargetY, 0.1);

camera_set_view_pos(_camera, cameraX, cameraY);

//Adapt our pipeline when the window size changes
if (PfWindowSizeChanged())
{
    //Update our configuration
    configStruct.fullscreen   = window_get_fullscreen();
    configStruct.windowWidth  = window_get_width();
    configStruct.windowHeight = window_get_height();
    
    //Reapply to adapt to the new window size
    resultStruct = PfApply(configStruct);
}