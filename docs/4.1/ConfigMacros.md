# Configuration Macros

&nbsp;

## `PICTURE_FRAME_VERBOSE`

*Typical value:* `false`

Whether to show large amounts of information describing the decisions that PictureFrame is taking when calculating the render pipeline for your game. This is only useful for debugging and this macro should be set to `false` for production builds.

&nbsp;

## `PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS`

*Typical value:* `true`

Unfortunately, PictureFrame has some compatibility issues with GameMaker's native mouse position getters. This is due to PictureFrame taking control of GameMaker's application surface drawing. Because we're doing it ourselves, GameMaker doesn't understand the relationship between the mouse position in the window and the game camera. The PictureFrame functions `PfMouseX()` and `PfMouseY()` (see [Helper Functions](HelperFunctions)) are provided to work around this problem.

However, it is inconvenient to replace every mouse getter in your game with these functions. Instead we can do some macro tricks (see the `__PfMacroHacks` script) to intercept calls to `mouse_x` and `mouse_y` and redirect them to PictureFrame functions. This is recommended. However, in some cases you may find that this introduces unexpected behaviour (especially if you haven't fully set up PictureFrame yet). Setting this macro to `false` will allow mouse getter functions to operate using the normal native GameMaker behaviour.

&nbsp;

## `PICTURE_FRAME_FIX_NATIVE_DISPLAY_GUI_FUNCTIONS`

*Typical value:* `true`

GameMaker's native GUI layer width/height getter functions have unfortunate behaviour that makes them return incorrect values after calling `display_set_gui_maximize()`. This means `display_get_gui_width()` and `display_get_gui_height()` will return inaccurate values after calling `PfApply()`. Using a similar method to above, PictureFrame can automatically fix `display_get_gui_width()` and `display_get_gui_height()` for you if you set this macro to `true`.

&nbsp;

## `PICTURE_FRAME_IOS_INSET_SCALE`

*Typical value:* `0.66`

Most modern Android and iOS devices have a display cutout ("notch"). PictureFrame can be set up to render into the area either side of the display cutout or it can be set up to avoid the cutout altogether (please see documentation for`.surfaceAvoidNotch` in `PfConfigGeneral()`). The distance from the edge of the physical screen to the safe area is an "inset". Android returns accurate values. However, iOS reports rather large values for its inset area. This macro reduces the size of the inset area so that the iOS safe area more closely matches Android.
