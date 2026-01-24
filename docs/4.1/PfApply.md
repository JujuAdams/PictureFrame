# PfApply

&nbsp;

`PfApply(configStruct, [tryResizeWindow=false], [cameraIgnoreForce])`

**Returns:** Struct, a PictureFrame layout struct

|Name                 |Datatype|Purpose                                                                                                                                                        |
|---------------------|--------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`configStruct`       |struct  |PictureFrame configuration struct to apply to the game's render pipeline values                                                                                |
|`[tryResizeWindow]`  |boolean |Whether to allow resizing of the game window to fit the configuration struct. If not specified defaults to `false`                                             |
|`[cameraIgnoreForce]`|boolean |Whether to force ignoring (`true`) or adjusting (`false`) camera settings. If not specified defaults to the `.cameraIgnore` variable in the input config struct|

Applies a PictureFrame configuration struct to the render state for the game, setting up cameras, views, window size etc.  This function calls `PfCalculate()` to generate a layout struct and then uses values from the layout struct to call various GameMaker functions. The layout struct is then returned by `PfApply()` for you to use elsewhere. You can also get the currently applied config and layout structs with `PfGetAppliedConfigStruct()` and `PfGetAppliedLayoutStruct()` respectively.

!> Automatic drawing of the application surface will always be disabled by `PfApply()` by calling `application_surface_draw_enable(false)`. This means that without further action, your game will not be visible. You should call `PfPostDrawAppSurface()` in a Post Draw event to ensure that your application surface is visible for the player.

There are some optional parameters that affect how the layout struct is applied. The `tryResizeWindow` parameter applies when the game is already windowed or is transitioning from fullscreen to a windowed state (as such, it only applies on desktop platforms). When `tryResizeWindow` is set to `true`, the function will change the size and position of the window, including trimming extra space if the `.trimBlackBars` option has been set in the input configuration struct.

`cameraIgnoreForce` is an optional parameter that allows you to override the `.cameraIgnore` variable in the layout struct. If set to `true` or `false` then that behaviour will be enforced. Regardless of whether the native GameMaker is ignored, you can still use the two camera size variables, `.cameraWidth` and `.cameraHeight`, from the returned layout struct to setup whatever you need yourself.

!> Because `PfApply()` runs a lot of logic and returns a fresh struct every time it is called, you should avoid calling this function more often than is necessary.

&nbsp;

## Native Function Calls

`PfApply()` calls the following functions to set native GameMaker values:

### Camera

These will only be adjusted if the `.cameraIgnore` variable in the layout struct is set to `false` or the optional `cameraIgnoreForce` parameter for this function is set to `false`. `PfApply()` presumes that you are using GameMaker's native view system and that you're using view[0] for your game view and will set up view[0] for rendering. If `PfApply()` causes a camera's width or height to change then it will resize keeping the centre of the camera pointing at the same roomspace position.

Functions called:

```gml
view_enabled = true
view_set_visible(0, true)
camera_set_view_pos(view_get_camera(0), ...)
camera_set_view_size(view_get_camera(0), ...)
```

&nbsp;

### Application Surface

`PfApply()` will set the size of the application surface to match the size of the view. For pixel perfect configurations, the size of the view is usually the same size as the camera but edge cases exist and this isn't guaranteed.

Functions called:

```gml
surface_resize(application_surface, ...)
```

&nbsp;

### View

`PfApply()` presumes that you are using GameMaker's native view system and that you're using view[0] for your game view. If you are using a custom system of some kind then you should use the layout struct returned by `PfApply()` to update that system. Viewport dimensions will only be adjusted if `view_enable` is set to `true` and view[0] is visible (both of these conditions might be met, see "Camera position and size" above).

Functions called:

```gml
view_set_xport(0, 0)
view_set_yport(0, 0)
view_set_wport(0, ...)
view_set_hport(0, ...)
```

&nbsp;

### Window & Fullscreen

Window position and size, including fullscreen state. If the window's size changes then the window will be resized keeping the centre of the window static on the display. `PfApply()` will only adjust the window when on desktop platforms (Windows, MacOS, Linux).

Functions called:

```gml
window_set_fullscreen(...)
window_set_rectangle(...)
```

&nbsp;

### GUI Layer

The exact size that gets set is controlled by the `.guiMode` variable found in the configuration struct.

Functions called:

```gml
display_set_gui_maximize(...)
```

&nbsp;

## Layout Struct

Variables that the layout struct holds are as follows:

|Name                                               |Datatype|Purpose                                                     |
|---------------------------------------------------|--------|------------------------------------------------------------|
|`.cameraWidth`<br>`.cameraHeight`                  |number  |Roomspace width and height of the camera. This includes overscan pixels, if defined|
|`.cameraOverscan`                                  |number  |Number of extra pixels, in roomspace, to add around the edges of the camera. This is the same literal value as in the configuration struct and is included for convenience|
|`.cameraIgnore`                                    |boolean |Whether to not set camera and view properties when calling `PfApply()`|
|`.viewWidth`<br>`.viewHeight`                      |number  |Width and height of the view used to draw the camera to the application surface. This includes overscan pixels, if defined. When using `PfApply()`, the application surface size will match the view width and height|
|`.viewScale`                                       |number  |Scaling factor between the camera and the view. A scaling factor of 2 means that there will be 2 pixels on the view for every 1 pixel in roomspace on the camera. A view scale of exactly 1 is therefore a pixel perfect view|
|`.viewOverscan`                                    |number  |Number of extra pixels, in viewspace, that have been added around the edges of the view. This is equal to `.cameraOverscan` multiplied by `.viewScale` and is provided for convenience|
|`.fullscreen`                                      |boolean |Whether the game should be in fullscreen mode. This value is only relevant on desktop platforms (Windows, MacOS, Linux). On other platforms, this will always be `true`|
|`.windowWidth`<br>`.windowHeight`                  |number  |Dimensions of the window. If the `.fullscreen` variable (see above) is `true` then these values will be the same as the display's width and height|
|`.guiX`<br>`.guiY`                                 |number  |Coordinates of the top-left corner of the GUI layer in windowspace|
|`.guiWidth`<br>`.guiHeight`                        |number  |Width and height of the GUI layer|
|`.surfacePixelPerfect`                             |boolean |Whether the application surface should be drawn as pixel perfect where possible. This will cause `PfPostDrawAppSurface()` to default to no texture filtering to preserve clean pixel edges|
|`.surfacePostDrawScale`                            |number  |Scaling factor between the view and the window (backbuffer). This includes the contribution from the overscan scale from the configuration struct|
|`.surfacePostDrawX`<br>`.surfacePostDrawY`         |number  |Draw position for the application surface in the Post Draw event (i.e. the coordinates in the window/backbuffer). These values are in "window space' and will not necessarily line up with roomspace coordinates|
|`.surfacePostDrawWidth`<br>`.surfacePostDrawHeight`|number  |Size for the application surface in the Post Draw event (see above.) These values are in "window space' and will not necessarily line up with roomspace coordinates|
|`.windowToGuiScaleX`<br>`.windowToGuiScaleY`       |number  |Scaling factor to convert window coordinates to GUI layer coordinates|
|`.surfaceGuiX`<br>`.surfaceGuiY`                   |number  |Draw position for the application surface on the GUI layer. These values are in "GUI-space' and will not necessarily line up with roomspace coordinates|
|`.surfaceGuiWidth`<br>`.surfaceGuiHeight`          |number  |Size for the publication surface on the GUI layer. These values are in "GUI-space' and will not necessarily line up with roomspace coordinates|
|`.marginsVisible`                                  |boolean |Whether any of the margins are visible. You should check this variable before drawing the margins (using the variables below)|
|`.marginWestX1`<br>…<br>`.marginSouthY2`           |number  |Coordinates for the margins around the application surface, in GUI-space|