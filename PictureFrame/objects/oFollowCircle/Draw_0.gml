// Feather disable all

draw_set_color(c_black);
draw_set_alpha(0.4);
draw_circle(x, y, 16, false);
draw_set_alpha(1);
draw_circle(PfMouseX(), PfMouseY(), 16, true);
draw_circle(mouse_x, mouse_y, 24, true);
draw_set_color(c_white);