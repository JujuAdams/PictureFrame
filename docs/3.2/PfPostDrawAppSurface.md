# PfPostDrawAppSurface

&nbsp;

`PfPostDrawAppSurface([filter=false], [blendEnable=false], [surface=application_surface], [fracCameraX=0], [fracCameraY=0])`

**Returns:** Struct, a PictureFrame result struct

|Name            |Datatype|Purpose|
|----------------|--------|-------|
|`[filter]`      |boolean |       |
|`[resizeWindow]`|boolean |       |
|`[surface]`     |surface |       |
|`[fracCameraX]` |number  |       |
|`[fracCameraY]` |number  |       |

Draws the application surface. This function should only be called in the Post Draw event and further requires that `PfApply()` has been called previously to set the necessary values to draw correctly. (See [Getting Started](GettingStarted) for more on the correct order to call functions in.)

The optional arguments for this function will control basic properties of the draw operation. The `fracCameraX` and `fracCameraY` arguments are optional and allow you to implement a smooth camera scroll even when drawing pixel perfect graphics without subpixelling.

This function can also be used to draw surfaces other than the application surface. Surfaces drawn by the function will be stretched to cover the region defined by the result struct (from `PfApply()` or `PfGetApplied()`). This can be useful when drawing overlays, e.g. pixel perfect UI, post-processing effects and so on.