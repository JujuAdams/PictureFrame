mode = 1;
modeCount = PICTURE_FRAME_ON_GXGAMES? 4 : 3;

funcTextbox = function(_x, _y, _string)
{
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    
    var _height = string_height(_string) + 5;
    draw_rectangle(_x, _y, _x + string_width(_string) + 7, _y + _height, false);
    
    draw_set_alpha(1);
    draw_text(_x+3, _y+3, _string);
    draw_text(_x+4, _y+2, _string);
    draw_text(_x+5, _y+3, _string);
    draw_text(_x+4, _y+4, _string);
    
    draw_set_color(c_white);
    draw_text(_x+4, _y+3, _string);
    
    return _y + _height;
}