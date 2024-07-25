// Feather disable all

/// Draws the application surface. This function should only be called in the Post Draw event and
/// further requires that PfApply() has been called previously to set the necessary values to draw
/// correctly.
/// 
/// The optional arguments for this function will control basic properties of the draw operation.
/// The "fracCameraX" and "fracCameraY" arguments are optional and allow you to implement a smooth
/// camera scroll even when drawing pixel perfect graphics without subpixelling.
/// 
/// This function can also be used to draw surfaces other than the application surface. Surfaces
/// drawn by the function will be stretched to cover the region defined by the result struct. This
/// can be useful when drawing overlays, e.g. pixel perfect UI, post-processing effects and so on.
/// 
/// @param [texFilter=false]
/// @param [blendEnable=false]
/// @param [surface=appSurface]
/// @param [fracCameraX=0]
/// @param [fracCameraY=0]

function PfPostDrawAppSurface(_filter = false, _blendEnable = false, _surface = application_surface, _fracCameraX = 0, _fracCameraY = 0)
{
    static _system = __PfSystem();
    with(_system.__resultStruct)
    {
        var _oldFilter = gpu_get_tex_filter();
        var _oldBlendEnable = gpu_get_blendenable();
        
        gpu_set_tex_filter(_filter);
        gpu_set_blendenable(_blendEnable);
        
        if (surface_exists(_surface))
        {
            var _left = viewOverscan + viewScale*frac(_fracCameraX);
            var _top  = viewOverscan + viewScale*frac(_fracCameraY);
            
            var _width  = viewWidth  - 2*viewOverscan;
            var _height = viewHeight - 2*viewOverscan;
            
            var _xScale = surfacePostDrawWidth  / _width;
            var _yScale = surfacePostDrawHeight / _height;
            
            draw_surface_part_ext(_surface, _left, _top, _width, _height, surfacePostDrawX, surfacePostDrawY, _xScale, _yScale, c_white, 1);
        }
        
        gpu_set_tex_filter(_oldFilter);
        gpu_set_blendenable(_oldBlendEnable);
    }
    
    return self;
}