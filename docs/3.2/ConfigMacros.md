# Configuration Macros

&nbsp;

There is only one configuration macro in PictureFrame at the moment:

## `PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS`

*Typical value:* `true`

Unfortunately, PictureFrame has some compatibility issues with GameMaker's native mouse position getters. This is due to PictureFrame taking control of GameMaker's application surface drawing. Because we're doing it ourselves, GameMaker doesn't understand the relationship between the mouse position in the window and the game camera. The PictureFrame functions `PfMouseX()` and `PfMouseY()` (see [Helper Functions](HelperFunctions)) are provided to work around this problem.

However, it is inconvenient to replace every mouse getter in your game with these functions. Instead we can do some macro tricks (see the `__PfMacroHacks` script) to intercept calls to `mouse_x` and `mouse_y` and redirect them to PictureFrame functions. This is recommended. However, in some cases you may find that this introduces unexpected behaviour (especially if you haven't fully set up PictureFrame yet). Setting this macro to `false` will allow mouse getter functions to operate using the normal native GameMaker behaviour.
