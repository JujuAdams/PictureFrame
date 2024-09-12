# PfConfigPixelArt

	PfConfigPixelArt(cameraMinWidth,cameraMinHeight, [cameraMaxWidth=Min], [cameraMaxHeight=Min],[fullscreen])

A convenience function that returns a configuration struct set up for pixel-perfect rendering.
You can edit values in the returned struct if you'd like and it will obey all the same rules as a configuration struct returned by [PfConfigGeneral()](PfConfigGeneral).
 
?> Because PfConfigPixelArt() returns a fresh struct every time it is called, you should avoid calling this function more often than is necessary.

Variables that the configuration struct hold are as follows:

|Name           |Datatype                  |Purpose                                                     |
|---------------|--------------------------|------------------------------------------------------------|
|`.cameraMinWidth, .cameraMinHeight`      |number                    | The minimum width and height for the camera. This is the "safe area" that is guaranteed to be visible.            |
|`.cameraMaxWidth, .cameraMaxHeight`     |number|**Defaults to the same as MinWidth**. The maximum width and height for the camera. This is an expansion zone that the camera can grow into to adapt to different resolutions and aspect ratios. |
|`.cameraOverscan`    |number|**Defaults to 0.** The number of extra pixels, in roomspace, to add around the edges of the camera. A value of 1 will add one pixel to the left, top, right, and bottom edges leading to a 2 pixel increase in the overall width and height of the camera. Normally you'll want to set this variable to 0 but you may want to set it to higher values if you're implementing visual effects that extend beyond the limits of the camera or you're implementing a smooth scroll effect alongside pixel perfect graphics.|
|`.viewMaxScale`|number|**Defaults to 1.** Maximum scaling factor from the camera to the view. For pixel perfect games that don't want subpixelling, this value should be set to 1. If you do want subpixelling, or you're making a high res game, this value should usually be set to **infinity**. You may rarely want to set another value if you want tighter control over the view scale and subpixelling.|
|`.viewPixelPerfect`       |boolean|**Defaults to true.** Whether the camera-to-view scale should be a whole number. If you're making a pixel art game, whether you want subpixelling or not, this variable should almost certainly be set to **true**.  |
|`.fullscreen`     |boolean| The fullscreen state for the game. This value is only relevant on desktop platforms (Windows, MacOS, Linux). |
|`.windowWidth, .windowHeight`|number|The size of the game window. This value is only relevant when the game is not fullscreened and is therefore only relevant on desktop platforms (Windows, MacOS, Linux).        |
|`.guiStretchOverWindow` |boolean|Whether to stretch the GUI over the entire window. This is **false** by default meaning that the GUI layer will be stretched over the application surface portion of the window.|
|`.guiTargetWidth,.guiTargetHeight` |number|**Defaults to MinWidth/Height and undefined**. The target width or height for the GUI layer dimensions. To allow [PfCalculate()](PfCalculate) to adapt to different aspect ratios, set one of these variables to **undefined**. In this situation, PictureFrame will adjust the **undefined** dimension to stretch the GUI layer over the window whilst keeping the aspect ratio correct between the GUI width and height.|
|`.surfacePixelPerfect` |boolean|**Defaults to true.** Determines whether the scaling factor applied to the application surface when drawn to the window should be a whole number. If the surface doesn't fit exactly (which is often the case) then the application surface will be drawn centred in the window.|
|`.windowOverscanScale` |number|**Defaults to 1**. Scaling factor to apply to the application surface and GUI at the end of the render pipeline. This is useful to adjust for overscan on old monitors and it is a compliance requirement when releasing on some console platforms. The overscan scale will ignore .surfacePixelPerfect (see above).|
