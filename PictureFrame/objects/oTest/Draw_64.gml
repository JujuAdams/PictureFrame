// Feather disable all

with(resultStruct)
{
    if (marginsVisible)
    {
        draw_set_alpha(0.5);
        draw_set_color(c_red);
        draw_rectangle(marginGuiRight, 0, windowWidth-1, marginGuiBottom-1, false);
        draw_set_color(c_lime);
        draw_rectangle(0, marginGuiTop, marginGuiRight-1, -1, false);
        draw_set_color(c_blue);
        draw_rectangle(marginGuiLeft, 0, -1, marginGuiBottom-1, false);
        draw_set_color(c_yellow);
        draw_rectangle(0, marginGuiBottom, marginGuiRight-1, windowHeight-1, false);
        draw_set_color(c_white);
        draw_set_alpha(1);
    }
}