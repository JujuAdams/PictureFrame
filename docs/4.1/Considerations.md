# Considerations For Use

&nbsp;

GameMaker offers a lot of relatively low-level tools for customising the render pipeline. You can adjust cameras, view, the application surface, the GUI layer coordinate space, window dimensions, window borders, display update frequency ... I'm probably forgetting a few. The point of PictureFrame is to avoid having to tweak all of these values which is always time-consuming and often frustrating, especially when deploying across multiple platforms. However, part of the trade-off is that PictureFrame is dealing with a lot of systems and as such expects things to be set up in a certain way. This page goes through the assumptions that PictureFrame makes.

&nbsp;

PictureFrame has a handful of version compatibility requirements:

- You must use GameMaker 2024.14 or later.
- You must use Android SDK 34 or later.
- You must use iOS 11 or later.

Outside of this, PictureFrame is only limited by whatever GameMaker mandates.

&nbsp;

?> The typical case use for PictureFrame is to use [`PfApply()`](PfApply) to manage to render pipeline for you. If you want to use PictureFrame purely as a way to [calculate values](PfCalculate) for you to manually apply yourself then you can ignore the limitations below.

If you intend to use `PfApply()` then you should avoid calling these functions yourself as it will interfere with what PictureFrame has set up:

- `camera_set_view_size(...)` (**pixel art games only**; high resolution games can adjust the camera size freely)
- `view_set_visible(...)`
- `view_set_xport(...)`
- `view_set_yport(...)`
- `view_set_wport(...)`
- `view_set_hport(...)`
- `view_set_camera(...)`
- `surface_resize(application_surface, ...)`
- `window_set_size(...)`
- `window_set_size(...)`
- `window_set_rectangle(...)`
- `display_set_gui_maximize(...)`
- `display_set_gui_size(...)`
- `window_set_min_width(...)`
- `window_set_min_height(...)`
- `window_set_max_width(...)`
- `window_set_max_height(...)`

You should also not set or overwrite the following global variables if you are using `PfApply()` (though you can get these values if you wish):

- `view_enabled`
- `view_camera[]`
- `view_visible[]`
- `view_xport[]`
- `view_yport[]`
- `view_wport[]`
- `view_hport[]`

The following functions are compatible with `PfApply()` and may be called freely:

- `camera_set_view_pos(...)`
- `camera_set_view_angle(...)`
- `camera_set_view_size(...)` (**high resolution games only**; pixel art games should not adjust the camera size)
- `display_reset(...)`
- `display_set_ui_visibility(...)`
- `window_set_showborder(...)`
- `view_set_surface_id(...)`
- `sphere_is_visible(...)`

Further points for consideration:

- PictureFrame as a whole does not support multiple viewports for e.g. splitscreen multiplayer. PictureFrame presumes that view[0] will be the sole camera for the room
- `PfApply()` will automatically set up view[0] and will create a camera for that view. You do not need to do that work yourself
- If you are using `camera_set_view_mat()` and/or `camera_set_proj_mat()` then PictureFrame can still be of assistance but you will need to feed values from the [layout struct](PfCalculate) into your matrices
- If you are using `view_set_surface_id()` or `view_surface_id[]` then you must make sure that the surface size matches the view size