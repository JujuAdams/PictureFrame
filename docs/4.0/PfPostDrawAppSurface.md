# PfPostDrawAppSurface

&nbsp;

`PfPostDrawAppSurface([filter], [blendEnable=false], [surface=application_surface], [fracCameraX=0], [fracCameraY=0])`

**Returns:** N/A (`undefined`)

|Name           |Datatype|Purpose                                                                                                                                      |
|---------------|--------|---------------------------------------------------------------------------------------------------------------------------------------------|
|`[filter]`     |boolean |Whether to apply texture filter (bilinear interpolation). If not specified, the value from the applied layout struct will be used (see below)|
|`[blendEnable]`|boolean |Whether to enable alpha blending. If not specified defaults to `false`                                                                       |
|`[surface]`    |surface |Surface to draw. If not specified defaults to `application_surface`                                                                          |
|`[fracCameraX]`|number  |Fractional part of the camera's x-position. Used to compensate for jitter when using a pixel perfect camera                                  |
|`[fracCameraY]`|number  |Fractional part of the camera's y-position. Used to compensate for jitter when using a pixel perfect camera                                  |

Draws the application surface. This function should only be called in the Post Draw event and further requires that `PfApply()` has been called previously to set the necessary values to draw correctly.

The optional parameters for this function will control basic properties of the draw operation. If you do not specify `texFilter` then the `.surfacePixelPerfect` value from the layout struct will be used. If you do not specify whether you want to use alpha blending with `blendEnable` then no blending will be used (which is usually what you want in the Post Draw event). The `fracCameraX` and `fracCameraY` parameters are optional and allow you to implement a smooth camera scroll even when drawing pixel perfect graphics without subpixelling.

This function can also be used to draw surfaces other than the application surface. Surfaces drawn by the function will be stretched to cover the region defined by the layout struct. This can be useful when drawing overlays, e.g. pixel perfect UI, post-processing effects, and so on.