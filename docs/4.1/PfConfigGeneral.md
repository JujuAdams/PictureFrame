# PfConfigGeneral

&nbsp;

`PfConfigGeneral()`

**Returns:** Struct, a PictureFrame configuration struct

|Name        |Datatype|Purpose|
|------------|--------|-------|
|No arguments|        |       |

Returns a template PictureFrame "configuration struct". The config struct is a set of constraints that are fed into an algorithm that determines the best parameters for rendering. A config struct can be passed into `PfApply()` to automatically set up a rendering pipeline or it can be passed into `PfCalculate()` to generate data that you can apply manually.

Config structs are rather complex and if you're looking for easier "quick start" behaviour than you may want to consider calling either `PfConfigPixelArt()` or `PfConfigHighRes()`  instead. They each return a config struct pre-built for a particular common use case (which can be edited in the exact same way as a config struct returned by `PfConfigGeneral()`).

You should edit the configuration struct returned by this function to reflect the needs of your game.

!> Because a `PfConfigGeneral()` returns a fresh struct every time it is called, you should avoid calling this function more often than is necessary.

&nbsp;

## Configuration Struct

Variables that the configuration struct hold are as follows:

|Name                                   |Datatype|Purpose                                                     |
|---------------------------------------|--------|------------------------------------------------------------|
|`.targetWidth`<br>`.targetHeight`      |number  |Target "ideal" camera width and height. PictureFrame will attempt to set the camera to this width and height, adjusting the rendering pipeline within the various constraints defined in the struct|
|`.cameraMinWidth`<br>`.cameraMinHeight`|number  |Minimum width and height for the camera. This is the "safe area" that is required to be be visible for the game to function properly. Set either of these variables to a negative number to use the target width/height value|
|`.cameraMaxWidth`<br>`.cameraMaxHeight`|number  |Maximum width and height for the camera. This is an expansion zone that the camera can grow into to adapt to different resolutions and aspect ratios. Set either of these variables to a negative number to use the target width/height value|
|`.cameraOverscan`                      |number  |Number of extra pixels, in roomspace, to add around the edges of the camera. A value of `1` will add one pixel to the left, top, right, and bottom edges leading to a 2 pixel increase in the overall width and height of the camera. Normally you'll want to set this variable to `0` but you may want to set it to higher values if you're implementing visual effects that extend beyond the limits of the camera or you're implementing a smooth scroll effect alongside pixel-perfect graphics|
|`.viewMaxScale`                        |number  |Maximum scaling factor from the camera to the view. For pixel perfect games that don't want subpixelling, this value should be set to exactly `1`. If you do want subpixelling, or you're making a high res game, this value should usually be set to `infinity`. You may rarely want to set another value if you want tighter control over the view scale and subpixelling|
|`.viewPixelPerfect`                    |boolean |Whether the camera-to-view scale should be a whole number. If you're making a pixel art game, whether you want subpixelling or not, this variable should almost certainly be set to `true`. Games at high resolutions will likely be fine with this set to `false`|
|`.fullscreen`                          |boolean |Desired fullscreen state for the game. This value is only relevant on desktop platforms (Windows, MacOS, Linux)|
|`.windowWidth`<br>`.windowHeight`      |number  |Desired size of the game window. This value is only relevant when the game is not fullscreened and is therefore only relevant on desktop platforms. These values will only be applied when using `PfApply()` if the window needs to be resized (either the game is already windowed and the `tryResizeWindow` optional parameter is set to `true`, or the game is transitioning from fullscreen to windowed)|
|`.trimBlackBars`                       |boolean |Whether the window should be reduced in size to remove black bars if possible. Like above, this value will only be applied when using `PfApply()` if the `tryResizeWindow` optional parameter is set to `true`|
|`.guiWindowStretch`                    |boolean |Whether to stretch the GUI over the entire window. This is `false` by default meaning that the GUI layer will be stretched over the application surface portion of the window|
|`.guiMode`                             |number  |Selects the logic used to determine the GUI layer's width and height. The default value is `1` which will cause the GUI layer size to be the same as the camera. This variable must be set to one of the following values:<br>`0` = GUI size is the unadjusted windowspace size<br>`1` = GUI size is the same as the camera<br>`2` = GUI size is the same as the application surface / view<br>`3` = GUI size is equal to the target size<br>`4` = GUI size stretches the target width and keeps the target height consistent<br>`5` = GUI size stretches the target height and keeps the target width consistent<br>`6` = GUI size decides which target axis to stretch|
|`.guiTargetWidth`<br>`.guiTargetHeight`|number  |Target GUI dimensions. These will only be used for certain GUI modes - see above|
|`.guiScale`                            |number  |Scaling factor to apply to graphics drawn on the GUI layer. To apply no scaling, use a value of `1`. Increasing this value will, perhaps counter-intuitively, reduce the GUI layer's width and height|
|`.surfacePixelPerfect`                 |boolean |Determines whether the scaling factor applied to the application surface when drawn to the window should be a whole number. If the surface doesn't fit exactly (which is often the case) then the application surface will be drawn centred in the window|
|`.windowOverscanScale`                 |number  |Scaling factor to apply to the application surface and GUI at the end of the render pipeline. This is useful to adjust for overscan on old monitors and it is a compliance requirement when releasing on some console platforms. The overscan scale will ignore `.surfacePixelPerfect` (see above)|