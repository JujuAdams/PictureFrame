// Feather disable all

/// Returns a template PictureFrame "configuration struct". This configuration struct can then be
/// passed into PfCalculate() to generate various positions and sizes for each phase in GameMaker's
/// rendering pipeline. The configuration struct is rather complex and if you're looking for easier
/// "quick start" behaviour than you may want to consider calling either PfConfigPixelArt() or
/// PfConfigHighRes() instead. They return a similar struct to PfConfigGeneral() but pre-configured
/// for common use cases.
/// 
/// You should edit the returned configuration struct to reflect the needs of your game.
/// 
/// N.B. Because PfConfigGeneral() returns a fresh struct every time it is called, you should
///      avoid calling this function more often than is necessary.
/// 
/// 
/// 
/// Variables that the configuration struct hold are as follows:
/// 
/// .cameraMinWidth
/// .cameraMinHeight
///     The minimum width and height for the camera. This is the "safe area" that is guaranteed to
///     be visible.
/// 
/// .cameraMaxWidth
/// .cameraMaxHeight
///     The maximum width and height for the camera. This is an expansion zone that the camera can
///     grow into to adapt to different resolutions and aspect ratios.
/// 
/// .cameraOverscan
///     The number of extra pixels, in roomspace, to add around the edges of the camera. A value of
///     1 will add one pixel to the left, top, right, and bottom edges leading to a 2 pixel
///     increase in the overall width and height of the camera. Normally you'll want to set this
///     variable to 0 but you may want to set it to higher values if you're implementing visual
///     effects that extend beyond the limits of the camera or you're implementing a smooth scroll
///     effect alongside pixel perfect graphics.
/// 
/// .viewMaxScale
///     Maximum scaling factor from the camera to the view. For pixel perfect games that don't want
///     subpixelling, this value should be set to 1. If you do want subpixelling, or you're making
///     a high res game, this value should usually be set to <infinity>. You may rarely want to set
///     another value if you want tighter control the view scale and subpixelling.
/// 
/// .viewPixelPerfect
///     Whether the camera-to-view scale should be a whole number. If you're making a pixel art
///     game, whether you want subpixelling or not, this variable should almost certainly be set
///     to <true>.
/// 
/// .fullscreen
///     The fullscreen state for the game. This value is only relevant on desktop platforms
///     (Windows, MacOS, Linux).
/// 
/// .windowWidth
/// .windowHeight
///     The size of the game window. This value is only relevant when the game is not fullscreened
///     and is therefore only relevant on desktop platforms (Windows, MacOS, Linux).
/// 
/// .guiStretchOverWindow
///     Whether to stretch the GUI over the entire window. This is <false> by default meaning that
///     the GUI layer will be stretched over the application surface portion of the window.
/// 
/// .guiTargetWidth
/// .guiTargetHeight
///     The target width or height for the GUI layer dimensions. To allow PfCalculate() to adapt to
///     different aspect ratios, set one of these variables to <undefined>. In this situation,
///     PictureFrame will adjust the <undefined> dimension to stretch the GUI layer over the window
///     whilst keeping the aspect ratio correct between the GUI width and height.
/// 
/// .surfacePixelPerfect
///     Determines whether the scaling factor applied to the application surface when drawn to the
///     GUI layer should be a whole number. This may sometimes result in black bars appearing
///     around the application surface. This only applies when using PfPostDrawAppSurface().
/// 
/// .windowOverscanScale
///     Scaling factor to apply to the application surface and GUI at the end of the render
///     pipeline. This is useful to adjust for overscan on old monitors and it is a compliance
///     requirement when releasing on some console platforms. The overscan scale will ignore
///     .surfacePixelPerfect (see above).

function PfConfigGeneral()
{
    var _configStruct = {
        cameraOverscan: 0,
        
        //Force "fullscreen" on non-desktop platforms
        fullscreen: ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux))? window_get_fullscreen() : true,
        
        windowWidth:  window_get_width(),
        windowHeight: window_get_height(),
        
        guiStretchOverWindow: false,
        guiDPIReference: undefined,
        guiDPIFactor: 1,
        
        windowOverscanScale: 1,
    }
    
    with(_configStruct)
    {
        if (view_enabled && view_get_visible(0))
        {
            var _camera = view_get_camera(0);
            cameraMinWidth  = camera_get_view_width(_camera);
            cameraMinHeight = camera_get_view_height(_camera);
            cameraMaxWidth  = cameraMinWidth;
            cameraMaxHeight = cameraMinHeight;
            
            viewMaxScale = min(view_get_wport(0) / cameraMinWidth, view_get_hport(0) / cameraMinHeight);
            
            //Set the view to pixel perfect if it's a whole scale of the camera
            viewPixelPerfect = (floor(viewMaxScale) == viewMaxScale);
            
            //Application surface pixel perfect drawing follows whether the view is pixel perfect too
            surfacePixelPerfect = viewPixelPerfect;
        }
        else
        {
            cameraMinWidth  = surface_get_width(application_surface);
            cameraMinHeight = surface_get_height(application_surface);
            cameraMaxWidth  = cameraMinWidth;
            cameraMaxHeight = cameraMinHeight;
            
            viewMaxScale     = infinity;
            viewPixelPerfect = false;
            
            surfacePixelPerfect = false;
        }
        
        if (windowWidth > windowHeight)
        {
            guiTargetWidth  = undefined;
            guiTargetHeight = cameraMinWidth;
        }
        else
        {
            guiTargetWidth  = cameraMinHeight;
            guiTargetHeight = undefined;
        }
    }
    
    return _configStruct;
}