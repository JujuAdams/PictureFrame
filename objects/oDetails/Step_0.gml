var _funcAnyGamepadPressedStart = function()
{
    var _i = 0;
    repeat(gamepad_get_device_count())
    {
        if (gamepad_button_check_pressed(_i, gp_padl))
        {
            return -1;
        }
        
        if (gamepad_button_check_pressed(_i, gp_padr))
        {
            return 1;
        }
        
        ++_i;
    }
    
    return false;
}

var _delta = _funcAnyGamepadPressedStart();
_delta += keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
mode = (mode + _delta + 4) mod 4;