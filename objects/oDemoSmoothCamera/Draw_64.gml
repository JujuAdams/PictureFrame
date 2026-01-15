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