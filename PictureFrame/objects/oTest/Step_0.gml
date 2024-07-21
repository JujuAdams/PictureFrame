// Feather disable all

if (keyboard_check_pressed(vk_escape))
{
    game_end();
}

var _camera = view_get_camera(0);

if (mouse_check_button_pressed(mb_left))
{
    cameraTargetX = mouse_x - camera_get_view_width(_camera)/2;
    cameraTargetY = mouse_y - camera_get_view_height(_camera)/2;
}

cameraX = lerp(cameraX, cameraTargetX, 0.1);
cameraY = lerp(cameraY, cameraTargetY, 0.1);

camera_set_view_pos(_camera, cameraX, cameraY);