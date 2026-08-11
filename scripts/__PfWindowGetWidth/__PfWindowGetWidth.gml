function __PfWindowGetWidth()
{
    return PICTURE_FRAME_ON_GXGAMES? __PfGXCanvasGetWindowInnerWidth() : window_get_width();
}