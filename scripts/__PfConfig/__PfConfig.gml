// Feather disable all

/// Unfortunately, PictureFrame has some compatibility issues with GameMaker's native mouse
/// position getters. This is due to PictureFrame taking control of GameMaker's application surface
/// drawing. Because we're doing it ourselves, GameMaker doesn't understand the relationship
/// between the mouse position in the window and the game camera. The PictureFrame functions
/// `PfMouseX()` and `PfMouseY()` are provided to work around this problem.
/// 
/// However, it is inconvenient to replace every mouse getter in your game with these functions.
/// Instead we can do some macro tricks (see the `__PfMacroHacks` script) to intercept calls to
/// "mouse_x" etc. and redirect them to PictureFrame functions. This is recommended. However, in
/// some cases you may find that this introduces unexpected behaviour (especially if you haven't
/// fully set up PictureFrame yet). Setting this macro to `false` will allow mouse getter functions
/// to operate using the normal native GameMaker behaviour.

#macro PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS  true

/// GameMaker's native GUI layer width/height getter functions have unfortunate behaviour that
/// makes them return incorrect values after calling `display_set_gui_maximize()`. This means
/// `display_get_gui_width()` and `display_get_gui_height()` will return inaccurate values after
/// calling `PfApply()`. Using a similar method to above, PictureFrame can automatically fix
/// `display_get_gui_width()` and `display_get_gui_height()` for you if you set this macro to `true`. 

#macro PICTURE_FRAME_FIX_NATIVE_DISPLAY_GUI_FUNCTIONS  true
