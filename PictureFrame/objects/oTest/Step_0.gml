// Feather disable all

if (keyboard_check_pressed(vk_escape))
{
    game_end();
}

var _camera = view_get_camera(0);

if (mouse_check_button_pressed(mb_left))
{
    cameraX = mouse_x - camera_get_view_width(_camera)/2;
    cameraY = mouse_y - camera_get_view_height(_camera)/2;
}

camera_set_view_pos(_camera,
                    lerp(camera_get_view_x(_camera), cameraX, 0.1),
                    lerp(camera_get_view_y(_camera), cameraY, 0.1));