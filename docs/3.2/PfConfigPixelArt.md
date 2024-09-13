# PfConfigPixelArt

&nbsp;

`PfConfigPixelArt(cameraMinWidth, cameraMinHeight, [cameraMaxWidth=Min], [cameraMaxHeight=Min], [fullscreen])`

**Returns:** Struct, a PictureFrame configuration

|Name               |Datatype|Purpose                                                                                                                                                                                 |
|-------------------|--------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`cameraMinWidth`   |number  |Minimum width for the camera. This is the "safe area" that is guaranteed to be visible                                                                                                  |
|`cameraMinHeight`  |number  |Minimum height for the camera. This is the "safe area" that is guaranteed to be visible                                                                                                 |
|`[cameraMaxWidth]` |number  |Maximum width for the camera. This is an expansion zone that the camera can grow into to adapt to different resolutions and aspect ratios. If not specified, the minimum width is used  |
|`[cameraMaxHeight]`|number  |Maximum height for the camera. This is an expansion zone that the camera can grow into to adapt to different resolutions and aspect ratios. If not specified, the minimum height is used|
|`[fullscreen]`     |boolean |Fullscreen state for the game. This value is only relevant on desktop platforms (Windows, MacOS, Linux). If not specified, the fullscreen state for the game will not be changed        |

A convenience function that returns a configuration struct set up for pixel-perfect rendering. You can edit values in the returned struct if you'd like and it will obey all the same rules as a configuration struct returned by [`PfConfigGeneral()`](PfConfigGeneral). This configuration struct can then be passed into `PfApply()` to set up the render pipeline to match the configuration struct as closely as possible, or `PfCalculate()` to generate various positions and sizes for each phase in GameMaker's rendering pipeline.

?> Because `PfConfigPixelArt()` returns a fresh struct every time it is called, you should avoid calling this function more often than is necessary.

&nbsp;

Variables that the configuration struct hold are as follows:

|Name                                   |Datatype|Value|Purpose                                                     |
|---------------------------------------|--------|-----|------------------------------------------------------------|
|`.cameraMinWidth`<br>`.cameraMinHeight`|number  |     |Minimum width and height for the camera. This is the "safe area" that is guaranteed to be visible            |
|`.cameraMaxWidth`<br>`.cameraMaxHeight`|number  |     |Maximum width and height for the camera. This is an expansion zone that the camera can grow into to adapt to different resolutions and aspect ratios|
|`.cameraOverscan`                      |number  |     |Number of extra pixels, in roomspace, to add around the edges of the camera. A value of 1 will add one pixel to the left, top, right, and bottom edges leading to a 2 pixel increase in the overall width and height of the camera. Normally you'll want to set this variable to 0 but you may want to set it to higher values if you're implementing visual effects that extend beyond the limits of the camera or you're implementing a smooth scroll effect alongside pixel perfect graphics|
|`.viewMaxScale`                        |number  |     |Maximum scaling factor from the camera to the view. For pixel perfect games that don't want subpixelling, this value should be set to `1`. If you do want subpixelling, or you're making a high res game, this value should usually be set to `infinity`. You may rarely want to set another value if you want tighter control over the view scale and subpixelling|
|`.viewPixelPerfect`                    |boolean |     |Whether the camera-to-view scale should be a whole number. If you're making a pixel art game, whether you want subpixelling or not, this variable should almost certainly be set to `true`|
|`.fullscreen`                          |boolean |     |Fullscreen state for the game. This value is only relevant on desktop platforms (Windows, MacOS, Linux)|
|`.windowWidth`<br>`.windowHeight`      |number  |     |Size of the game window. This value is only relevant when the game is not fullscreened and is therefore only relevant on desktop platforms (Windows, MacOS, Linux)|
|`.guiStretchOverWindow`                |boolean |     |Whether to stretch the GUI over the entire window. This is `false` by default meaning that the GUI layer will be stretched over the application surface portion of the window|
|`.guiTargetWidth`<br>`.guiTargetHeight`|number  |     |Target width or height for the GUI layer dimensions. To allow [`PfCalculate()`](PfCalculate) to adapt to different aspect ratios, set one of these variables to `undefined`. In this situation, PictureFrame will adjust the `undefined` dimension to stretch the GUI layer over the window whilst keeping the aspect ratio correct between the GUI width and height|
|`.surfacePixelPerfect`                 |boolean |     |Determines whether the scaling factor applied to the application surface when drawn to the window should be a whole number. If the surface doesn't fit exactly (which is often the case) then the application surface will be drawn centred in the window|
|`.windowOverscanScale`                 |number  |     |Scaling factor to apply to the application surface and GUI at the end of the render pipeline. This is useful to adjust for overscan on old monitors and it is a compliance requirement when releasing on some console platforms. The overscan scale will ignore `.surfacePixelPerfect` (see above)|