var _funcAnyGamepadPressedStart = function()
{
    var _i = 0;
    repeat(gamepad_get_device_count())
    {
        if (gamepad_button_check_pressed(_i, gp_start))
        {
            return true;
        }
        
        ++_i;
    }
    
    return false;
}

if (keyboard_check_pressed(vk_enter) || _funcAnyGamepadPressedStart())
{
    mode = (mode + 1) mod 3;
}

if (keyboard_check_pressed(vk_up))
{
    scrollY = min(scrollCount-1, scrollY+1);
}

if (keyboard_check_pressed(vk_down))
{
    scrollY = max(0, scrollY-1);
}