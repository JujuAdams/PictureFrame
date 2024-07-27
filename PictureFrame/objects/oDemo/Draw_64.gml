// Feather disable all

with(PfGetApplied())
{
    if (marginsVisible)
    {
        draw_set_alpha(0.25);
        
        draw_set_color(c_red);
        draw_rectangle(marginGuiX3, marginGuiY2, marginGuiX4-1, marginGuiY3-1, false);
        draw_set_color(c_lime);
        draw_rectangle(marginGuiX2, marginGuiY1, marginGuiX3-1, marginGuiY2-1, false);
        draw_set_color(c_blue);
        draw_rectangle(marginGuiX1, marginGuiY2, marginGuiX2-1, marginGuiY3-1, false);
        draw_set_color(c_yellow);
        draw_rectangle(marginGuiX2, marginGuiY3, marginGuiX3-1, marginGuiY4-1, false);
        
        draw_set_color(c_white);
        draw_set_alpha(1);
    }
}