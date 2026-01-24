# PfConfigHighRes

&nbsp;

`PfConfigHighRes(targetWidth, targetHeight, [fullscreen], [minWidth], [minHeight], [maxWidth], [maxHeight])`

**Returns:** Struct, a PictureFrame configuration struct

|Name               |Datatype|Purpose                                                                                                                                                                                 |
|-------------------|--------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`targetWidth`      |number  |                                                                                                                                                                                        |
|`targetHeight`     |number  |                                                                                                                                                                                        |
|`[fullscreen]`     |boolean |Fullscreen state for the game. This value is only relevant on desktop platforms (Windows, MacOS, Linux). If not specified, the fullscreen state for the game will not be changed        |
|`[cameraMinWidth]` |number  |Minimum width for the camera. This is the "safe area" that is guaranteed to be visible                                                                                                  |
|`[cameraMinHeight]`|number  |Minimum height for the camera. This is the "safe area" that is guaranteed to be visible                                                                                                 |
|`[cameraMaxWidth]` |number  |Maximum width for the camera. This is an expansion zone that the camera can grow into to adapt to different resolutions and aspect ratios. If not specified, the minimum width is used  |
|`[cameraMaxHeight]`|number  |Maximum height for the camera. This is an expansion zone that the camera can grow into to adapt to different resolutions and aspect ratios. If not specified, the minimum height is used|

Convenience function that returns a configuration struct set up for high resolution rendering. This function will try to stretch the size of the GUI layer so that its size is close to the target width/height but adjusted to match the aspect ratio of the camera (`.guiMode` is set to `6`). You can edit values in the returned struct if you'd like and it will obey all the same rules as a configuration struct returned by `PfConfigGeneral()`.

!> Because `PfConfigHighRes()` returns a fresh struct every time it is called, you should avoid calling this function more often than is necessary.

&nbsp;

## Configuration Struct

Variables that the configuration struct hold are as follows:

|Name                                         |Datatype|Purpose                                                     |
|---------------------------------------------|--------|------------------------------------------------------------|
|`.cameraTargetWidth`<br>`.cameraTargetHeight`|number  |Target "ideal" camera width and height. PictureFrame will attempt to set the camera to this width and height, adjusting the rendering pipeline within the various constraints defined in the struct|
|`.cameraMinWidth`<br>`.cameraMinHeight`      |number  |Minimum width and height for the camera. This is the "safe area" that is required to be be visible for the game to function properly. Set either of these variables to a negative number to use the target width/height value|
|`.cameraMaxWidth`<br>`.cameraMaxHeight`      |number  |Maximum width and height for the camera. This is an expansion zone that the camera can grow into to adapt to different resolutions and aspect ratios. Set either of these variables to a negative number to use the target width/height value|
|`.cameraOverscan`                            |number  |Number of extra pixels, in roomspace, to add around the edges of the camera. A value of `1` will add one pixel to the left, top, right, and bottom edges leading to a 2 pixel increase in the overall width and height of the camera. Normally you'll want to set this variable to `0` but you may want to set it to higher values if you're implementing visual effects that extend beyond the limits of the camera or you're implementing a smooth scroll effect alongside pixel-perfect graphics|
|`.cameraIgnore`                              |boolean |Whether to never set native GameMaker camera and view properties. This variable only affects what values are set by `PfApply()` and does not change any calculations (camera dimensions, view dimensions, etc.)|
|`.viewMaxScale`                              |number  |Maximum scaling factor from the camera to the view. For pixel perfect games that don't want subpixelling, this value should be set to exactly `1`. If you do want subpixelling, or you're making a high res game, this value should usually be set to `infinity`. You may rarely want to set another value if you want tighter control over the view scale and subpixelling|
|`.viewPixelPerfect`                          |boolean |Whether the camera-to-view scale should be a whole number. If you're making a pixel art game, whether you want subpixelling or not, this variable should almost certainly be set to `true`. Games at high resolutions will likely be fine with this set to `false`|
|`.fullscreen`                                |boolean |Desired fullscreen state for the game. This value is only relevant on desktop platforms (Windows, MacOS, Linux)|
|`.windowWidth`<br>`.windowHeight`            |number  |Desired size of the game window. This value is only relevant when the game is not fullscreened and is therefore only relevant on desktop platforms. These values will only be applied when using `PfApply()` if the window needs to be resized (either the game is already windowed and the `tryResizeWindow` optional parameter is set to `true`, or the game is transitioning from fullscreen to windowed)|
|`.trimBlackBars`                             |boolean |Whether the window should be reduced in size to remove black bars if possible. Like above, this value will only be applied when using `PfApply()` if the `tryResizeWindow` optional parameter is set to `true`|
|`.guiWindowStretch`                          |boolean |Whether to stretch the GUI over the entire window. This is `false` by default meaning that the GUI layer will be stretched over the application surface portion of the window|
|`.guiMode`                                   |number  |Selects the logic used to determine the GUI layer's coordinate space width and height. The default value is `1` which will cause the GUI layer size to be the same as the camera. This variable must be set to one of the following values:<br>`0` = GUI size is the unadjusted windowspace size<br>`1` = GUI size is the same as the camera<br>`2` = GUI size is the same as the application surface / view<br>`3` = GUI size is equal to the target camera size (this often stretches GUI graphics)<br>`4` = GUI size stretches the target GUI width and keeps the target GUI height consistent<br>`5` = GUI size stretches the target GUI height and keeps the target GUI width consistent<br>`6` = PictureFrame decides which target GUI axis to change and keeps the other|
|`.guiTargetWidth`<br>`.guiTargetHeight`      |number  |Target GUI dimensions. These will only be used for certain GUI modes - see above|
|`.guiScale`                                  |number  |Scaling factor to apply to graphics drawn on the GUI layer. To apply no scaling, use a value of `1`. Increasing this value will, perhaps counter-intuitively, reduce the GUI layer's width and height|
|`.guiAvoidNotch`                             |boolean |Whether the GUI layer's coordinate space should avoid the device's notch or camera cut-out. You will still be able to draw GUI graphics in areas of the display around the notch if you use negative coordinates etc. so be careful with how you draw graphics on the GUI layer<br>**N.B.** If you have this variable to set `false` and are running on Android, please ensure that you have the "Display Layout" option set to `LAYOUT_IN_DISPLAY_CUTOUT_MODE_ALWAYS` in your project's Game Options|
|`.surfaceAvoidNotch`                         |boolean |Whether the application surface should avoid the device's notch or camera cut-out. This will slightly reduce the available display area for the application surface<br>**N.B.** If you have this variable to set `false` and are running on Android, please ensure that you have the "Display Layout" option set to `LAYOUT_IN_DISPLAY_CUTOUT_MODE_ALWAYS` in your project's Game Options|
|`.surfacePixelPerfect`                       |boolean |Determines whether the scaling factor applied to the application surface when drawn to the window should be a whole number. If the surface doesn't fit exactly (which is often the case) then the application surface will be drawn centred in the window|
|`.windowOverscanScale`                       |number  |Scaling factor to apply to the application surface and GUI at the end of the render pipeline. This is useful to adjust for overscan on old monitors and it is a compliance requirement when releasing on some console platforms. The overscan scale will ignore `.surfacePixelPerfect` (see above)|