function __PfWindowGetHeight()
{
    return PICTURE_FRAME_ON_GXGAMES? __PfGXCanvasGetWindowInnerHeight() : window_get_height();
}