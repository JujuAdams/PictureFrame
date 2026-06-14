// Feather disable all

with(PfGetAppliedLayoutStruct())
{
    if (marginsVisible)
    {
        draw_set_alpha(0.25);
        
        //Right
        draw_set_color(c_red);
        draw_rectangle(marginEastX1, marginNorthY2, marginEastX2-1, marginSouthY1-1, false);
        
        //Up
        draw_set_color(c_lime);
        draw_rectangle(marginWestX2, marginNorthY1, marginEastX1-1, marginNorthY2-1, false);
        
        //Left
        draw_set_color(c_blue);
        draw_rectangle(marginWestX1, marginNorthY2, marginWestX2-1, marginSouthY1-1, false);
        
        //Bottom
        draw_set_color(c_yellow);
        draw_rectangle(marginWestX2, marginSouthY1, marginEastX1-1, marginSouthY2-1, false);
        
        draw_set_color(c_white);
        draw_set_alpha(1);
    }
}

var _scale = PfGetAppliedLayoutStruct().surfacePostDrawScale;

var _radius = _scale;
var _top    = _radius - 1;
var _left   = _radius - 1;
var _right  = display_get_gui_width()  - _radius - 1;
var _bottom = display_get_gui_height() - _radius - 1;

draw_set_alpha(0.3);
draw_set_color(c_red);
draw_circle(_left, _top, _radius, false);
draw_set_color(c_lime);
draw_circle(_right, _top, _radius, false);
draw_set_color(c_blue);
draw_circle(_left, _bottom, _radius, false);
draw_set_color(c_yellow);
draw_circle(_right, _bottom, _radius, false);
draw_set_color(c_white);
draw_set_alpha(1);