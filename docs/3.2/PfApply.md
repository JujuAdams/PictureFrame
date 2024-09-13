# PfApply

&nbsp;

`PfApply(configStruct, [resizeWindow=false], [ignoreCamera=false])`

**Returns:** Struct, a PictureFrame result struct

|Name            |Datatype|Purpose|
|----------------|--------|-------|
|`configStruct`  |        |       |
|`[resizeWindow]`|        |       |
|`[ignoreCamera]`|        |       |

 Applies a PictureFrame configuration struct, setting necessary native GameMaker values to ensure that the values in the configuration struct accurately affect the game. This function returns the result struct that is generated internally. 

 The `resizeWindow` argument controls whether PictureFrame should resize the game window when calling this function. This guarantees that no black bars will appear when the game is windowed. This value is only relevant when the game is not fullscreened and is therefore only relevant on desktop platforms (Windows, MacOS, Linux).

!> Automatic drawing of the application surface will always be disabled by `PfApply()` by calling `application_surface_draw_enable(false)`. This means that without further action, your game will not be visible. You should call [`PfPostDrawAppSurface()`](PfPostDrawAppSurface) in a Post Draw event to ensure that your application surface is visible for the player.

&nbsp;

## Native Function Calls

`PfApply()` calls the following functions to set native GameMaker values:

### Camera

`PfApply()` presumes that you are using GameMaker's native view system and that you're using view 0 for your game view. If a camera's width or height changes then it will resize, keeping the centre of the view static.

Functions called:

`view_enabled = true`
`view_set_visible(0, true)`
`camera_set_view_pos(view_get_camera(0), ...)`
`camera_set_view_size(view_get_camera(0), ...)`

&nbsp;

### View

`PfApply()` presumes that you are using GameMaker's native view system and that you're using view 0 for your game view.

Functions called:

`view_set_wport(0, ...)`
`view_set_hport(0, ...)`

&nbsp;

### Application Surface

`PfApply()` will set the size of the application surface to match the size of the view.

Functions called:

`surface_resize(application_surface, ...)`

&nbsp;

### Window

If the window's size changes then the window will be resized keeping the centre of the window static on the display. `PfApply()` will only adjust the window when on desktop platforms (Windows, MacOS, Linux).

Functions called:

`window_set_fullscreen(...)`
`window_set_rectangle(...)`

&nbsp;

### GUI Layer

Functions called:

`display_set_gui_maximize(...)`

&nbsp;

## Result Struct

Variables that the result struct holds are as follows:

|Name                                               |Datatype|Purpose                                                     |
|---------------------------------------------------|--------|------------------------------------------------------------|
|`.cameraWidth`<br>`.cameraHeight`                  |number  |Roomspace width and height of the camera            |
|`.cameraOverscan`                                  |number  |Number of extra pixels, in roomspace, to add around the edges of the camera. This is the same literal value as in the configuration struct and is included for convenience|
|`.viewWidth`<br>`.viewHeight`                      |number  |Width and height of the view used to draw the camera to the application surface|
|`.viewScale`                                       |number  |Scaling factor between the camera and the view|
|`.viewOverscan`                                    |number  |Number of extra pixels, in roomspace, to add around the edges of the view. This is equal to .cameraOverscan multiplied by .viewScale and is provided for convenience|
|`.fullscreen`                                      |boolean |Whether the game should be in fullscreen mode. This value is only relevant on desktop platforms (Windows, MacOS, Linux). On other platforms, this will always be `true`|
|`.windowWidth`<br>`windowHeight`                   |number  |Dimensions of the window. If the `.fullscreen` variable (see above) is `true` then these values will be the same as the display's width and height|
|`.surfacePixelPerfect`                             |boolean |Whether the application surface should be drawn as pixel perfect where possible. This will cause [`PfPostDrawAppSurface()`](PfPostDrawAppSurface) to default to no texture filtering to preserve clean pixel edges|
|`.surfacePostDrawScale`                            |number  |Scaling factor between the view and the window (backbuffer). This includes the contribution from the overscan scale from the configuration struct|
|`.surfacePostDrawX`<br>`.surfacePostDrawY`         |number  |Draw position for the application surface in the Post Draw event (i.e. the coordinates in the window/backbuffer). These values are in "window space' and will not necessarily line up with roomspace coordinates|
|`.surfacePostDrawWidth`<br>`.surfacePostDrawHeight`|number  |Size for the application surface in the Post Draw event (see above.) These values are in "window space' and will not necessarily line up with roomspace coordinates|
|`.surfaceGuiX`<br>`.surfaceGuiY`                   |number  |Draw position for the application surface on the GUI layer. These values are in "GUI-space' and will not necessarily line up with roomspace coordinates|
|`.surfaceGuiWidth`<br>`.surfaceGuiHeight`          |number  |Size for the publication surface on the GUI layer. These values are in "GUI-space' and will not necessarily line up with roomspace coordinates|
|`.marginsVisible`                                  |boolean |Whether any of the margins are visible. You should check this variable before drawing the margins (using the variables below)|
|`.marginGuiX1`<br>`.marginGuiY1`<br>…<br>`.marginGuiX4`<br>`.marginGuiY4`|number|Coordinates for the margins around the application surface, in GUI-space|