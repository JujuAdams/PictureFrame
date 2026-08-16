function __PfWindowGetWidth()
{
    return PICTURE_FRAME_ON_GXGAMES? GXCanvasGetWindowInnerWidth() : window_get_width();
}