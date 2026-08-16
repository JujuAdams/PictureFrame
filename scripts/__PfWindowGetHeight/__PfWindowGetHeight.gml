function __PfWindowGetHeight()
{
    return PICTURE_FRAME_ON_GXGAMES? GXCanvasGetWindowInnerHeight() : window_get_height();
}