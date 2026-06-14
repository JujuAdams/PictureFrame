// Feather disable all

/// Draws the application surface. This function should only be called in the Post Draw event and
/// further requires that `PfApply()` has been called previously to set the necessary values to
/// draw correctly.
/// 
/// The optional parameters for this function will control basic properties of the draw operation.
/// If you do not specify `texFilter` then the `.surfacePixelPerfect` value from the layout struct
/// will be used. If you do not specify whether you want to use alpha blending with `blendEnable`
/// then no blending will be used (which is usually what you want in the Post Draw event). The
/// `fracCameraX` and `fracCameraY` parameters are optional and allow you to implement a smooth
/// camera scroll even when drawing pixel perfect graphics without subpixelling.
/// 
/// This function can also be used to draw surfaces other than the application surface. Surfaces
/// drawn by the function will be stretched to cover the region defined by the layout struct. This
/// can be useful when drawing overlays, e.g. pixel perfect UI, post-processing effects, and so on.
/// 
/// @param [texFilter]
/// @param [blendEnable=false]
/// @param [surface=appSurface]
/// @param [fracCameraX=0]
/// @param [fracCameraY=0]

function PfPostDrawAppSurface(_filter = undefined, _blendEnable = false, _surface = application_surface, _fracCameraX = 0, _fracCameraY = 0)
{
    static _system = __PfSystem();
    with(_system.__layoutStruct)
    {
        var _oldFilter = gpu_get_tex_filter();
        var _oldBlendEnable = gpu_get_blendenable();
        
        gpu_set_tex_filter(_filter ?? (not surfacePixelPerfect));
        gpu_set_blendenable(_blendEnable);
        
        if (surface_exists(_surface))
        {
            var _left = viewOverscan + viewScale*frac(_fracCameraX);
            var _top  = viewOverscan + viewScale*frac(_fracCameraY);
            
            var _width  = surface_get_width( _surface) - 2*viewOverscan;
            var _height = surface_get_height(_surface) - 2*viewOverscan;
            
            var _xScale = surfacePostDrawWidth  / _width;
            var _yScale = surfacePostDrawHeight / _height;
            
            draw_surface_part_ext(_surface, _left, _top, _width, _height, surfacePostDrawX, surfacePostDrawY, _xScale, _yScale, c_white, 1);
        }
        
        gpu_set_tex_filter(_oldFilter);
        gpu_set_blendenable(_oldBlendEnable);
    }
}
