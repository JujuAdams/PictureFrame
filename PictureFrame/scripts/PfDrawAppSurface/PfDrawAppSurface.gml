// Feather disable all

/// Draws the application surface. This function assumes you are using GUI-space coordinates and
/// you should call this function in a Draw GUI event. The result struct that is required by this
/// function can be created by calling PfCalculate(). Please see that function's documentation for
/// more information.
/// 
/// N.B. When using PfDrawAppSurface() you will almost certainly want to disable GameMaker's native
///      application surface drawing using application_surface_draw_enable().
/// 
/// N.B. Please ensure that the scaling option "Full scale" is selected for the target platform
///      in Game Options / Graphics / Scaling. You will encounter scaling issues if this option
///      is set to "Keep aspect ratio" because GameMaker will try to be helpful but will sadly
///      mess up the draw coordinates we want to use.
/// 
/// The optional arguments for this function will control basic properties of the draw operation.
/// The default value for "texFilter" will depend on the .surfacePixelPerfect value in the result
/// struct. If .surfacePixelPerfect is set to <true> then the default texture filter state will be
/// <false> (nearest neighbour interpolation) and vice versa.
/// 
/// This function can be used to draw surfaces other than the application surface. Surfaces drawn
/// by the function will be stretched to cover the region defined by the result struct. This can
/// be useful when drawing overlays, e.g. pixel perfect UI, post-processing effects and so on.
/// 
/// @param [texFilter]
/// @param [blendEnable=false]
/// @param [surface=appSurface]

function PfDrawAppSurface(_filter = undefined, _blendEnable = false, _surface = application_surface)
{
    static _system = __PfSystem();
    with(_system.__resultStruct)
    {
        var _oldFilter = gpu_get_tex_filter();
        var _oldBlendEnable = gpu_get_blendenable();
        
        gpu_set_tex_filter(_filter ?? (not surfacePixelPerfect));
        gpu_set_blendenable(_blendEnable);
        
        if (surface_exists(_surface))
        {
            draw_surface_stretched(_surface, surfaceDrawX, surfaceDrawY, surfaceDrawWidth, surfaceDrawHeight);
        }
        
        gpu_set_tex_filter(_oldFilter);
        gpu_set_blendenable(_oldBlendEnable);
    }
    
    return self;
}