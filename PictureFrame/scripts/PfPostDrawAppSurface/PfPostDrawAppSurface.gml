// Feather disable all

/// Draws the application surface. This function assumes you are using GUI-space coordinates and
/// you should call this function in a Draw GUI event. The result struct that is required by this
/// function can be created by calling PfCalculate(). Please see that function's documentation for
/// more information.
/// 
/// The optional arguments for this function will control basic properties of the draw operation.
/// 
/// This function can be used to draw surfaces other than the application surface. Surfaces drawn
/// by the function will be stretched to cover the region defined by the result struct. This can
/// be useful when drawing overlays, e.g. pixel perfect UI, post-processing effects and so on.
/// 
/// @param [texFilter=false]
/// @param [blendEnable=false]
/// @param [surface=appSurface]

function PfPostDrawAppSurface(_filter = false, _blendEnable = false, _surface = application_surface)
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
            draw_surface_stretched(_surface, surfacePostDrawX, surfacePostDrawY, surfacePostDrawWidth, surfacePostDrawHeight);
        }
        
        gpu_set_tex_filter(_oldFilter);
        gpu_set_blendenable(_oldBlendEnable);
    }
    
    return self;
}